#!/bin/sh
EDITED_BRANCH_COLOR='\[\e[0;31m\]'
CLEAN_BRANCH_COLOR='\[\e[0;32m\]'
NORMAL_COLOR='\033[33;0m'
red='\033[33;31m';
green='\033[33;32m';
dirty_color='\033[33;35m';

function parse_git_branch {
  ref=$(git symbolic-ref --short HEAD 2> /dev/null) || return
  #echo "(${ref})"
 # echo "\$()"
  echo -e "[$(cleanliness_color)${ref}${NORMAL_COLOR}] "
}

function cleanliness_color {
  status=$(git status | sed -n '/\(working directory clean\)/p') || return
  if [ -n "${status}" ]; then
    echo -e "${green}"
    #echo ${CLEAN_BRANCH_COLOR}
  else
    echo -e "${red}"
    #echo ${EDITED_BRANCH_COLOR}
  fi
}

function normal_color {
  echo -e "${NORMAL_COLOR}"
}

function current_dir_name {
  echo "${PWD##*/}"
}

PS1="\$(date +%H:%M) \$(whoami) \$(parse_git_branch)$(normal_color)\$(current_dir_name):$ "


