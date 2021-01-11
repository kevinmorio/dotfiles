# Zsh configuration specific to macOS.

# Use colored output for cli commands.
export CLICOLOR=1

# iTerm2 shell integration
if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi
