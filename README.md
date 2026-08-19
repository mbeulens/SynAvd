# SynAVD

Version: 0.2.0

A standalone desktop app for the **Azure Virtual Desktop / Windows App web
client** on Linux, for when there is no supported native client and the browser
tab is not good enough.

It is a thin wrapper: Chrome running in `--app` mode against
`windows.cloud.microsoft`, with its own isolated browser profile, its own icon
and its own entry in the taskbar / dock.

## Why

- **A real app window** — no tabs, no address bar, no bookmarks bar. It looks
  and behaves like a separate program.
- **Its own taskbar icon** — the window sets `WM_CLASS=SynAVD`, which the
  desktop entry matches via `StartupWMClass`, so it never gets grouped under
  Google Chrome.
- **Its own session** — the profile lives in `~/.local/share/synavd/profile`,
  entirely separate from your normal Chrome. Closing, restarting or clearing
  your everyday browser does not sign you out of AVD.

## Install

```bash
git clone https://github.com/mbeulens/SynAvd.git
cd SynAvd
./install.sh
```

Everything is installed under `~/.local`, so no root is required:

| What          | Where                                                 |
| ------------- | ----------------------------------------------------- |
| Launcher      | `~/.local/bin/synavd`                                 |
| Desktop entry | `~/.local/share/applications/synavd.desktop`          |
| Icon          | `~/.local/share/icons/hicolor/scalable/apps/synavd.svg` |
| Browser profile | `~/.local/share/synavd/profile`                     |

Then launch **Azure Virtual Desktop** from the Activities overview, and pin it
to the dock. On the first run, tick *Keep me signed in* at the Microsoft prompt
so the session survives restarts.

To remove the launcher again (the profile is kept):

```bash
./install.sh --uninstall
```

## Usage

```
synavd            Open the AVD web client in its app window.
synavd --reset    Delete the isolated profile (signs you out, clears cache).
synavd --profile  Print the profile directory path.
synavd --help     Show help.
```

### Environment overrides

| Variable         | Default                                                     |
| ---------------- | ----------------------------------------------------------- |
| `SYNAVD_URL`     | `https://windows.cloud.microsoft/?navFrom=avdweb#/devices`   |
| `SYNAVD_PROFILE` | `~/.local/share/synavd/profile`                             |
| `SYNAVD_BROWSER` | first of `google-chrome`, `chromium`, `brave-browser`, `microsoft-edge` found |

## Requirements

- A Chromium-based browser (Google Chrome recommended; the `.deb` build rather
  than the snap, since the snap confinement complicates `--user-data-dir`).
- A freedesktop-compliant desktop environment. Verified on Ubuntu with
  GNOME on X11.

## Notes

- The isolated profile has no extensions and no Chrome sync. That is deliberate
  — it keeps the AVD session self-contained and predictable.
- If clipboard or audio redirection misbehaves, that is the web client itself,
  not the wrapper; the same behaviour occurs in a normal tab.

## Branches

- `master` — stable, release branch
- `dev` — active development (all work happens here)

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## Versioning

Semantic versioning. Patch bumps on every commit to `dev`; minor/major bumps
are cut from `dev` and merged into `master`.
