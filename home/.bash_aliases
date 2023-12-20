#!/bin/bash

# Because I never use Python 2
alias python=python3

command -v batcat >/dev/null || alias batcat=bat
alias cat=batcat

alias ls='exa --icons -F -H --group-directories-first --git'
