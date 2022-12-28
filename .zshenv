#######################
#                     #
# Environment Vars    #
#                     #
#######################

# Append .local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_DATA_HOME="$XDG_CONFIG_HOME/.local/share"
# export XDG_CACHE_HOME="$XDG_CONFIG_HOME/.cache"

# Fix ls background colors
LS_COLORS=$LS_COLORS:'tw=00;33:ow=01;33:'; export LS_COLORS

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=50000                   # Maximum events in history file
export ZSH_COMPDUMP=ZDOTDIR/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}.

# android-studio
export ANDROID_HOME=/home/bartolek/Android/Sdk

# man
# export MANPATH="/usr/local/man:$MANPATH"
# export MANPAGER='nvim +Man!'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
