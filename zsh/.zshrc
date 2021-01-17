#######################################################################
#                          Zsh Configuration                          #
#######################################################################

## History settings {{{

# File to save the history when an interactive shell exists.
HISTFILE="$XDG_DATA_HOME"/zsh/zsh_history
mkdir -p $(dirname "$HISTFILE")

# Maximum number of history events to save in the history file.
SAVEHIST=100000

# Maximum number of history events soted in the internal history list.
HISTSIZE=100000

# Don't beep in ZLE.
unsetopt HIST_BEEP

# Lock history using fcntl call.
setopt HIST_FCNTL_LOCK

# Don't show duplicates when searching history.
setopt HIST_FIND_NO_DUPS

# Don't record duplicates.
setopt HIST_IGNORE_ALL_DUPS

# Don't record contiguous duplicates.
# setopt HIST_IGNORE_DUPS

# Don't record commands starting with a space.
setopt HIST_IGNORE_SPACE

# Correctly handle quoted whitespace.
# NOTE: Comment out when performance impact is significant.
setopt HIST_LEX_WORDS

# Remove superfluous blanks from a command
setopt HIST_REDUCE_BLANKS

# Don't save duplicates to the history file.
setopt HIST_SAVE_NO_DUPS

# Incrementally add new commands to the histfile from multiple shell instances.
setopt INC_APPEND_HISTORY

# Import commands from the history file and append commands to the history file.
# NOTE: Mutally exclusive to INC_APPEND_HISTORY
# setopt SHARE_HISTORY

# }}}
## General {{{

# Sort filenames numerically if they are matched by a filename generation pattern.
setopt NUMERIC_GLOB_SORT

# Allow comments even in interactive shells.
setopt INTERACTIVE_COMMENTS

# Run background jobs at normal priority.
unsetopt BG_NICE

# Report the status of background and suspended jobs before exiting a shell.
setopt CHECK_JOBS

# Perform substitution in prompts.
setopt PROMPT_SUBST

# Don't beep on error in Zle
unsetopt BEEP

# Disable flow control to allow binding to ctrl-s and ctrl-q.
unsetopt FLOW_CONTROL

# }}}
## Appearance {{{

# Change cursor shape for different Vim modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} == '' ]] ||
       [[ $1 == 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

echo -ne '\e[5 q'

zle-line-init() {
  zle -K viins
  echo -ne '\e[5 q'
}

## Color utilities

autoload -U colors
colors

# }}}
## Prompt {{{

# autoload -U promptinit
# promptinit
# prompt fade blue

# }}}
## Changing directories options {{{

# If a command can't be executed as a normal command, and the command is the name of a directory,
# perform the `cd` command to that directory. This is the default behavior in fish.
setopt AUTO_CD

# Make `cd` push the old directory onto the directory stack.
setopt AUTO_PUSHD

# Do not print the directoy stack after `pushd` or `popd`.
setopt PUSHD_SILENT

# Have `pushd` with no arguments act liike `pushd $HOME`.
setopt PUSHD_TO_HOME

# }}}
## Completion settings {{{

mkdir -p "$XDG_CACHE_HOME"/zsh
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump

# Enable completion cache to speed things up.
mkdir -p "$XDG_DATA_HOME"/zsh
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_DATA_HOME"/zsh/zsh_compcache

# Group different types of matches separately.
zstyle ':completion:*' group-name ''

zstyle ':completion:*' menu select

# Group completion results
zstyle ':completion:*:matches' group 'yes'

# Fallback to case-insensitive matches if no exact match exists
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Move cursor to end of completion.
setopt ALWAYS_TO_END

# When cursor is in a word, completion is done from both ends.
setopt COMPLETE_IN_WORD

zmodload zsh/complist

# }}}
## Keybindings {{{

# Use Vim keybindings.
bindkey -v

# Use Vim keys in menu completion.
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# Accept selection without having to press return twice.
bindkey -M menuselect '^M' .accept-line

# Allow backspace to delete newlines
bindkey "^?" backward-delete-char

# Store current input and clear line with ctrl-q.
# Requires 'unsetopt FLOW_CONTROL'.
bindkey '^q' push-line-or-edit

# }}}
## Modules {{{

# A builtin for starting a command in a pseudo-terminal.
# Required for the 'completion' autosuggestion strategy.
zmodload zsh/zpty

# }}}
## Aliases {{{

# Make sudo work for aliases.
alias sudo='sudo '
alias vim='nvim'
alias rm='rm -i'
alias mv='mv -i'

# Get top 10 of most used commands.
alias top10='print -l -- ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# }}}
## zplug configuration {{{

export ZPLUG_HOME="$XDG_DATA_HOME"/zplug
if [[ ! -f "$ZPLUG_HOME"/init.zsh ]]; then
    git clone "https://github.com/zplug/zplug" "$ZPLUG_HOME"
fi
source "$ZPLUG_HOME"/init.zsh

# Set variables according to XDG specification.
zplug "$ZDOTDIR", from:local, use:"xdg-envs.sh"

# Anaconda
zplug "$ZDOTDIR", from:local, use:"anaconda.sh"

## OS specific configurations
zplug "$ZDOTDIR", from:local, use:"macos.zsh" if:"[[ $OSTYPE == *darwin* ]]"
zplug "$ZDOTDIR", from:local, use:"linux.zsh" if:"[[ $OSTYPE == *linux* ]]"

# Load plugins
zplug "zsh-users/zsh-autosuggestions", at:develop
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf", use:"shell/{completion,key-bindings}.zsh", defer:2

# Prompt
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

if !  zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load #--verbose

# }}}
## Autosuggest options {{{

# Use 'history' and 'completion' suggestion strategies.
# 'completion' requires the zpty module
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# C-o to accept suggestion.
bindkey '^o' autosuggest-accept
# C-f to accept and execute suggestion.
bindkey '^f' autosuggest-execute

# Enable asyn mode
ZSH_AUTOSUGGEST_USE_ASYNC=1

# }}}
## Syntax highlighting {{{

# Enable additional highlighters like `bracket` (rainbow brackets)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# }}}
## History substring search {{{

# Use `j` and `k` or arrow keys to cycle history.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Set suitable colors for matches
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"

# }}}
## thefuck setup {{{

## Setup 'thefuck' if installed and alias it to 'doit'.
if (( $+commands[thefuck] )); then
    eval $(thefuck --alias doit)
fi

# }}}
## GnuPG setup {{{

# Ensure that GPG_TTY is set for gpg-agent.
export GPG_TTY=$(tty)

# }}}
## git setup {{{

# Pretty git log based on current input or current branch.
git_log() {
  local pathspec="$BUFFER"
  if [[ -z "$pathspec" ]]; then
    pathspec="$(git branch --show-current)"
  fi
  git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' "$pathspec"
  zle reset-prompt
  zle redisplay
}

# Bind ctrl-g-l to 'git_log' widget.
zle -N git_log
bindkey '^gl' git_log

# Bind ctrl-s to 'git status'
bindkey -s '^s' '^qgit status^M'

# }}}
## Nix setup {{{

if [[ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
   source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# }}}

# vim: fdm=marker fdl=0
