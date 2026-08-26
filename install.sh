#!/bin/bash

# MPV Configuration Installer
# Bundles all scripts locally — no internet needed after clone.
# Existing files are preserved (not overwritten) so customizations survive.
#
# Usage:
#   git clone https://github.com/njobvulabs/mpv-config /tmp/mpv-config
#   bash /tmp/mpv-config/install.sh
#
# Or if already cloned directly to ~/.config/mpv:
#   bash ~/.config/mpv/install.sh

set -e

MPV_DIR="${HOME}/.config/mpv"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== MPV Config Installer ==="
echo ""

# If source is different from destination, copy new files over
if [ "$SCRIPT_DIR" != "$MPV_DIR" ]; then
    echo "Installing from ${SCRIPT_DIR}..."
    echo "(Existing files will NOT be overwritten.)"
    echo ""

    mkdir -p "$MPV_DIR"/{scripts,script-opts,script-modules,fonts}
    mkdir -p "$MPV_DIR/script-modules/file-browser"
    mkdir -p "$MPV_DIR/script-modules/file-browser-addons"

    cp -n "$SCRIPT_DIR/mpv.conf" "$MPV_DIR/mpv.conf" 2>/dev/null || true
    cp -n "$SCRIPT_DIR/input.conf" "$MPV_DIR/input.conf" 2>/dev/null || true

    [ -d "$SCRIPT_DIR/scripts" ] && cp -rn "$SCRIPT_DIR/scripts/"* "$MPV_DIR/scripts/" 2>/dev/null || true
    [ -d "$SCRIPT_DIR/script-opts" ] && cp -rn "$SCRIPT_DIR/script-opts/"* "$MPV_DIR/script-opts/" 2>/dev/null || true
    [ -d "$SCRIPT_DIR/script-modules" ] && cp -rn "$SCRIPT_DIR/script-modules/"* "$MPV_DIR/script-modules/" 2>/dev/null || true
    [ -d "$SCRIPT_DIR/fonts" ] && cp -rn "$SCRIPT_DIR/fonts/"* "$MPV_DIR/fonts/" 2>/dev/null || true

    echo "Files copied (skipped existing)."
else
    echo "Files already in ${MPV_DIR} (running from clone location)."
fi

# Verify all expected files are present
echo ""
echo "Verifying installation..."
MISSING=()
for dir in scripts script-opts script-modules fonts; do
    [ -d "$MPV_DIR/$dir" ] || MISSING+=("Missing directory: $dir/")
done

EXPECTED_SCRIPTS=(
    modernz.lua thumbfast.lua pause_indicator_lite.lua autoload.lua
    sponsorblock_minimal.lua celebi.lua file-browser.lua playlistmanager.lua
    pip_lite.lua ytdlautoformat.lua boxtowide.lua clipshot.lua evafast.lua
)
for s in "${EXPECTED_SCRIPTS[@]}"; do
    [ -f "$MPV_DIR/scripts/$s" ] || MISSING+=("Missing script: scripts/$s")
done

for f in mpv.conf input.conf script-opts/modernz.conf script-opts/thumbfast.conf script-opts/pip_lite.conf; do
    [ -f "$MPV_DIR/$f" ] || MISSING+=("Missing config: $f")
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo "Warning: some files are missing:"
    for m in "${MISSING[@]}"; do
        echo "  - $m"
    done
    echo "Re-clone the repo and run again."
    exit 1
fi

echo "All 13 scripts present."
echo ""
echo "=== Installation Complete ==="
echo ""
echo "Restart mpv to apply changes."
echo ""
echo "Key bindings:"
echo "  SPACE     Pause/Resume"
echo "  s/S       Stop/Quit"
echo "  n/p       Next/Previous"
echo "  UP/DOWN   Volume"
echo "  m         Mute"
echo "  f         Fullscreen"
echo "  a         Audio track"
echo "  j         Subtitle"
echo "  F1        File browser"
echo "  Ctrl+p    Picture-in-Picture"
echo "  e         Smart seek"
echo ""
