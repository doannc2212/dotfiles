set -gx PF_INFO "ascii title os host kernel uptime pkgs memory"
set -gx EDITOR nvim
set -gx SHELL fish
# set -gx PF_INFO "ascii title os wm shell editor"

alias vim "nvim"
alias p "pnpm"

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
