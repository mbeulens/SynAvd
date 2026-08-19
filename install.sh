#!/usr/bin/env bash
#
# install.sh — install (or remove) the SynAVD launcher for the current user.
# Everything lands under ~/.local, so no root is needed.

set -euo pipefail

SRC="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
BINDIR="$HOME/.local/bin"
APPDIR="$DATA_HOME/applications"
ICONDIR="$DATA_HOME/icons/hicolor/scalable/apps"

refresh_caches() {
    command -v update-desktop-database >/dev/null && \
        update-desktop-database "$APPDIR" 2>/dev/null || true
    command -v gtk-update-icon-cache >/dev/null && \
        gtk-update-icon-cache -qtf "$DATA_HOME/icons/hicolor" 2>/dev/null || true
}

uninstall() {
    rm -f -- "$BINDIR/synavd" \
             "$APPDIR/synavd.desktop" \
             "$ICONDIR/synavd.svg"
    refresh_caches
    echo "Removed the launcher, desktop entry and icon."
    echo "The browser profile was kept: $DATA_HOME/synavd/profile"
    echo "Delete it with: rm -rf '$DATA_HOME/synavd'"
}

install_all() {
    mkdir -p -- "$BINDIR" "$APPDIR" "$ICONDIR"

    install -m 0755 -- "$SRC/bin/synavd"          "$BINDIR/synavd"
    install -m 0644 -- "$SRC/share/icons/synavd.svg" "$ICONDIR/synavd.svg"

    sed "s|@BINDIR@|$BINDIR|g" -- "$SRC/share/synavd.desktop.in" \
        > "$APPDIR/synavd.desktop"
    chmod 0644 -- "$APPDIR/synavd.desktop"

    refresh_caches

    echo "Installed:"
    echo "  launcher      $BINDIR/synavd"
    echo "  desktop entry $APPDIR/synavd.desktop"
    echo "  icon          $ICONDIR/synavd.svg"
    echo
    echo "Look for 'Azure Virtual Desktop' in the Activities overview,"
    echo "or run: $BINDIR/synavd"
}

case "${1:-}" in
    ""|--install) install_all ;;
    --uninstall)  uninstall ;;
    --help|-h)    echo "Usage: ./install.sh [--install | --uninstall]" ;;
    *)            echo "install.sh: unknown option '$1'" >&2; exit 2 ;;
esac
