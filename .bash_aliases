# Common, basic aliases
#
# Don't add aliases you won't use if you're just going to tab the cmd
# out easily anyway. Other things like vagrant and docker have
# alternative commands starting with va* and do*, respectively, so
# those have at least some merit, ignoring the fact that you could
# just type vag[tab] or doc[tab] but whatever...
alias l="ls -a";
alias ll="ls -alhF";
alias ..="cd ..";
alias vi="vim";
alias v="vagrant";
alias d="docker";
alias h="history";
alias curls="curl -sS"

# TODO Honestly would rather move the below date aliases to shell/bash scripts
#      so that they can output for a different input time to date, i.e., so
#      they can either format the present date and/or different dates.

# TODO Add similar date time aliases (or options/args) as the below 'date_*'
#      aliases that include TZs and others that output date time in UTC. See
#      `man strftime` for date formats.
#
# TODO THIS NEEDS TO BE MADE INTO A COMMAND SOONER THAN LATER!!! But for now,
#      I'm renaming all "date" aliases to "datetime" and adding some "date"
#      aliases for date only. I'm adding one more alias

# Just the date in ISO 8601
alias date_i="date -j '+%F'"

# Date and time in ISO 8601-1:2019 (proper) with the now explicitly required
# 'T' separating date and time; in extended separation format. No timezone.
alias datetime_i="date -j '+%FT%T'"

# Date and time in ISO 8601:2004 allowing a space (or anything) between date
# and time similar to some (perhaps older?) DB datetime formats. No timezone.
alias datetime_ii="date -j '+%F %T'"

# Date and time in ISO 8601 in basic format, i.e., no separators. No timezone.
# This can be useful for (file) names. Note the standard allows decimals
# following the smallest time value (seconds here) so something like
# $(datetime_ib).01 can be used for custom needs of the same date time.
alias datetime_ib="date -j '+%Y%m%d%H%M%S'"

# Date and time; same as datetime_ib but with an underscore separating date and
# time.
alias datetime_iu="date -j '+%Y%m%d_%H%M%S'"

# Date and time; same as datetime_iu but with hyphens separating date values.
alias datetime_iuu="date -j '+%Y-%m-%d_%H%M%S'"

# Safely rm, mv, and cp files unless we overrride that decision. Obnoxiously, cp
# doesn't operate like rm and mv in regards to -f overriding -i but there's
# always the `yes` cmd I guess
alias rm="rm -i";
alias mv="mv -i";
alias cp="cp -i";

# docker aws
alias aws="docker run --rm -it amazon/aws-cli";
alias paws="docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli";

# Simply left for a reminder of how much better things are these days
alias sdiff="svn diff|view -";
alias svn-diff="svn diff|view -";

# Common git aliases
alias prune-master-branches="git branch --merged master | grep -v '^ *master$' | grep -v '^ *develop$' | xargs git branch -d";
alias prune-develop-branches="git branch --merged develop | grep -v '^ *master$' | grep -v '^ *develop$' | xargs git branch -d";
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

# Priv bash file for cases where this file is included in a dotfiles type of
# repo.
if [ -f ~/.bash_aliases_priv ]; then
    . ~/.bash_aliases_priv
fi
