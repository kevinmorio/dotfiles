# Zsh configuration specific to macOS.

# Use colored output for cli commands.
export CLICOLOR=1

# Make Emacs available on the command-line.
export PATH="$PATH:$HOME/src/emacs/nextstep/Emacs.app/Contents/MacOS"

# iTerm2 shell integration
if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi
