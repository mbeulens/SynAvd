# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-08-19

First working release. Runs the Azure Virtual Desktop web client as a
standalone desktop app on Linux.

### Added

- `bin/synavd` — launcher that opens the AVD / Windows App web client in a
  Chrome `--app` window. Uses a dedicated `--user-data-dir`, so the AVD session
  is isolated from the everyday browser profile and closing or clearing normal
  Chrome no longer signs you out. Sets `--class` and `--name` to `SynAVD` so the
  window carries its own `WM_CLASS`. Supports `--reset`, `--profile` and
  `--help`, plus the `SYNAVD_URL`, `SYNAVD_PROFILE` and `SYNAVD_BROWSER`
  environment overrides, and falls back across Chrome, Chromium, Brave and Edge.
- `share/synavd.desktop.in` — desktop entry template with
  `StartupWMClass=SynAVD`, so the dock shows the app under its own icon instead
  of grouping it under Google Chrome. Includes a *Reset session* desktop action.
- `share/icons/synavd.svg` — scalable application icon.
- `install.sh` — user-level installer, no root required. Installs into
  `~/.local`, substitutes the launcher path into the desktop entry, and
  refreshes the desktop and icon caches. `--uninstall` removes the launcher,
  entry and icon while preserving the browser profile.
- `README.md` — install, usage and design rationale.

### Verified

Ubuntu, GNOME on X11, Google Chrome from the `.deb` package. The app window
reports `WM_CLASS = "SynAVD", "SynAVD"`, `desktop-file-validate` passes without
warnings, and the client loads through Microsoft SSO to the devices list.

## [0.1.0] - 2026-08-19

### Added

- Initial repository scaffold.

[0.2.0]: https://github.com/mbeulens/SynAvd/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/mbeulens/SynAvd/releases/tag/v0.1.0
