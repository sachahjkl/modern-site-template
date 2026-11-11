package sitetool

// The site's commands. The steps are gui_toolkit's (gt:site, ext/gui_toolkit/docs/site.md); site.odin says what this
// site is.
//   sitetool build [out]     the pages of site/ and CHANGELOG.md into out (_site by default): what is published
//   sitetool check [--shot file.png] [--browser program]
//                            the pages in a real browser (Chrome, Chromium or Edge), served on this machine
//   sitetool card            draws img/main.png's sharing card again, in a local browser (once, by hand)

import "core:fmt"
import "core:os"
import tk_site "gt:site"

EXIT_USAGE :: 2

USAGE :: `sitetool build [out] | check [--shot file.png] [--browser program] | card`

main :: proc() {
	args := os.args[1:]
	what := len(args) > 0 ? args[0] : ""
	switch what {
	case "build":
		if len(args) > 2 { break }
		out := len(args) == 2 ? args[1] : "_site"
		if !build_changelog(SITE_DIR, out) { os.exit(1) }
		if !tk_site.build_meta(meta(), out, out) { os.exit(1) }
		fmt.printfln("the site: %s", out)
		return
	case "check":
		o := tk_site.Check_Options{site = SITE_DIR, generate = build_changelog}
		if why := tk_site.check_arguments(args[1:], &o); why != "" { fmt.eprintfln("sitetool check: %s", why); os.exit(EXIT_USAGE) }
		if !tk_site.check(o) { os.exit(1) }
		return
	case "card":
		if len(args) != 1 { break }
		if !tk_site.draw_card(meta(), SITE_DIR) { os.exit(1) }
		return
	}
	fmt.eprintln(USAGE)
	os.exit(EXIT_USAGE)
}

// The home page with its "What's new", the changelog's page, the classic version.
build_changelog :: proc(site, out: string) -> bool {
	downloads := SITE_DOWNLOADS
	return tk_site.build_changelog(site, out, {changes = CHANGELOG, version_mark = VERSION_MARK, downloads = downloads[:]})
}

// SITE_META with its structured data (a constant cannot hold a slice).
meta :: proc() -> tk_site.Meta {
	m := SITE_META
	ld := SITE_LD
	m.ld_fields = make([][2]string, len(ld), context.temp_allocator)
	copy(m.ld_fields, ld[:])
	return m
}
