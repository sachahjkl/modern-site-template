# changelog.d

One file per change a user can see, assembled into `CHANGELOG.md` when a version is published (a project's tool's `ship`,
gui_toolkit's `gt:release`). A change adds its fragment here and never edits `CHANGELOG.md`: two branches never conflict
on it. A change with no effect a user can see has no fragment.

A fragment is `changelog.d/<yyyyMMdd-HHmmss>-<subject>.md` (subject: lowercase letters, digits and `-`):

```
type: Added

**A short bold summary**: what changed for the user, not how the code changed.
```

`type` is `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed` or `Security`. The text is one entry of the list; it may
span lines, with no blank line and no heading.

`sitetool changelog new <type> <text> [-subject:<subject>]` writes one; `changelog check` says whether they are all well
formed; `changelog preview` prints what the next version brings. The format is gui_toolkit's (`gt:changelog`, its
docs/changelog.md).
