# Common, basic aliases
#
# Don't add aliases you won't use if you're just going to tab the cmd out
# easily anyway. Other things like vagrant and docker have alternative commands
# starting with va* and do*, respectively, so those have at least some merit,
# ignoring the fact that you could just type vag[tab] or doc[tab] but whatever...
# aliases are for me, pinche pendejos...
alias ll="ls -lah"
alias ..="cd .."
alias vi="vim"
# For me common fat fingers
alias Less="less"
alias v="vagrant"
alias d="docker"

# Safely rm, mv, and cp files unless we overrride that decision. Obnoxiously, cp
# doesn't operate like rm and mv in regards to -f overriding -i but there's
# always the `yes` cmd I guess
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# TODO Consider just using brew to install linux' tree =)
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# Simply left for a reminder of how much better things are these days
alias sdiff="svn diff|view -"
alias svn-diff="svn diff|view -"

# Common git aliases
alias prune-master-branches="git branch --merged master | grep -v '^ *master$' | grep -v '^ *develop$' | xargs git branch -d"
alias prune-develop-branches="git branch --merged develop | grep -v '^ *master$' | grep -v '^ *develop$' | xargs git branch -d"
alias git-log="git log --author-date-order"

# Common docker aliases
# TODO are we using this or what??
#alias docker-cleanup="docker rm $(docker ps -aq); docker rmi $(docker images --filter dangling=true --quiet)"

# Mysqldump shortcuts
alias getdb="mysqldump -u root -p"
alias getdb-data="mysqldump -c -n -t -u root -p"
alias getdb-structure="mysqldump -d -u root -p"

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

# read a private bash alias if exists
# useful when aliases exist for things which shouldn't
# be in public repo
if [ -f ~/.bash_aliases_priv ]; then
    . ~/.bash_aliases_priv
fi
