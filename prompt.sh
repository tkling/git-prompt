#!/bin/sh
red='\033[33;31m';
green='\033[33;32m';

EDITED_BRANCH_COLOR=$red
CLEAN_BRANCH_COLOR=$green
NORMAL_COLOR='\033[33;0m'

function parse_git_branch {
  ref=$(git symbolic-ref --short HEAD 2> /dev/null) || return
  echo -e " [$(cleanliness_color)${ref}${NORMAL_COLOR}]"
}

function cleanliness_color {
  status=$(git status | sed -n '/\(working directory clean\)/p') || return
  if [ -n "${status}" ]; then
    echo -e "${CLEAN_BRANCH_COLOR}"
  else
    echo -e "${EDITED_BRANCH_COLOR}"
  fi
}

function current_dir_name {
  echo "${PWD##*/}"
}

function current_time {
  echo $(date +%H:%M)
}

function prompt_string {
  echo -e "${NORMAL_COLOR}$(current_time)$(parse_git_branch) $(current_dir_name)"
}

#This is the string that will be printed out to the console
PS1="\$(prompt_string):$ "


