# Zsh configuration specific to macOS.

# Use colored output for cli commands.
export CLICOLOR=1

# Make Emacs available on the command-line.
if [[ -d "$HOME/src/emacs/nextstep/Emacs.app/Contents/MacOS" ]]; then
    path+=("$HOME/src/emacs/nextstep/Emacs.app/Contents/MacOS")
fi

# iTerm2 shell integration
if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Add git contrib script diff-highlight to path
if [[ -d "/usr/local/share/git-core/contrib/diff-highlight" ]]; then
    path+=("/usr/local/share/git-core/contrib/diff-highlight")
fi
