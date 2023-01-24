set -gx EDITOR nvim
set -gx SHELL fish
set -gx PF_INFO "ascii title os wm shell editor"
set -gx PF_ASCII "Catppuccin"
set -gx BAT_THEME catppuccin
# set -x JAVA_HOME '/usr/lib/jvm/java-11-openjdk'

alias vim "nvim"
alias audio "spotify_player"

starship init fish | source
