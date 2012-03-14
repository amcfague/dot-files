autoload -U compinit;   compinit -C
autoload -U colors;     colors

#
#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.zsh/histfile
HISTSIZE=5000
SAVEHIST=500

source /etc/profile

setopt append_history
setopt auto_cd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt no_flow_control
setopt no_hist_beep
setopt share_history


#------------------------------
# Variables
#------------------------------
#
# path will never contain duplicate entries
typeset -U PATH
export ORACLE_HOME=/usr/lib/oracle/10.2.0.5/client64
export CVSROOT=':pserver:amcfague@repository.wgenhq.net:2401/home/cvs/repository'
export TNS_ADMIN=/home/amcfague/.oracle
export EDITOR=/usr/bin/vim
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
export LD_PRELOAD=/home/amcfague/src/git/stderred/lib64/stderred.so

platform=$(uname)
if [[ ${platform} == "Linux" ]]; then
    PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/git/bin:/home/amcfague/oracle
    PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:$PATH
    PATH=/usr/local/sbin:$ORACLE_HOME/bin:$PATH

    # Source virtualenvwrapper
    source /usr/local/bin/virtualenvwrapper.sh

    alias ls="ls --color=auto"
elif [[ ${platform} == "Darwin" ]]; then
    PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

    # Source virtualenvwrapper
    source /usr/local/bin/virtualenvwrapper.sh

    alias ls="ls -G"

    # Add command line completion for brew (OSX only)
    #source `brew --prefix`/Library/Contributions/brew_zsh_completion.zsh 
fi
export PATH

#------------------------------
# Aliases
#------------------------------
alias grep="grep --color=auto"
alias -- cd..='cd ..'
alias -- cdwd='cd `pwd`'
alias -- cwd='echo $cwd'
alias -- ll='ls -lg'
alias gcl="git clone"
alias gco="git checkout"
alias gc="git commit"
alias gca="git commit -a"
alias gb="git branch"
alias gba="git branch -a"
alias ga="git add"
alias gp="git push"
alias gpr="git pull --rebase"
alias gs="git status"
alias gsu="pushd ./\`git rev-parse --show-cdup\` > /dev/null; git submodule update; popd > /dev/null"
alias gm="git merge"
alias grao="git remote add origin"
alias xv="xargs vim"
alias agu="sudo sh -c 'apt-get update && apt-get upgrade'"
alias ag="ack-grep"


#------------------------------
# Misc. Options
#------------------------------
#
# If there's no match for wildcard, just pass the wildcard
#   i.e., "bar*", with no match, will echo itself
setopt no_nomatch
#
#if [[ $STY = '' ]] then screen -R; fi

#------------------------------
# Keybindings
#------------------------------
# set vi mode
set -o vi
# What does this do??
# bindkey -v
# Also make it so we can open our command in a vi window
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

ZKBDFILE=~/.zkbd/$TERM
#
# So we can treat paths as such
export WORDCHARS='*?_[]~=&;!#$%^(){}'

## These things tend to change from termtype to termtype so we dynamically set them up
[[ -f $ZKBDFILE ]]         && source $ZKBDFILE
[[ -n ${key[ShiftLeft]} ]] && bindkey "${key[ShiftLeft]}" backward-word
[[ -n ${key[ShiftRight]} ]] && bindkey "${key[ShiftRight]}" forward-word
[[ -n ${key[Left]} ]]      && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]]     && bindkey "${key[Right]}" forward-char
[[ -n ${key[Up]} ]]        && bindkey "${key[Up]}" history-search-backward
[[ -n ${key[Down]} ]]      && bindkey "${key[Down]}" history-search-forward
[[ -n ${key[Home]} ]]      && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]]       && bindkey "${key[End]}" end-of-line
[[ -n ${key[Home2]} ]]     && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End2]} ]]      && bindkey "${key[End]}" end-of-line
[[ -n ${key[Delete]} ]]    && bindkey "${key[Delete]}" delete-char-or-list
[[ -n ${key[Insert]} ]]    && bindkey "${key[Insert]}" which-command
[[ -n ${key[PageUp]} ]]    && bindkey "${key[PageUp]}" insert-last-word
[[ -n ${key[PageDown]} ]]  && bindkey "${key[PageDown]}" menu-expand-or-complete
bindkey "^\M-M" accept-and-infer-next-history

# Re-enable Ctrl-R searching (may not be needed for emacs mode!)
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
#bindkey "^[[1;2D" backward-word
#bindkey "^[[1;2C" forward-word


#------------------------------
# Comp stuff
#------------------------------
# Ignore CVS
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

zstyle ':completion:::::' completer _complete _approximate
#_force_rehash() {
#  (( CURRENT == 1 )) && rehash
#  return 1	# Because we didn't really complete anything
#}
#zstyle ':completion:::::' completer _force_rehash _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

# color code completion!!!!  Wohoo!
#zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

#------------------------------
# Set Titles
#------------------------------
# Terminal Title


# SSH Completion
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Command Parameter Completion
compctl -A shift
compctl -a alias
compctl -a unalias
compctl -b bindkey
compctl -c hash
compctl -c sudo
compctl -c type
compctl -c unhash
compctl -c which
compctl -j disown
compctl -j kill
compctl -o setopt
compctl -o unsetopt
compctl -u chown
compctl -u su
compctl -v echo
compctl -v export
compctl -v unset
compctl -z fg

# Colors on completion me-ow
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Setup timestamps
setopt EXTENDED_HISTORY

# Attempt to setup git stuff
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

setopt prompt_subst

#RPROMPT='$(get_git_prompt_info)'

# Setup the prompt using olivierverdier's great setup
source ~/.zsh/git-prompt/zshrc.sh
PROMPT="%{$fg[yellow]%}%n@%m %{$fg[white]%}%~ %{$reset_color%}\$ "
RPROMPT='$(git_super_status)'

function rationalize-dot {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalize-dot
bindkey . rationalize-dot

function gt {
    #Set up tracking for current branch
    local branch_name remote
    remote=${1:-origin}
    branch_name=$(git branch --no-color 2> /dev/null \
        | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    git branch --set-upstream $branch_name $remote/$branch_name
}


# Enable less highlighting
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
alias tmux="TERM=screen-256color tmux -2"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
