# !/bin/bash

# check if yay is installed
if command -v yay &> /dev/null; then
    echo "yay is installed."
else
    echo "yay is not installed."
    # install yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    sudo pacman -S --noconfirm --needed base-devel
    makepkg -si
    wait
fi

# install packages
yay -S $(cat packages) --noconfirm

# copy .local folder to home directory
cp -r .local ~/

cp .xprofile ~/

cp .config/* ~/.config/ -r

# change default shell to fish
chsh -s $(which fish)

# install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# install fish plugins: nvm, git
fish -c "fisher install jorgebucaran/nvm.fish"
fish -c "fisher install jhillyerd/plugin-git"

# set wallpaper
mkdir ~/.wallpapers
cp wallpapers/background.png ~/.wallpapers
nitrogen ~/.wallpapers/background.png --set-scaled

# install bun
curl -fsSL https://bun.sh/install | bash

# clone and install doannc2212/nvchad-config
git clone --depth 1 https://github.com/doannc2212/nvchad-config.git ~/.config/nvim

