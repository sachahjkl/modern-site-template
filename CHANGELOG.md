# Changelog

All notable changes to Example project are listed here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the versions follow [semantic versioning](https://semver.org/).

## [1.3.0] - 2026-11-02

### Added
- **A search in the list**: type to keep only the lines that hold every word.
- **`example export`**: the list as JSON on the standard output.

### Fixed
- **Long names no longer overflow their column**: they end with an ellipsis, the whole name in a tooltip.

## [1.2.0] - 2026-09-15

### Added
- **A light version of the theme**: it follows the system's setting, or the one you choose.

### Changed
- **It starts in 30 ms instead of 80**: the list is read from the disk after the window shows.

## [1.1.1] - 2026-08-20

### Fixed
- **A crash when the configuration file was empty**: an empty file now means the defaults.

## [1.1.0] - 2026-08-02

### Added
- **Pinned lines**: Ctrl+P keeps a line at the top, whatever the order.

### Removed
- **The `--legacy` option**: its behaviour is the default since 1.0.

## [1.0.0] - 2025-12-01

### Added
- **The first version**: the list, the window, the command line.

[1.3.0]: https://github.com/sachahjkl/modern-site-template/releases/tag/v1.3.0
[1.2.0]: https://github.com/sachahjkl/modern-site-template/releases/tag/v1.2.0
[1.1.1]: https://github.com/sachahjkl/modern-site-template/releases/tag/v1.1.1
[1.1.0]: https://github.com/sachahjkl/modern-site-template/releases/tag/v1.1.0
[1.0.0]: https://github.com/sachahjkl/modern-site-template/releases/tag/v1.0.0
