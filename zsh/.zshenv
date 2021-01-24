# Ensure that XDG directories have been set.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Load Zsh configuration from $XDG_CONFIG_HOME.
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# Ensure that the path array doesn't contain duplicates
# TODO: Check that all paths exist.
typeset -U PATH path
path=(
  /usr/local/{bin,sbin}
  /usr/bin
  "$HOME"/bin
  "$HOME"/.local/bin
  "$path[@]"
)
export PATH
