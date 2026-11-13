// sitetool: the site's commands, one program, whatever the shell.
//
//   odin run tools/sitetool -collection:gt=ext/gui_toolkit/src -out:build/sitetool -keep-executable -- <command>
//   (build.sh and build.bat are its shortcuts)
//
// The commands are gui_toolkit's (gt:toolbox, gt:site, gt:changelog; ext/gui_toolkit/docs/toolbox.md and site.md):
//   site build <site> <out>     the pages of <site> and CHANGELOG.md into <out>: what is published
//   site check [--shot file.png] [--browser program]
//                               the pages in a real browser (Chrome, Chromium or Edge), served on this machine
//   site card                   draws the sharing card again, in a local browser (once, by hand)
//   changelog new | check | preview
//                               the fragments of changelog.d/, one per change a user can see
// site.odin says what this site is.
package sitetool

import changelog "gt:changelog"
import tk_site "gt:site"
import toolbox "gt:toolbox"

main :: proc() {
	toolbox.tool_main("sitetool", {
		tk_site.command({meta = site_meta(), pages = {version_mark = VERSION_MARK, downloads = SITE_DOWNLOADS[:]}}),
		changelog.command(PROJECT),
	}, toolbox.ROOT_MARK_DEFAULT)
}
