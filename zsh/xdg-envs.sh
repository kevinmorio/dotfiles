# The environment variables set in this file should prevent cluttering the home directory
# with program specific files if it is possible without too much trouble.
#
# If some program still clutters the home directory, look at
#   https://wiki.archlinux.org/index.php/XDG_Base_Directory
# to see if there exists an entry.
#
# TODO Sort and group applications
# TODO Only export variables when application is installed

# adb
# ~./android
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME"/android
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator

# Rust / Cargo
# ~/.cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# Rustup
# ~/.rustup
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# SQLite
# ~/.sqlite_history
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite/sqlite_history

# Unison
# ~/.unison
export UNISON="$XDG_DATA_HOME"/unison

# Taskwarrior
# ~/.task
# ~/.taskrc
export TASKDATA="$XDG_DATA_HOME"/task
export TASKRC="$XDG_CONFIG_HOME"/task/taskrc

# Haskell / Stack
# ~/.stack
export STACK_ROOT="$XDG_DATA_HOME"/stack

# Racket
# ~/.racketrc
# ~/.racket
export PLTUSERHOME="$XDG_DATA_HOME"/racket

# Redis CLI
# ~/.rediscli_history
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/rediscli_history

# Node.js
# ~/.node_repl_history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/node_repl_history

# Less
# ~/.lesshst
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_DATA_HOME"/less/less_history

# GTK2
# ~/.gtkrc-2.0
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# ipython / jupyter
# ~/.ipython
# ~/.jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

# Gradle
# ~/.gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# GnuPG
# ~/.gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Guile
# ~/.guile-history
export GUILE_HISTORY="$XDG_DATA_HOME"/guile/guile_history

# Conda
# ~/.condarc
export CONDARC="$XDG_CONFIG_HOME"/conda/condarc

# xinit
# ~/.xinitrc
# ~/.xserverrc
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/xserverrc

# CUDA
# ~/.nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# Firefox build system persistent data
# ~/.mozbuild
export MOZBUILD_STATE_PATH="$XDG_DATA_HOME"/mozbuild

# Gradle
# ~./gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# Esy
# ~/.esy
export ESY__PREFIX="$XDG_DATA_HOME"/esy

# Racket
# ~/.racket
# ~/.racketrc
export PLTUSERHOME="$XDG_DATA_HOME"/racket

# python-pylint
# ~/.pylint.d
export PYLINTHOME="$XDG_CACHE_HOME"/pylint

# TeamSpeak
# ~/.ts3client
export TS3_CONFIG_DIR="$XDG_CONFIG_HOME/ts3client"

# opam
# ~/.opam
export OPAMROOT="$XDG_DATA_HOME/opam"

# Go
# ~/go
export GOPATH="$XDG_DATA_HOME"/go
