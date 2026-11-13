# modern-site-template

A template for a project's website: one home page (`site/index.html`) and a `CHANGELOG.md` become the published site. The
steps are gui_toolkit's `gt:site` package, in the submodule `ext/gui_toolkit` (collection `gt`).

Read first: [README.md](README.md).

## Build and check

Every step is a command of `tools/sitetool` (`help` lists them):

    odin run tools/sitetool -collection:gt=ext/gui_toolkit/src -out:build/sitetool -keep-executable -- <command>

- `site build site build/site` makes the site in `build/site`.
- `site check [--shot file.png]` serves the site on this machine and checks its pages in a real browser.
- `changelog check` checks the fragments of `changelog.d/`.
- `build.sh` / `build.bat` are shortcuts: `./build.sh site build site build/site`.
- `nix develop` first (`flake.nix`). `nix build` makes the site in `result/`; `nix flake check` builds it and runs the
  hooks. The Pages workflow runs `nix build`.

## Rules

- `site/`, `CHANGELOG.md` and `tools/sitetool/site.odin` are example content about a fictional "Example project". Keep
  them coherent; they are what the demo shows.
- What the site's build needs goes in gui_toolkit's `gt:site`, generic, with its docs, test and changelog fragment; the
  template then points to the toolkit's new tag.
- A change a user can see is a fragment of `changelog.d/` (`sitetool changelog new`, its README), in the same commit.
  `CHANGELOG.md` is never edited by hand.
- Automation is a command of `tools/sitetool`, never a shell, batch, PowerShell, Python or Node script.
- Comments and commit messages are in English. Comments say why.
- Commits: author and committer `sachahjkl <sacha@sacha.house>`, no attribution trailer, no session link.
