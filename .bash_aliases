# my aliases
alias ls="ls -pF"
alias l="ls"
alias vi="vim"
alias v="vim"
alias xx="sudo"
alias Less="less"
alias ill="cd ~/sites"
alias lorum="cat ~/lorum_ipsum|less"
alias okc="ssh illskittle@okcomp"
alias jp="ssh shideon@johnpancoast.com"
alias mygpg="gpg -c --force-mdc"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias search-php="firefox http://php.net/${1}"
alias pingrouter="ping -i .2 192.168.1.1"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# connect to db
alias sqlsh="sqlsh.sh"
alias db="sqlsh.sh"

# some mysqldump quickies
alias getdb="mysqldump -u root -p"
alias getdb-data="mysqldump -c -n -t -u root -p"
alias getdb-structure="mysqldump -d -u root -p"

# ssh aliases
h_ray="72.199.106.84"
h_wsmdev="wsmdev.com"
h_booze="192.168.1.199"
h_exalted="exalted.onlinegenesis.com"
h_stalking="stalkingscience.com"
h_home1="192.168.0.3"
h_lcdev="192.168.100.142"
h_amgdev="artmediadev.com"
h_amgdev_repo="http://john@hh.artmediadev.com/repos/dev1/trunk"
h_climateone="184.73.235.21"
h_nk2dev="nk2dev.uecloud.net"
h_job="ec2-23-23-3-156.compute-1.amazonaws.com"
h_edum="edum.uecloud.net"
h_aedev="dev.agentelephant.com"
h_calculon="calculon.uecloud.net"
h_newedum="ec2-174-129-154-33.compute-1.amazonaws.com"
h_swf1="54.224.250.8"
h_dev_allstate="ec2-50-17-81-169.compute-1.amazonaws.com"
h_allweb1="allweb1.uecloud.net"
h_allweb2="allweb2.uecloud.net"
h_allsolr1="allsolr1.uecloud.net"
h_allsolr2="allsolr2.uecloud.net"
h_intapi="allstate.int.uecloud.net"
h_allapi="allapi.uecloud.net"
h_allapi2="allapi2.uecloud.net"
h_allcli="allcli.uecloud.net"
h_work="ssh.elephanthub.net"
h_jp="johnpancoast.com"
alias s-ray="ssh john@${h_ray} -p 8008"
alias s-wsmdev="ssh -i /Users/johnpancoast/.ssh/wsmdev jpancoast@${h_wsmdev}"
alias s-exalted="ssh jpancoast@${h_exalted} -p 1282"
alias s-booze="ssh john@${h_booze}"
alias s-stalking="ssh stalkin2@${h_stalking}"
alias s-home1="ssh john@${h_home1}"
alias s-lcdev="ssh cmaher@${h_lcdev}"
alias s-amgdev="ssh john@${h_amgdev}"
alias s-climateone="ssh -i /Users/johnpancoast/.ssh/climateone_key.pem root@${h_climateone}"
alias s-nk2dev="ssh ${h_nk2dev}"
alias s-job="ssh ${h_gm}"
alias s-edum="ssh ${h_edum}"
alias s-aedev="ssh ${h_aedev}"
alias s-calculon="ssh jpancoast@$h_calculon"
alias s-newedum="ssh jpancoast@$h_newedum"
alias s-swf1="ssh jpancoast@$h_swf1"
alias s-dev-allstate="ssh jpancoast@$h_dev_allstate"
alias s-dev-allstate-tunnel="ssh jpancoast@localhost -p 7779"
alias s-allweb1="ssh jpancoast@$h_allweb1"
alias s-allweb2="ssh jpancoast@$h_allweb2"
alias s-allsolr1="ssh jpancoast@$h_allsolr1"
alias s-allsolr2="ssh jpancoast@$h_allsolr2"
alias s-intapi="ssh jpancoast@$h_intapi"
alias s-allapi="ssh jpancoast@$h_allapi"
alias s-allapi2="ssh jpancoast@$h_allapi2"
alias s-allcli="ssh jpancoast@$h_allcli"
alias s-work="ssh jpancoast@$h_work"
alias s-jp="ssh jpancoast@$h_jp"

# other
alias tunnel-ssh-nk2dev="ssh -v -l jpancoast -i /Users/johnpancoast/.ssh/id_dsa -L 7777:50.19.18.60:22 ssh.elephanthub.net cat -"
alias tunnel-ssh-aedev="ssh -v -l jpancoast -i /Users/johnpancoast/.ssh/id_dsa -L 7778:184.72.129.43:22 ssh.elephanthub.net cat -"
alias tunnel-ssh-allstate-dev="ssh -v -l jpancoast -i /Users/johnpancoast/.ssh/id_dsa -L 7779:ec2-50-17-81-169.compute-1.amazonaws.com:22 ssh.elephanthub.net cat -"
alias tunnel-web-allstate-dev="ssh -v -l jpancoast -i /Users/johnpancoast/.ssh/id_dsa -L 7780:ec2-50-17-81-169.compute-1.amazonaws.com:80 ssh.elephanthub.net cat -"
#alias tunnel-web-genghisv="ssh -v -l jpancoast -i /Users/johnpancoast/.ssh/id_dsa -L 7779:107.22.21.216:80 ssh.elephanthub.net cat -"
alias tunnel-ssh-swf1-dev="ssh -v -l jpancoast -i /Users/johnpancoast/.ssh/id_dsa -L 7781:54.224.250.8:22 ssh.elephanthub.net cat -"

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

# some more ls aliases
alias ls='ls -ph'
alias ll='ls -l'
alias ..='cd ..'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
