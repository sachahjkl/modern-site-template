{
  description = "modern-site-template: a project's website built from its home page and its CHANGELOG.md";

  inputs = {
    self.submodules = true;
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2605";
    git-hooks = {
      url = "https://flakehub.com/f/cachix/git-hooks.nix/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    git-hooks,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # The Odin release gui_toolkit is built with (its own flake pins the same one).
    odin = pkgs.stdenv.mkDerivation {
      pname = "odin";
      version = "dev-2026-11a";
      src = pkgs.fetchurl {
        url = "https://github.com/odin-lang/Odin/releases/download/dev-2026-11a/odin-linux-amd64-dev-2026-11a.tar.gz";
        sha256 = "65c9f6e97d6f8a30930e151f270ce5aeaa98fe8b2ba49fe067394e2af04f7618";
      };
      nativeBuildInputs = [pkgs.makeWrapper];
      dontBuild = true;
      dontPatchELF = true;
      installPhase = ''
        mkdir -p $out/lib/odin $out/bin
        cp -r . $out/lib/odin
        makeWrapper $out/lib/odin/odin $out/bin/odin --set-default ODIN_ROOT $out/lib/odin/ --prefix PATH : ${pkgs.lib.makeBinPath [pkgs.clang pkgs.lld]}
      '';
    };

    # The published site, as the Pages workflow makes it.
    site = pkgs.stdenv.mkDerivation {
      pname = "site";
      version = "0";
      src = self;
      nativeBuildInputs = [odin];
      buildPhase = ''
        export HOME=$TMPDIR
        odin run tools/sitetool -collection:gt=ext/gui_toolkit/src -out:$TMPDIR/sitetool -- site build site $out
      '';
      dontInstall = true;
    };

    preCommitCheck = git-hooks.lib.${system}.run {
      package = pkgs.prek;
      src = ./.;
      excludes = ["^ext/"]; # gui_toolkit, a submodule with hooks of its own
      hooks = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
        check-yaml.enable = true;
        end-of-file-fixer.enable = true;
        trim-trailing-whitespace.enable = true;
      };
    };
  in {
    packages.${system}.default = site;
    checks.${system} = {
      inherit site;
      pre-commit = preCommitCheck;
    };
    formatter.${system} = pkgs.alejandra;
    devShells.${system}.default = pkgs.mkShell {
      packages = [odin] ++ preCommitCheck.enabledPackages;
      inherit (preCommitCheck) shellHook;
    };
  };
}
