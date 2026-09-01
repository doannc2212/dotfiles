# My Dotfiles

These are my personal dotfiles and setup scripts for Linux (mainly Arch). I use them to quickly set up a new machine or restore my preferred environment.

## Quick Start

1. Clone this repo (with submodules):
   ```sh
   git clone --recurse-submodules https://github.com/doannc2212/dotfiles.git
   cd dotfiles
   ```
   If you already cloned without `--recurse-submodules`, you can fetch them with:
   ```sh
   git submodule update --init --recursive
   ```
2. Run my installer:
   ```sh
   chmod +x install.sh
   ./install.sh
   ```

The script will:

- Make sure yay is installed (for AUR packages)
- Install everything in `packages`
- Copy configs and scripts to the right places
- Set Fish as my default shell, install Fisher and plugins
- Set up Neovim (from my external config)
- Enable Docker and Bluetooth
- Copy the `Picture` folder if it exists
- Install BetterDiscord if you want

## What You’ll Need

- Arch Linux (or similar)
- Internet connection
- git and sudo

## Quickshell Desktop Config

I recently put together a Hyprland desktop setup built with [Quickshell](https://quickshell.outfoxxed.me/). It lives in `.config/quickshell/` as a git submodule, sourced from [doannc2212/quickshell-config](https://github.com/doannc2212/quickshell-config).

It includes:

| Module | What it does |
|--------|-------------|
| **Bar** | Clock, workspaces, active window title, volume, brightness, network, battery, system tray, now-playing indicator |
| **App Launcher** | Rofi drun-style application launcher |
| **Notifications** | Built-in notification daemon (replaces dunst/mako) with popups |
| **Media Control** | Popup overlay with album art, playback controls, progress bar, and volume slider |
| **OSD** | On-screen display for volume and brightness, auto-hides after 1.5s |
| **Theme Switcher** | 206 themes across 6 families, persists across restarts |
| **Wallpaper Manager** | Grid picker with preview, supports hyprpaper and swww |

To use it standalone (without the rest of these dotfiles):

```sh
git clone https://github.com/doannc2212/quickshell-config ~/.config/quickshell
quickshell
```

Feel free to check out the [quickshell config README](.config/quickshell/README.md) for more details on individual modules and how to set them up.

## Notes

- I recommend reading `install.sh` before running to see what it does.
- This setup is mainly for my workflow—feel free to tweak it for yours!

---

Happy hacking!
