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

# Load completions from $ZDOTDIR.
fpath=("$ZDOTDIR" $fpath)

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

# Allow backspace / delete key to delete characters.
# NOTE: If iTerm 2 is used, ensure that 'Delete key sends ^H'
#       is unchecked under 'iTerm2 > Preference > Profiles > Keys'.
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
## Aliases & environment variables {{{

# Make sudo work for aliases.
alias sudo='sudo '
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ll='ls -lah'

if (( $+commands[nvim] )); then
  alias vim='nvim'
  export EDITOR=nvim
  export VIUSAL=nvim
fi

if (( $+commands[exiftool] )); then
  alias remove-tags="exiftool -all="
fi

# Avpid issues due to missing term info when kitty is used.
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Get top 10 of most used commands.
alias top10='print -l -- ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# Highlight trailing whitespace using ripgrep
alias htwp="rg --colors 'match:bg:red' '[[:blank:]]+$'"

if (( $+commands[ocrmypdf] )); then
  alias ocr='ocrmypdf --image-dpi 600 --pdfa-image-compression lossless'
fi

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

# OS specific configurations
zplug "$ZDOTDIR", from:local, use:"macos.zsh", if:"[[ $OSTYPE == *darwin* ]]"
zplug "$ZDOTDIR", from:local, use:"linux.zsh", if:"[[ $OSTYPE == *linux* ]]"

# Load private configuration if present
if [[ -f "$ZDOTDIR"/private.zsh ]]; then
    zplug "$ZDOTDIR", from:local, use:"private.zsh"
fi

# Load plugins
zplug "zsh-users/zsh-autosuggestions" #, at:develop
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf", use:"shell/{completion,key-bindings}.zsh", defer:2

if ! zplug check --verbose; then
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
# 2021-08-16: Disabled since the history strategy makes spurious function calls
# FIXME: This seems to be a side-effect with the rest of the configuration.
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# C-o to accept suggestion.
bindkey '^o' autosuggest-accept
# C-f to accept and execute suggestion.
bindkey '^f' autosuggest-execute

# Enable asyn mode
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Colors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245'

# }}}
## Syntax highlighting {{{

# Enable additional highlighters like `bracket` (rainbow brackets)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Colors
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=196'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=113'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
ZSH_HIGHLIGHT_STYLES[path]=''
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=''
ZSH_HIGHLIGHT_STYLES[path_prefix]=''
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=''
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=142'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=142'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=142'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[comment]='fg=245'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan,bold'

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

# Setup 'thefuck' if installed and alias it to 'doit'.
if (( $+commands[thefuck] )); then
    eval "$(thefuck --alias doit)"
fi

# }}}
## starship prompt setup {{{

# Initialize 'starship' if installed
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# }}}
## GnuPG setup {{{

# Ensure that GPG_TTY is set for gpg-agent.
export GPG_TTY=$(tty)

# }}}
## ssh-agent setup {{{

if [[ "$(uname -s)" == "Linux" ]]; then
    # Using a systemd user service to start ssh-agent.
    if [[ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]]; then
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    fi
fi

# }}}
## git setup {{{

# Pretty git log based on current input or current branch.
git_log() {
  local pathspec="$BUFFER"
  if [[ -z "$pathspec" ]]; then
    pathspec="$(git branch --show-current)"
  fi
  git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) %C(bold white)%G?%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' "$pathspec"
  printf "\n\n"
  zle reset-prompt
}

# Bind ctrl-g-l to 'git_log' widget.
zle -N git_log
bindkey '^gl' git_log

# Pretty git branch --list --remote.
git_branch_remote() {
  local length=$(git branch --list --remote --format="%(refname:short)" | awk 'length > max_length { max_length = length } END { print max_length }')
  git branch --list --remote --sort=-authordate --format="%(color:white bold)%(align:$length)%(refname:short)%(end)%(color:reset) %(color:blue bold)%(objectname:short)%(color:reset) - (%(authordate:relative)) %(contents:subject) - %(color:dim white)%(authorname)%(color:reset)"
  printf "\n\n"
  zle reset-prompt
}

# Bind ctrl-g-b to 'git_branch_remote' widget.
zle -N git_branch_remote
bindkey '^gb' git_branch_remote

# Bind ctrl-s to 'git status`.
bindkey -s '^s' '^qgit status^M'

# Bind ctrl-g-d to `git diff`.
bindkey -s '^gd' '^qgit diff^M'

# Bind ctrl-g-d-s to `git diff --staged`.
bindkey -s '^gds' '^qgit diff --staged^M'

# Bind ctrl-g-c to `git commit`.
bindkey -s '^gc' '^qgit commit^M'

# Bind ctrl-g-p to `git push`.
bindkey -s '^gp' '^qgit push^M'

# Go to the root directory of the repository.
git_root() {
    cd "$(git rev-parse --show-toplevel)"
    zle reset-prompt
}

# Bind ctrl-g-r to `git_root`.
zle -N git_root
bindkey '^gr' git_root

# }}}
## Nix setup {{{

if [[ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
   source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# }}}
## fzf setup {{{

# Initial version from fzf's readme.
fzf_ripgrep_file() {
    local initial_buffer="$BUFFER"
    local initial_query=""
    local rg_prefix="rg --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$rg_prefix '$initial_query'"
    local selection=$(fzf --bind "change:reload:$rg_prefix {q} || true" \
                          --ansi --disabled --query "$initial_query" \
                          --multi --layout=reverse | cut -f1 -d ':')
    local parts=("${(@f)selection}")
    zle reset-prompt
    BUFFER="$initial_buffer${parts[@]}"
    zle end-of-line
}

zle -N fzf_ripgrep_file
bindkey '^w' fzf_ripgrep_file

fzf_ripgrep_vim() {
    local initial_query="$BUFFER"
    local rg_prefix="rg --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$rg_prefix '$initial_query'"
    local selection=$(fzf --bind "change:reload:$rg_prefix {q} || true" \
                          --ansi --disabled --query "$initial_query" \
                          --layout=reverse)
    local parts=("${(s/:/)selection}")
    zle reset-prompt
    if [[ ! -z "$selection" ]]; then
        print -s vim "+${parts[2]}" "\'${parts[1]}\'"
        vim "+${parts[2]}" "${parts[1]}"
        zle accept-line
    fi
}

zle -N fzf_ripgrep_vim
bindkey '^v' fzf_ripgrep_vim

# }}}
# nnn setup {{{

# Source: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

export NNN_PLUG='p:preview-tui'

# -a: auto-setup temporary NNN_FIFO
# -A: disable directory auto-enter on unique filter match
# -e: open text files in $VISUAL
# -H: show hidden files
# -P 'p': run 'preview-tui' plugin
alias n='n -a -A -e -H -P 'p''

# }}}
# {{{ Other functions

todo() {
  printf "- [ ] %s\n" "$@" >> todo.org
}

chpwd() {
    emulate -L zsh
    ls -a
}

# }}}
## rbenv setup {{{

if (( $+commands[rbenv] )); then
    eval "$(rbenv init - zsh)"
fi

# }}}
# {{{ Go setup

if (( $+commands[go] )); then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# }}}
# {{{ Rust setup

if [[ -f "$XDG_DATA_HOME/cargo/env" ]]; then
  source "$XDG_DATA_HOME/cargo/env"
fi

# }}}

# vim: fdm=marker fdc=3 ft=zsh ts=4 sw=4 sts=4:
