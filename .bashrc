export PATH=$PATH:~/.composer/vendor/bin

export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

source ~/.bash_git

if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
else
    source ~/.git-completion.bash
fi

if [ -f ~/.symfony-completion.bash ]; then
    source ~/.symfony-completion.bash
fi

has_parent_dir () {
    # Utility function so we can test for things like .git/.hg without firing up a
    # separate process
    test -d "$1" && return 0;

    current="."
    while [ ! "$current" -ef "$current/.." ]; do
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done

    return 1;
}

vcs_name() {
    if [ -d .svn ]; then
        echo "-[svn]";
    elif has_parent_dir ".git"; then
        echo " ($(__git_ps1 '%s'))";
    elif has_parent_dir ".hg"; then
        echo " ($(hg branch))"
    fi
}

#################
# prompt colors #
#################
black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)

bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)

# Nicely formatted terminal prompt
#export PS1='\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-[\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\w\[$black\]]\[\033[0;33m\]$(vcs_name) \[\033[00m\]\[$reset\]\[$reset\]$ '
export PS1='\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-\[$bold\]\[$black\][\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\w\[$black\]\[$reset\]\[$lt_blue\]$(vcs_name)\[$bold\]\[$black\]]\[$reset\]\n|-$\[$reset\] '

# TODO Fix this below. It is our new prompt and will replace PS1 above
#################
## prompt parts #
#################
## main
#open="["
#close="]"
#sep="-"
#color_reset="\[$bold\]\[$black\]"
#
## user
#open_user=${open}
#close_user=${close}
#user="\u"
#host="\h"
#
## dir
#open_dir="${open}"
#close_dir="${close}"
#dir="\w"
#
## repo
#open_repo="${open}"
#close_repo="${close}"
#repo="\[\033[0;33m\]${vcs_name}\[\033[00m\]"
#
## begin end
#prompt_begin="${color_reset}"
#prompt_end="\$ ${reset}"
#
####################
## prompt sections #
####################
#prompt_user="${color_reset}\[${yellow}\]${open_user}${user}@${host}${close_user}"
#prompt_dir="${color_reset}\[${lt_blue}\]${open_dir}${dir}${close_dir}"
#prompt_repo="${color_reset}\[${pink}\]${open_repo}${repo}${close_repo}"
#
#export PS1="${prompt_begin}${prompt_user}${sep}${prompt_dir}${sep}${prompt_repo}${sep}${prompt_end}"

# ls colors
[ "$TERM" = "xterm" ] && TERM="xterm-256color"
#alias ls='ls --color'

# Aliases!
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# If MacVim is installed, use that
#if [[ -e /usr/bin/mvim || -e /usr/local/bin/mvim || -e /bin/mvim ]]; then
#    alias vi="mvim $1"
#fi

export EDITOR=/usr/bin/vim

#screen -ls
