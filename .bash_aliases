#
# Common, basic aliases
#
# Don't add aliases you won't use if you're just going to tab the cmd out
# easily anyway. Sometimes aliases get added that never get used so just don't
# =P. And to all the hipsters who'll read this, z shell schmee shell, I'm fine
# with bash!
alias l="ls -a";
alias ll="ls -alh";
alias ..="cd ..";
alias vi="vim";
alias v="vagrant";
alias d="docker";
alias h="history";
alias curls="curl -sS"

#
# Dates
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
#      current underscored aliases, I will use dashed aliases of the underscored
#      aliases. The reasoning behind this change is that aliases are like
#      commands and I prefer commands to be named with dash separators.
#      Underscores are used for shell variables.

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

# Safely rm, mv, and cp files unless we overrride that decision. Obnoxiously, cp
# doesn't operate like rm and mv in regards to -f overriding -i but there's
# always the `yes` cmd I guess
alias rm="rm -i";
alias mv="mv -i";
alias cp="cp -i";

# docker aws
alias aws="docker run --rm -it amazon/aws-cli";
alias paws="docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli";

# get current ip from ifconfig
# First aliases requires GETIP_LOOKUP_INTERFACE be set in envoronment
alias getip="ifconfig | grep ${GETIP_LOOKUP_INTERFACE} -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";
alias getip_en0="ifconfig | grep en0 -A 5 | grep inet | sed -E 's/.*inet ([0-9.]+) netmask.*/\1/'";

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
# $comon_dirs - Common directories
#
# Commonly accessed directories and their names in an associative array where
# each key is an underscored directory name and each vaue is a directory's
# path. These directories will be used to create shortcut'ish commands and/or
# aliases.
#
# To add a common directory to this array, add a key/value pair for the
# directory, where the key is an underscored directory name and where the value
# is the directory's path.
#
# -- Current features for elemenets in the `$common_dirs` array --
#
#    For example's sake, assume our code has the following line defining a "code" directory name with a value of a path "~/my/code".
#
#       $common_dirs[code]="~/my/code";
#
# * The `$common_dirs` array will be in scope, i.e., a `${common_dirs[code]}`
# variable will be available. But even better...
#
# * For each `{key}` (directory name) in the `$common_dirs` array, a variable
# named `$d_{key}` will be created with the directory path as the value, i.e.,
# ${d_code} will exist with a value of `~/my/code`. The `$d_` prefix of these
# variables denote that they're a "(d)irectory".
#
# * For each `{key}` (directory name) in the `$common_dirs` array, an alias
# named `c-{key}` will be created (with dashes instead of underscores) which
# will `cd` to the directory value, i.e., an alias like the following will be
# created: `alias c-code="cd ${d_code}";`.  The `c-` prefix of these aliases
# denote that they "(c)hange directory".
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
for dir_name in ${!common_dirs[@]}; do
    dir_value="${common_dirs[$dir_name]}";

    # declare our variable(s) to export. Name variable(s) using underscore
    # separators (which are assumed here at present).
    declare d_${dir_name}="${dir_value}";
    export "d_${dir_name}";

    # Create alias(es) to cd to dir. Name alias(es) using dash separators.
    alias "c-${dir_name//_/-}"="cd ${dir_value}";
done
