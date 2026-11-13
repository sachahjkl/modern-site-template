package sitetool

// What this site is: its address, its names, its colours and its downloads. The rest of the tool reads them from here.
// Replace every value: they describe the fictional "Example project" of the template.

import tk_site "gt:site"
import toolbox "gt:toolbox"

VERSION_MARK :: "{{version}}"   // in site/index.html: the last version of CHANGELOG.md
REPOSITORY   :: "https://github.com/sachahjkl/modern-site-template"
CHANGELOG    :: "CHANGELOG.md"

// The project, for the changelog command: its changelog and its repository (the versions' links). A program's project
// also names its version line and its release build (toolbox.Project).
PROJECT :: toolbox.Project{
	name       = "example",
	repository = REPOSITORY,
	changelog  = CHANGELOG,
}

SITE_META :: tk_site.Meta{
	url         = "https://sachahjkl.github.io/modern-site-template/",
	name        = "Example project",
	repository  = REPOSITORY,
	tagline     = "A short line that says what the project is",
	changes     = CHANGELOG,
	card        = "img/main.png",      // the picture a shared link shows
	logo        = "img/logo.png",
	logo_file   = "site/img/logo.png",
	theme       = "#141416",           // the browser's bar on a phone: the page's colour
	accent      = "#e8a33d",
	author      = "Sacha Froment",
	author_url  = "https://froment.software",
	publisher   = "Froment Software",
	ld_type     = "SoftwareApplication",
	root_domain = false,               // true: the site owns its domain (robots.txt and favicon.ico at its root)
}

// What a search engine reads about the program (schema.org SoftwareApplication).
@(rodata)
SITE_LD := [?][2]string{
	{"applicationCategory", "UtilitiesApplication"},
	{"operatingSystem", "Windows, Linux"},
	{"license", "https://opensource.org/license/mit"},
}

// The home page's download button, one per system: the reader's own is shown, the first one when it is not known.
@(rodata)
SITE_DOWNLOADS := [?]tk_site.Download{
	{os = "windows", label = "Windows", href = "https://github.com/sachahjkl/modern-site-template/releases/download/v{{version}}/example-{{version}}-windows-x64.zip", detail = "v{{version}} · Windows 10 / 11 · x64 · .zip"},
	{os = "linux", label = "Linux", href = "https://github.com/sachahjkl/modern-site-template/releases/download/v{{version}}/example-{{version}}-linux-x64.tar.gz", detail = "v{{version}} · x64 · .tar.gz"},
}

// SITE_META with its structured data (a constant cannot hold a slice).
site_meta :: proc() -> tk_site.Meta {
	m := SITE_META
	m.ld_fields = SITE_LD[:]
	return m
}
