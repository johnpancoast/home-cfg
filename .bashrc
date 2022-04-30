# TODO Clean all of this up or break out into separate files. Put things into functions.
# TODO Move appropriate sections to .profile or .bash_profile, for example PATH.

#
# Functions
#

function has_parent_dir()
{
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

function vcs_name()
{
    if [ -d .svn ]; then
        echo "-[svn]";
    elif has_parent_dir ".git"; then
        echo " ($(__git_ps1 '%s'))";
    elif has_parent_dir ".hg"; then
        echo " ($(hg branch))"
    fi
}

# Set PS1 prompt
#
# _Dashed name since this doubles as command._
#
# Depends on vars in this script. For special character meanings in PS1 string
# (like \w), see
# https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
#
# -$1 string The title of the PS1 to switch to.
function set-ps1()
{
    case $1 in
        # Basic prompt. Can be useful for copy/pasting examples among other things.
        basic)
            export PS1='$ ';
            ;;
        # Similar to default prompt but only displays basedir in PWD. This is
        # useful for bash v3 (macOS default) where PROMPT_DIRTRIM doesn't yet exist.
        default-base-dir)
            export PS1='\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-\[$bold\]\[$black\][\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\W\[$black\]\[$reset\]\[$lt_blue\]$(vcs_name)\[$bold\]\[$black\]]\[$reset\]\n|-$\[$reset\] '
            ;;
        # Default prompt containing two lines with first containing time,
        # use/system, pwd, and vcs info if in a repo directory with second line
        # allowing for command input. Assumes bash version >= 4 since it
        # implicitly relies on PROMPT_DIRTRIM to limit PWD's length.
        default| * )
            export PS1='\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-\[$bold\]\[$black\][\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\w\[$black\]\[$reset\]\[$lt_blue\]$(vcs_name)\[$bold\]\[$black\]]\[$reset\]\n|-$\[$reset\] ';
            ;;
    esac

    # TODO Was attemping to simplify how PS1 is created and was just breaking shit... remove below if won't be used
    #
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
}

#
# Common env variables
#
export EDITOR=/usr/bin/vim
export ANDROID_HOME=~/Library/Android/sdk

#
# Less additions
#
# TODO the below won't work until we're using gnu less.
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
#

# Set colors for less. Borrowed from:
# https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

#
# Sourced files
#

# Git prompt
if [ -f ~/.git-prompt.bash ]; then
    . ~/.git-prompt.bash
fi

# Git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
elif [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f ~/.bash_git ]; then
    . ~/.bash_git
fi

# Symfony
if [ -f ~/.symfony-completion.bash ]; then
    . ~/.symfony-completion.bash
fi

# Homebrew
if [ -f ~/.brew-completion.bash ]; then
    . ~/.brew-completion.bash
fi

# go
if [ -f ~/.golangrc ]; then
    . ~/.golangrc
fi

# Priv bash file for cases where this file is included in a dotfiles type of
# repo.
if [ -f ~/.bashrc_priv ]; then
    . ~/.bashrc_priv
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#
# Prompt colors
#
# TODO consider moving this section to ~/.bash_profile
export CLICOLOR=1

# Note that these could have differing results if being used along with iTerm2 (obviously)
#
# Use https://geoff.greer.fm/lscolors/ for some possible help
# TODO Decide. Have saved a few different colors for now...
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
#export LSCOLORS="EHfxcxdxBxegecabagacad"
#export LSCOLORS="ExGxBxDxCxEgEdxbxggcgd"
#export LSCOLORS="ExGxBxDxCxExEdxbxxgxax"
export LSCOLORS="ExGxBxDxCxEgEdxbxggcad"

#
# Terminal prompt, PS1
#

black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)

bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)

# Env var to set the amount of directories, up to current base directory, to be
# displayed in the prompt's \w and \W special character values. You can also
# change this in CLI and it will change PS1 dynamically.
export PROMPT_DIRTRIM=4;

# Set PS1. You can also call this from CLI to change PS1. See options within the set-ps1 function.
set-ps1 "default";

#
# General
#

# ls colors
[ "$TERM" = "xterm" ] && TERM="xterm-256color"
#alias ls='ls --color'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
