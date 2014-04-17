#!/bin/sh
red=$(tput setaf 1)
green=$(tput setaf 2)
normal=$(tput sgr0)

EDITED_BRANCH_COLOR=$red
CLEAN_BRANCH_COLOR=$green
NORMAL_COLOR=$normal

function parse_git_branch {
  repo=$(ls -a | grep '.git$')
  if [ -n "${repo}" ]; then
    ref=$(git symbolic-ref --short HEAD 2> /dev/null) || return
    echo -e " [${ref}]"
  else
    return
  fi
}

function cleanliness_color {
  repo=$(ls -a | grep '.git$')
  if [ -n "${repo}" ]; then
    status=$(git status | sed -n '/\(working directory clean\)/p') || return
    if [ -n "${status}" ]; then
      echo -e $CLEAN_BRANCH_COLOR
    else
      echo -e $EDITED_BRANCH_COLOR
    fi
  else
    return
  fi  
}

function current_dir_name {
  echo -e "${PWD##*/}"
}

function current_time {
  echo -e $(date +%H:%M)
}

# This is the string that will be printed out to the console
PS1='\[${NORMAL_COLOR}\]`current_time`\[$(cleanliness_color)\]`parse_git_branch`\[${NORMAL_COLOR}\] `current_dir_name`> '
