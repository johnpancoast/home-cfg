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
alias curls="curl -sS"

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

# Sinplified alias of date and time in ISO 8601 basic format with an underscore
# separating date and time. No UTC offset.
alias ts="datetime-iu";

# Safely rm, mv, and cp files unless we overrride that decision. Obnoxiously, cp
# doesn't operate like rm and mv in regards to -f overriding -i but there's
# always the `yes` cmd I guess
alias rm="rm -i";
alias mv="mv -i";
alias cp="cp -i";

# docker aws
#alias aws="docker run --rm -it amazon/aws-cli";
#alias paws="docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli";

[[ $IFCONFIG_INTERFACE != "" ]] && LOCAL_IFCONFIG_INTERFACE="$IFCONFIG_INTERFACE" || LOCAL_IFCONFIG_INTERFACE="en0";

# get current ip from ifconfig.
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

#
# $common_dirs
#
# An associative array of commonly accessed directories where each array key is
# a directory name (underscore or dash separated) and each value is the
# directory path. For example, "example-name" => "/example/dir". Each directory
# name and path will have useful variables and aliases created so they can be
# accessed programmatically.
#
# You can add to the ${common_dirs} associate array in either your private
# git-ignored `~/.bash_aliases_priv` file or you can add to the array in this
# file if the addition is general and meant for public use in a public repo. Use
# the following syntax in either case (use double quotes for values and escape
# spaces with slashes):
#
#   ```
#   common_dirs[my-pics]="~/Documents";
#   ```
#
# The following notes apply to this array and its elements:
#
# * The `$common_dirs` array will be in the shell's scope. But even better...
#
# * For each `[key]` in the `$common_dirs` array, a variable named `$d_[key]`
#   will be created with the directory path as the value. The `d_` prefix
#   denotes directory.
#
# * For each `[key]` in the `$common_dirs` array, an alias named `cd-[key]` will
#   be created (with dashes instead of underscores) which will `cd` to the
#   directory value. An equivalent alias of `c-[key]` will also be created.
declare -A common_dirs;

# Private bash aliases file which is not included in this repository. This is
# useful for machine specific aliases and/or aliases that don't belong in this
# file or the repo this file lives in.
#
# Note that the `$common_dirs` array can also be added to from this file.
if [ -f ~/.bash_aliases_priv ]; then
    . ~/.bash_aliases_priv
fi

# Loop any defined `$common_dirs` elements. See docs above where $common_dirs
# array is declared.
# TODO Fix this mess. Only the cd-* aliases will work but the $d_* variables
#      with tildes will not work due to bash's expansion rules.
for dir_name in ${!common_dirs[@]}; do
    dir_value="${common_dirs[$dir_name]}";

    # For now our substitution is simple based on naming convention assumptions
    # but we can improve the substitutions later if necessary.
    dir_name_underscored=${dir_name//-/_};
    dir_name_dashed=${dir_name//_/-};

    # Declare our variable(s) to export. This will declare variables named
    # ${d_[key]} where [key] is the array key (directory name) of this
    # iteration. That is, all array keys in ${common_dirs} will end up with
    # underscored variables prefixed with `d_` (directory) and a value of the
    # dir path. This allows important directories to be referenced
    # programmatically.
    declare d_${dir_name_underscored}="${dir_value}";
    export "d_${dir_name_underscored}";

    # Create alias(es) to easily change to the directories. This will declare
    # aliases named `cd-[key]` and and equivalent `c-[key]` where [key] is the
    # array (directory name) and the alias changes to the directory path of the
    # value. Alias(es) are named using dash separators.
    alias "cd-${dir_name_dashed}"="cd ${dir_value}";
    alias "c-${dir_name_dashed}"="cd-${dir_name_dashed}"; # alias of the above alias name

    # Of course much more can be done for these directories. Things may get more
    # contextual and possibly even live in other called scripts but this just
    # allows quicker actions on common paths.
done
