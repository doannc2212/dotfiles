# My Dotfiles

These are my personal dotfiles and setup scripts for Linux (mainly Arch). I use them to quickly set up a new machine or restore my preferred environment.

## Quick Start

1. Clone this repo:
   ```sh
   git clone https://github.com/doannc2212/dotfiles.git
   cd dotfiles
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

## Notes

- I recommend reading `install.sh` before running to see what it does.
- This setup is mainly for my workflow—feel free to tweak it for yours!

---

Happy hacking!
