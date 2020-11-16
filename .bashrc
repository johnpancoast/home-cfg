# TODO Clean all of this up or break out into separate files. Put things into functions.
# TODO Move appropriate sections to .profile or .bash_profile, for example PATH.

####################
# Functions
####################
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

####################
# Variables
# PATH, etc
####################
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export PATH=$PATH:~/Library/Android/sdk/tools
export PATH=$PATH:~/.symfony/bin
export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
export PATH=$PATH:~/bin
export PATH=$PATH:~/.composer/vendor/bin
#export PATH=$PATH:$(brew --prefix php@7.1)/bin

export EDITOR=/usr/bin/vim
export ANDROID_HOME=~/Library/Android/sdk

# Less additions
#
# TODO the below won't work until we're using gnu less.
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

####################
# Sourced files
####################

# Source git promot which allows for Git details in promot
if [ -f ~/.git-prompt.bash ]; then
    . ~/.git-prompt.bash
fi

# Source git completion based on OS
#
# We want to source correct bash git completion that includes the __git_ps1
# variable that shows the branch of the current directory we're in. This seems
# to be from git-prompt.bash so we seek that first.
#
# manual
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
# macOS CLI tools
elif [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f ~/.bash_git ]; then
    . ~/.bash_git
fi

# Source symfony completion
if [ -f ~/.symfony-completion.bash ]; then
    . ~/.symfony-completion.bash
fi

# Source brew completion
if [ -f ~/.brew-completion.bash ]; then
    . ~/.brew-completion.bash
fi

# go
if [ -f ~/.golangrc ]; then
    . ~/.golangrc
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

####################
# Prompt colors
####################
export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# Note that these _could_ have differing results if being used along with iTerm2
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

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
#export PS1='\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-\[$bold\]\[$black\][\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\w\[$black\]\[$reset\]\[$lt_blue\]$(vcs_name)\[$bold\]\[$black\]]\[$reset\]\n|-$\[$reset\] '

# No call to vcs_name
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
