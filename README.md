# MPV Configuration

## Quick Install

```bash
git clone https://github.com/njobvulabs/mpv-config ~/.config/mpv
cd ~/.config/mpv && bash install.sh
```

Or download `install.sh` and run it:
```bash
bash install.sh
```

## Keybindings (VLC-style)

### Playback
| Key | Action |
|-----|--------|
| SPACE | Pause/Resume |
| s | Stop (quit) |
| S | Quit (save position) |
| n | Next |
| p | Previous |

### Volume
| Key | Action |
|-----|--------|
| UP | Volume +5 |
| DOWN | Volume -5 |
| m | Mute |

### Seeking
| Key | Action |
|-----|--------|
| LEFT | Seek -10s |
| RIGHT | Seek +10s |
| Shift+LEFT | Seek -5s (exact) |
| Shift+RIGHT | Seek +5s (exact) |

### Speed
| Key | Action |
|-----|--------|
| [ | Speed -10% |
| ] | Speed +10% |
| { | Speed x0.5 |
| } | Speed x2.0 |
| Backspace | Reset speed |

### Fullscreen
| Key | Action |
|-----|--------|
| f | Toggle fullscreen |

### Audio
| Key | Action |
|-----|--------|
| a | Cycle audio track |
| Shift+a | Cycle audio device |
| Ctrl+LEFT | Audio delay -0.1s |
| Ctrl+RIGHT | Audio delay +0.1s |

### Subtitles
| Key | Action |
|-----|--------|
| j | Cycle subtitle |
| v | Toggle subtitle visibility / OSC visibility |
| r | Subtitle delay -0.1s |
| R | Subtitle delay +0.1s |

### Screenshots
| Key | Action |
|-----|--------|
| Shift+s | Take screenshot |

### Video Filters
| Key | Action |
|-----|--------|
| d | Toggle deinterlace |
| b | Toggle debanding |

### Scripts
| Key | Action |
|-----|--------|
| F1 | File browser |
| Shift+o | Playlist manager |
| Ctrl+p | Picture-in-Picture toggle |
| e | Smart seek (evafast) |
| w | Toggle persistent progress bar |

### Misc
| Key | Action |
|-----|--------|
| l | A-B loop |
| L | Toggle loop |

---

## Installed Scripts (13)

| Script | Description |
|--------|-------------|
| modernz.lua | Modern OSC UI (compact layout) |
| thumbfast.lua | Seekbar thumbnails |
| pause_indicator_lite.lua | Pause indicator |
| autoload.lua | Auto-queue next episode from folder |
| sponsorblock_minimal.lua | Skip YouTube sponsors |
| celebi.lua | Restore volume/subtitle from last session |
| file-browser.lua | In-player file browser |
| playlistmanager.lua | Enhanced playlist manager |
| pip_lite.lua | Picture-in-Picture mode |
| ytdlautoformat.lua | Auto yt-dlp format for domains |
| boxtowide.lua | Auto aspect-ratio correction |
| clipshot.lua | Screenshot to clipboard |
| evafast.lua | Smart seeking with preview |

---

## Config Files

- `mpv.conf` — Main config
- `input.conf` — Keybindings
- `script-opts/modernz.conf` — ModernZ OSC settings (compact layout, teal accent)
- `script-opts/thumbfast.conf` — Thumbnail settings
- `script-opts/pip_lite.conf` — PiP settings

---

## ModernZ Settings

- **Layout:** compact
- **Icon theme:** fluent (outline style)
- **Persistent progress bar:** enabled
- **Accent color:** teal (#00d4aa)
