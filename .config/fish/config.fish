set -gx EDITOR nvim
set -gx SHELL fish
set -gx PF_INFO "ascii title os uptime pkgs wm shell editor"
set -gx BAT_THEME catppuccin

alias vim "nvim"

starship init fish | source