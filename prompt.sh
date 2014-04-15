#!/bin/sh
red='\033[33;31m';
green='\033[33;32m';

EDITED_BRANCH_COLOR=$red
CLEAN_BRANCH_COLOR=$red

NORMAL_COLOR='\033[33;0m'

function parse_git_branch {
  ref=$(git symbolic-ref --short HEAD 2> /dev/null) || return
  echo -e "[$(cleanliness_color)${ref}${NORMAL_COLOR}] "
}

function cleanliness_color {
  status=$(git status | sed -n '/\(working directory clean\)/p') || return
  if [ -n "${status}" ]; then
    echo -e "${EDITED_BRANCH_COLOR}"
  else
    echo -e "${CLEAN_BRANCH_COLOR}"
  fi
}

function normal_color {
  echo -e "${NORMAL_COLOR}"
}

function current_dir_name {
  echo "${PWD##*/}"
}

PS1="\$(date +%H:%M) \$(whoami) \$(parse_git_branch)$(normal_color)\$(current_dir_name):$ "


