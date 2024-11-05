set -gx EDITOR nvim
set -gx SHELL fish
set -gx PF_INFO "ascii title os wm shell editor"
set -gx PF_ASCII "Catppuccin"
set -gx BAT_THEME catppuccin
# set -x JAVA_HOME '/usr/lib/jvm/java-11-openjdk'

alias vim "nvim"
alias p "pnpm"
alias audio "spotify_player"
alias chat-ops "chat-ops.AppImage"

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
