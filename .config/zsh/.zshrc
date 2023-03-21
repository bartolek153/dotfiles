# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



#######################
#                     #
# ZSH Options         #
#                     #
#######################

unsetopt beep
setopt autocd
setopt automenu

# To check key code: use cat command and then press key
bindkey '^H' backward-kill-word # <Ctrl-Backspace>
WORDCHARS=${WORDCHARS/\//}

bindkey '^[[3~' delete-char

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

# Compsys configuration - Start

## Completers
zstyle ':completion:*' completer _extensions _complete _approximate

## Completion Cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

## Completion Menu
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d -!%f' # (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

## Completion Grouping
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

## Colorful Completion List
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## Completions Pattern (if unsucceeded completion)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Completion Menu Binds
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^xi' vi-insert
bindkey -M menuselect '^[[Z' reverse-menu-complete

autoload -U compinit; compinit

# Credits: https://thevaluable.dev/zsh-completion-guide-examples/
# Compsys configuration - End



#######################
#                     #
# Zinit Install Check #
#                     #
#######################

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk



#######################
#                     #
# Zinit Commands      #
#                     #
#######################

# Self update
# zinit self-update
#
# Plugin update
# zinit update
#
# Plugin parallel update
# zinit update --parallel
#
# Increase the number of jobs in a concurrent-set to 40
# zinit update --parallel 40
#
#
# ICE: zinit's options command. The option melts 
# like ice and is used only once
# zinit ice wait"2" # load plugin after 2 seconds
# zinit load zdharma-continuum/history-search-multi-word



#######################
#                     #
# Plugins             #
#                     #
#######################

zinit for \
  light-mode \
    zdharma-continuum/history-search-multi-word \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting
    # zdharma-continuum/fast-syntax-highlighting \
    # MichaelAquilina/zsh-you-should-use \
    # MichaelAquilina/zsh-auto-notify \
    # agkozak/zsh-z \

# Oh My Zsh Plugins
zinit snippet OMZ::plugins/web-search/web-search.plugin.zsh
zinit snippet OMZ::plugins/jump/jump.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit snippet OMZ::plugins/dirhistory/dirhistory.plugin.zsh
zinit snippet OMZ::plugins/copypath/copypath.plugin.zsh
zinit snippet OMZ::plugins/copyfile/copyfile.plugin.zsh
# zinit snippet OMZ::plugins/git/git.plugin.zsh
# zinit snippet OMZ::plugins/extract/extract.plugin.zsh
# zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k



#######################
#                     #
# Aliases             #
#                     #
#######################

# Tuneclip
alias playlist="~/Music/.play.sh"


## Files
alias zshconfig="nvim ~/.config/zsh/.zshrc"
alias hs='history | less'


## Shell Commands
alias ls="exa --icons --color=always --group-directories-first"
alias la="exa --long --all --header --icons --sort='type'"
alias cls='clear'
alias ...='cd ../..'
alias j='jump'
# alias rm="trash"


## Package Manager
# alias update='sudo apt-get update && sudo apt-get upgrade'
# alias update='sudo pacman -Syu'
alias update='sudo dnf upgrade'

# alias sai='sudo apt install'
# alias sps='sudo pacman -S'
alias sdi='sudo dnf install'
alias sds='dnf search'

## System Infos
alias myip="curl http://ipecho.net/plain; echo"

## pass options to free ##
alias meminfo='free -m -l -t'
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
## Get server cpu info ##
alias cpuinfo='lscpu'
 
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
 
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'



#######################
#                     #
# Powerlevel10k       #
#                     #
#######################

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh
