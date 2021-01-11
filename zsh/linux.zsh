# Zsh configuration specific to Linux systems.

# Use colored output if tty is attached.
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

# macOS like open command.
open() { xdg-open "$1" >/dev/null 2>&1 & }

# Turn off screens
alias screen-off="xset dpms force off"
