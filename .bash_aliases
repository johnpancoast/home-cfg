#
# Bash aliases
#
# A long-term goal for my dotfiles such as this one (and for related home
# configuration) is for them to be compatible across different linux and unix
# systems. At the moment, many aliases are system specific, namely for macOS.

#
# Common, basic aliases
#
alias l="ls -a";
alias ll="ls -alh";
alias ..="cd ..";
alias vi="vim";
alias v="vagrant";
alias d="docker";
alias h="history";
alias curls="curl -isS"
# Safely rm, mv, and cp files unless we overrride that decision with -f (I nerf
# myself when I'm working quickly) Obnoxiously, cp doesn't operate like rm and
# mv in regards to -f overriding -i but there's always the `yes` cmd to prepend
# to the command.
alias rm="rm -i";
alias mv="mv -i";
alias cp="cp -i";
# For working with bare clone of the home-cfg repo and allowing for easy management of dotfiles and the like
alias home-cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

#
# Date and datetime aliases for simple formatting.
#
# TODO Change below date aliases to use functions (or move them to scripts) so
#      that they can accept input. For example, perhaps different date and time
#      input or flags to print epoch, etc.
#
# TODO Add similar date time aliases (or options/args) as the below 'date_*'
#      aliases that include TZs and others that output date time in UTC. See
#      `man strftime` for date formats.
#
# TODO (in progress) Add aliases with dashes instead of underscores. For
#      portability, and until I've determined that nothing calls upon the
#      current underscored aliases, I will use dashed aliases that alias to the
#      current underscored aliases. The reasoning behind this change is that
#      aliases are like commands and I prefer commands to be named with dash
#      separators. Underscores are used for shell variables.

# Date in ISO-8601 format.
alias date_i="date -j '+%F'"
alias date-i='date_i';

# Date and time in ISO 8601 format with the `T` (time) character separating
# date and time. No UTC offset.
alias datetime_i="date -j '+%FT%T'"
alias datetime-i="datetime_i";

# Date and time in ISO 8601 extended format with a space separating date and
# time. No UTC offset. This is similar to some DB datetime formats.
alias datetime_ii="date -j '+%F %T'"
alias datetime-ii="datetime_ii";

# Date and time in ISO 8601 basic format without separators. No UTC offset.
alias datetime_ib="date -j '+%Y%m%d%H%M%S'"
alias datetime-ib="datetime_ib";

# Date and time in ISO 8601 basic format with an underscore separating date and
# time. No UTC offset.
alias datetime_iu="date -j '+%Y%m%d_%H%M%S'"
alias datetime-iu="datetime_iu";

# Date and time in ISO 8601 (semi-)basic format with dashes separating date
# values, an underscore separating date and time, and no separators between time
# values. No UTC offset.
alias datetime_iuu="date -j '+%Y-%m-%d_%H%M%S'"
alias datetime-iuu="datetime_iuu";

# Shorter datetime aliases for convenience
alias dt="datetime-iu";
alias ts="dt";

# docker aws
#alias aws="docker run --rm -it amazon/aws-cli";
#alias paws="docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli";

# TODO Move this declaration and below getip* aliases into function and make system independent.
[[ $IFCONFIG_INTERFACE != "" ]] && LOCAL_IFCONFIG_INTERFACE="$IFCONFIG_INTERFACE" || LOCAL_IFCONFIG_INTERFACE="en0";

# Get current ip from ifconfig (currently macOS only)
#
# There are a few optional ways to define the interface for these aliases.
#   1. Use `getip` to get the IP for the default `en0` interface, assuming the
#      `$IFCONFIG_INTERFACE` environment variable hasn't been set.
#   2. Set the `$IFCONFIG_INTERFACE` environment variable to something aside from the drfault.
#   3. Use the hardcoded interface commands like getip_en0, getip_en1, etc.
alias getip="ifconfig | grep ${LOCAL_IFCONFIG_INTERFACE} -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";
alias getip_en0="ifconfig | grep en0 -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";
alias getip_en1="ifconfig | grep en1 -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";
alias getip_en2="ifconfig | grep en2 -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";
alias getip_en3="ifconfig | grep en3 -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";
alias getip_en4="ifconfig | grep en4 -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";

# Simply left for a reminder of how much better things are these days
alias sdiff="svn diff|view -";
alias svn-diff="svn diff|view -";

# Common git aliases
# TODO Review these since it's been a minute
# alias prune-main-branches="git branch --merged main | grep -v '^ *main$' | grep -v '^ *develop$' | xargs git branch -d";
# alias prune-master-branches="git branch --merged master | grep -v '^ *master$' | grep -v '^ *develop$' | xargs git branch -d";
# alias prune-develop-branches="git branch --merged develop | grep -v '^ *master$' | grep -v '^ *develop$' | xargs git branch -d";
alias git-log="git log --author-date-order";

# Common docker aliases
# TODO are we using this or what??
#alias docker-cleanup="docker rm $(docker ps -aq); docker rmi $(docker images --filter dangling=true --quiet)";

# Mysqldump shortcuts
alias getdb="mysqldump -u root -p";
alias getdb-data="mysqldump -c -n -t -u root -p";
alias getdb-structure="mysqldump -d -u root -p";

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# $common_dirs
#
# A hashmap of commonly accessed directories where each key is a directory name
# (no spaces, underscore or dash separated) and each value is the directory
# path. For example, "example-name" => "/example/dir". Each directory name and
# path will have useful variables and aliases created so they can be accessed
# programmatically.
#
# You can add to the ${common_dirs} array in this, or sourced, files such as
# the `~/.bash_aliases_priv` file sourced below.
#
# Use the following syntax and make sure to use double quotes and proper
# escapes while taking into account bash's expansions:
#
#   ```
#   common_dirs[foo-bar]="~/foo/bar";
#   ```
#
# The following notes apply to this array and its elements:
#
# * The `$common_dirs` array will be in the shell's scope of course.
#
# * For each `[key]` in the `$common_dirs` array, a variable named `$d_[key]`
#   will be created (with all dashes converted to underscores) where the value
#   is the directory. This allows each directory to be accessed
#   programatically.
#
# * For each `[key]` in the `$common_dirs` array, an alias named `c-[key]` will
#   be created (with all underscores converted to dashes) which will `cd` to
#   the directory value.
declare -A common_dirs;

# Common dirs. See comments above where $common_dirs is declared.
#
#common_dirs[foobar]="~/foo/bar";

# Common hosts
# TODO Add same concept as common_dirs but for common_hosts along with ssh
# capability (think of data structure for that). For now keep it simple
declare -A common_hosts;

# Common hosts. See comments above where $common_hosts is declared.
#common_hosts[name]="example.com";

# Source additional aliases. Useful if this file is part of a repo and sourced
# file isn't. This can add to $common_* variables as necessary.
if [ -f ~/.bash_aliases_priv ]; then
    . ~/.bash_aliases_priv
fi

# Loop $common_dirs` and create useful variables and aliases.
# See docs above where $common_dirs array is declared.
for dir_name in ${!common_dirs[@]}; do
    dir_value="${common_dirs[$dir_name]}";

    # For now our substitution is simply based on naming convention assumptions
    # but we can improve the substitutions later if necessary.
    dir_name_underscored=${dir_name//-/_};
    dir_name_dashed=${dir_name//_/-};

    # Declare a variable named $d_[key] where [key] is underscored key name of
    # this iteration and where the value is the directory.
    declare d_${dir_name_underscored}="${dir_value}";
    export "d_${dir_name_underscored}";

    # Create alias to cd to this directory. Declares an alias named c-[key]
    # where [key] is the dashed key name of this iteration and where the alias
    # values cd's to the directory.
    alias "c-${dir_name_dashed}"="cd ${dir_value}";

    # Of course much more can be done for these directories. Things may get
    # more contextual and possibly even live in other called scripts but for
    # now, this just allows quicker actions on common paths.
done

# TODO Loop $common_hosts similarly to $common_dirs to set useful vars.
# For now, vars or aliases may be created manually.
