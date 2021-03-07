# Common, basic aliases
#
# Don't add aliases you won't use if you're just going to tab the cmd
# out easily anyway. Other things like vagrant and docker have
# alternative commands starting with va* and do*, respectively, so
# those have at least some merit, ignoring the fact that you could
# just type vag[tab] or doc[tab] but whatever...
alias l="ls -lahF";
alias ll="l"
alias ..="cd ..";
alias vi="vim";
alias v="vagrant";
alias d="docker";

# TODO Honestly would rather move these to shell/bash scripts so that
#      they can output for a different input time to date, i.e., so they can
#      either format the present date and/or fdifferent dates.

# Date and time in ISO 8601-1:2019 (proper) with the now explicitly required
# 'T' separating date and time; in extended separation format. No timezone.
alias date_i="date '+%FT%T'"

# Date and time in ISO 8601:2004 allowing a space (or anything) between date
# and time similar to some (perhaps older?) DB datetime formats. No timezone.
alias date_ii="date '+%F %T'"

# Date and time in ISO 8601 in basic format, i.e., no separators. No timezone.
# This can be useful for (file) names. Note the standard allows decimals
# following the smallest time value (seconds here) so something like
# $(date_ib).01 can be used for custom needs of the same date time.
alias date_ib="date '+%Y%m%d%H%M%S'"

# Date and time; same as date_ib but with an underscore separating date and
# time.
alias date_iu="date '+%Y%m%d_%H%M%S'"

# Date and time; same as date_iu but with hyphens separating date values.
alias date_iuu="date '+%Y-%m-%d_%H%M%S'"

# TODO Add similar date time aliases as the above 'date_*' aliases that include
#      TZs and others that output date time in UTC. See `man strftime` for date
#      formats.

# Safely rm, mv, and cp files unless we overrride that decision. Obnoxiously, cp
# doesn't operate like rm and mv in regards to -f overriding -i but there's
# always the `yes` cmd I guess
alias rm="rm -i";
alias mv="mv -i";
alias cp="cp -i";

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

# read a private bash alias file which is useful in cases where this aliases
# file is in a dotfiles repo and we have other private aliases.
if [ -f ~/.bash_aliases_priv ]; then
    . ~/.bash_aliases_priv
fi
