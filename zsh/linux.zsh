#!/usr/bin/env zsh

# Zsh configuration which is only suitable for linux system.

# Use colored output if tty is attached.
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

# macOS like open command.
open() { xdg-open "$1" >/dev/null 2>&1 & }

# Turn of screens
alias screen-off="xset dpms force off"

# Set prelude path for Maude which is required on Arch Linux
export MAUDE_LIB=/usr/share/maude 
