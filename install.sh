#!/bin/bash
set -e

# Helper function for status reporting
echo_status() {
    echo -e "\n==== $1 ===="
}

# 1. Install yay if not present
echo_status "Checking yay installation"
if ! command -v yay &>/dev/null; then
    echo "yay not found. Installing yay..."
    if [ ! -d yay ]; then
        git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay repo!"; exit 1; }
        echo "Cloned yay repository."
    fi
    cd yay
    sudo pacman -S --noconfirm --needed base-devel || { echo "Failed to install base-devel!"; exit 1; }
    makepkg -si --noconfirm || { echo "Failed to build/install yay!"; exit 1; }
    cd ..
    rm -rf yay
else
    echo "yay is already installed."
fi

# 2. Install packages from 'packages' file
echo_status "Installing packages"
if [ -f packages ]; then
    yay -S --needed --noconfirm $(cat packages) || { echo "Failed to install packages!"; exit 1; }
else
    echo "No packages file found!"
fi

# 3. Initialize git submodules
echo_status "Initializing git submodules"
git submodule update --init --recursive && echo "Submodules initialized." || echo "Failed to initialize submodules!"

# 4. Setup ~/.local/share/bin and copy files
echo_status "Setting up local bin"
mkdir -p ~/.local/share/bin
cp -ru .bin/* ~/.local/share/bin/

# 5. Copy .config
echo_status "Copying .config files"
mkdir -p ~/.config
cp -ru .config/* ~/.config/

# 6. Change default shell to fish if not already
echo_status "Setting fish as default shell"
if [ "$SHELL" != "$(which fish)" ]; then
    chsh -s $(which fish) && echo "Changed default shell to fish." || echo "Failed to change default shell."
else
    echo "Fish is already the default shell."
fi

# 7. Install fisher if not installed
echo_status "Installing fisher"
if ! fish -c "type -q fisher"; then
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" || echo "Failed to install fisher!"
else
    echo "fisher is already installed."
fi

# 8. Install fish plugins
echo_status "Installing fish plugins"
fisher_plugins=(jorgebucaran/nvm.fish jhillyerd/plugin-git)
for plugin in "${fisher_plugins[@]}"; do
    fish -c "fisher install $plugin" || echo "Failed to install $plugin!"
done

# 9. Add local bin to PATH in fish config if not present
echo_status "Ensuring local bin in PATH"
if ! grep -q 'fish_add_path ~/.local/share/bin' ~/.config/fish/config.fish 2>/dev/null; then
    mkdir -p ~/.config/fish
    echo 'fish_add_path ~/.local/share/bin' >> ~/.config/fish/config.fish
    echo "Added ~/.local/share/bin to PATH in fish config."
else
    echo "~/.local/share/bin is already in fish PATH."
fi

# 10. Clone and install nvim config
echo_status "Setting up nvim config"
if [ ! -d ~/.config/nvim ]; then
    git clone --depth 1 https://github.com/doannc2212/nvchad-config.git ~/.config/nvim || echo "Failed to clone nvim config!"
else
    echo "nvim config already exists."
fi

# 11. Clone and install quickshell config
echo_status "Setting up quickshell config"
if [ ! -d ~/.config/quickshell ]; then
    git clone --depth 1 https://github.com/doannc2212/quickshell-config.git ~/.config/quickshell || echo "Failed to clone quickshell config!"
else
    echo "quickshell config already exists."
fi

# 12. Enable and start docker and bluetooth services
echo_status "Enabling docker/bluetooth services"
for service in docker bluetooth; do
    if systemctl is-enabled --quiet $service; then
        echo "$service service already enabled."
    else
        sudo systemctl enable --now $service && echo "$service enabled and started." || echo "Failed to enable/start $service!"
    fi
    systemctl is-active --quiet $service && echo "$service is active." || echo "$service is NOT active!"
done

# 12. Copy Picture folder to home directory
echo_status "Copying Picture folder to ~/Picture"
SRC_DIR="$(pwd)/Picture"
DEST_DIR="$HOME/Picture"

if [ ! -d "$SRC_DIR" ]; then
    echo "Source Picture directory does not exist: $SRC_DIR"
else
    if [ -d "$DEST_DIR" ]; then
        echo "Destination directory already exists: $DEST_DIR"
        echo "Copying contents, overwriting existing files if necessary."
    else
        echo "Creating destination: $DEST_DIR"
        mkdir -p "$DEST_DIR"
    fi
    cp -ru "$SRC_DIR"/* "$DEST_DIR"/
    echo "Pictures copied to $DEST_DIR successfully."
fi



# 13. Install BetterDiscord (betterdiscordctl)
echo_status "Installing BetterDiscord (betterdiscordctl)"
if ! command -v betterdiscordctl &>/dev/null; then
    curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl && \
    chmod +x betterdiscordctl && \
    sudo mv betterdiscordctl /usr/local/bin && \
    echo "betterdiscordctl installed successfully."
else
    echo "betterdiscordctl is already installed."
fi

echo_status "All done! System is configured."
