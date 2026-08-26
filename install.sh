#!/bin/bash

# MPV Configuration Installer
# Installs ModernZ OSC, scripts, and keybindings
# Usage: bash install.sh

set -e

MPV_DIR="${HOME}/.config/mpv"
SCRIPTS_DIR="${MPV_DIR}/scripts"
FONTS_DIR="${MPV_DIR}/fonts"
OPTS_DIR="${MPV_DIR}/script-opts"
MODULES_DIR="${MPV_DIR}/script-modules"

echo "=== MPV Config Installer ==="
echo ""

# Create directories
echo "Creating directories..."
mkdir -p "${SCRIPTS_DIR}" "${FONTS_DIR}" "${OPTS_DIR}" "${MODULES_DIR}"
mkdir -p "${MODULES_DIR}/file-browser"
mkdir -p "${MODULES_DIR}/file-browser-addons"

# ModernZ OSC
echo "Installing ModernZ OSC..."
curl -fsSL -o "${SCRIPTS_DIR}/modernz.lua" https://github.com/Samillion/ModernZ/releases/download/v0.3.3/modernz.lua
curl -fsSL -o "${FONTS_DIR}/modernz-icons.ttf" https://github.com/Samillion/ModernZ/releases/download/v0.3.3/modernz-icons.ttf
curl -fsSL -o "${OPTS_DIR}/modernz.conf" https://github.com/Samillion/ModernZ/releases/download/v0.3.3/modernz.conf

# Thumbfast
echo "Installing thumbfast..."
curl -fsSL -o "${SCRIPTS_DIR}/thumbfast.lua" https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua
curl -fsSL -o "${OPTS_DIR}/thumbfast.conf" https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.conf

# Pause Indicator Lite
echo "Installing pause indicator..."
curl -fsSL -o "${SCRIPTS_DIR}/pause_indicator_lite.lua" https://raw.githubusercontent.com/Samillion/ModernZ/main/extras/pause-indicator-lite/pause_indicator_lite.lua

# Autoload
echo "Installing autoload..."
curl -fsSL -o "${SCRIPTS_DIR}/autoload.lua" https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua

# SponsorBlock
echo "Installing sponsorblock..."
curl -fsSL -o "${SCRIPTS_DIR}/sponsorblock_minimal.lua" https://codeberg.org/jouni/mpv_sponsorblock_minimal/raw/branch/master/sponsorblock_minimal.lua

# Celebi
echo "Installing celebi..."
curl -fsSL -o "${SCRIPTS_DIR}/celebi.lua" https://raw.githubusercontent.com/po5/celebi/master/celebi.lua

# File Browser
echo "Installing file browser..."
curl -fsSL -o "${SCRIPTS_DIR}/file-browser.lua" https://raw.githubusercontent.com/CogentRedTester/mpv-file-browser/master/main.lua
curl -fsSL https://api.github.com/repos/CogentRedTester/mpv-file-browser/contents/modules 2>/dev/null | grep -oP '"download_url": "\K[^"]*' | while read url; do
    curl -fsSL -o "${MODULES_DIR}/file-browser/$(basename "$url")" "$url"
done
curl -fsSL https://api.github.com/repos/CogentRedTester/mpv-file-browser/contents/addons 2>/dev/null | grep -oP '"download_url": "\K[^"]*' | while read url; do
    curl -fsSL -o "${MODULES_DIR}/file-browser-addons/$(basename "$url")" "$url"
done

# Playlist Manager
echo "Installing playlist manager..."
curl -fsSL -o "${SCRIPTS_DIR}/playlistmanager.lua" https://raw.githubusercontent.com/jonniek/mpv-playlistmanager/master/playlistmanager.lua

# PiP Lite
echo "Installing PiP Lite..."
curl -fsSL -o "${SCRIPTS_DIR}/pip_lite.lua" https://raw.githubusercontent.com/Samillion/ModernZ/main/extras/pip-lite/pip_lite.lua
curl -fsSL -o "${OPTS_DIR}/pip_lite.conf" https://raw.githubusercontent.com/Samillion/ModernZ/main/extras/pip-lite/pip_lite.conf

# ytdlAutoFormat
echo "Installing ytdlAutoFormat..."
curl -fsSL -o "${SCRIPTS_DIR}/ytdlautoformat.lua" https://raw.githubusercontent.com/Samillion/mpv-ytdlautoformat/master/ytdlautoformat.lua

# BoxToWide
echo "Installing BoxToWide..."
curl -fsSL -o "${SCRIPTS_DIR}/boxtowide.lua" https://raw.githubusercontent.com/Samillion/mpv-boxtowide/master/boxtowide.lua

# Clipshot
echo "Installing clipshot..."
curl -fsSL -o "${SCRIPTS_DIR}/clipshot.lua" https://raw.githubusercontent.com/observeroftime/mpv-scripts/master/clipshot.lua

# EvaFast
echo "Installing evafast..."
curl -fsSL -o "${SCRIPTS_DIR}/evafast.lua" https://raw.githubusercontent.com/po5/evafast/master/evafast.lua

# Config files
echo "Installing config files..."
cat > "${MPV_DIR}/mpv.conf" << 'MPCONF'
# Video output
vo=gpu
gpu-api=opengl

# Hardware decoding
hwdec=auto-safe

# Audio
audio-channels=auto
audio-device=auto
alang=en,jp,eng

# Subtitles
sub-auto=fuzzy
sub-font-size=38
slang=en

# Screenshot
screenshot-format=png
screenshot-directory=~~home/screenshots
screenshot-template="%F-%P"

# OSD
osd-duration=2500
osd-font-size=28

# Cache
demuxer-max-bytes=500MiB
demuxer-max-back-bytes=250MiB

# Seek precision
hr-seek-framedrop=no

# Misc
keep-open=yes
save-position-on-quit=yes
autofit-larger=90%x90%

# OSC (ModernZ replaces default)
osc=no
border=no
watch-later-options-remove=sub-pos
input-default-bindings=no
MPCONF

cat > "${MPV_DIR}/input.conf" << 'INPUTCONF'
# VLC-style keybindings

# Playback
SPACE cycle pause
s show-text "Stop" 1500; quit
S show-text "Quit" 1500; quit-watch-later
n show-text "Next" 1500; playlist-next
p show-text "Previous" 1500; playlist-prev

# Volume
UP osd-msg add volume 5
DOWN osd-msg add volume -5
m osd-msg cycle mute

# Seeking
LEFT seek -10
RIGHT seek 10
Shift+LEFT seek -5 exact
Shift+RIGHT seek 5 exact

# Speed
[ multiply speed 0.9
] multiply speed 1.1
{ multiply speed 0.5
} multiply speed 2.0
BS set speed 1.0

# Fullscreen
f cycle fullscreen

# Audio
a cycle audio
Shift+a cycle audio-device

# Subtitles
j cycle sub
v cycle sub-visibility
r sub-step -1
R sub-step 1

# Audio delay
Ctrl+LEFT add audio-delay -0.1
Ctrl+RIGHT add audio-delay 0.1

# Screenshots
Shift+s screenshot

# Video filters
d cycle deinterlace
b cycle debanding

# Scripts
F1 script-binding file-browser/browse-files
Shift+o script-message playlistmanager show playlist toggle
Ctrl+p script-binding pip_lite/pip-toggle
e script-binding evafast/evafast-toggle

# ModernZ OSC controls
v script-binding modernz/visibility
w script-binding modernz/progress-toggle

# Misc
l ab-loop
L cycle-values loop-file "inf" "no"
INPUTCONF

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Scripts installed: 13"
echo "Config files: mpv.conf, input.conf"
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
