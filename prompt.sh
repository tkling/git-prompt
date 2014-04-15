EDITED_BRANCH_COLOR=" \[\e[0;31m\]"
CLEAN_BRANCH_COLOR=" \[\e[0;32m\]"
NORMAL_COLOR='\[\e[0m\]'

function parse_git_branch {
  ref=$(git symbolic-ref --short HEAD 2> /dev/null) || return
  #echo "(${ref})"
 # echo "\$()"
  echo "[${ref} $(cleanliness_color)] "
}

function cleanliness_color {
  status=$(git status | sed -n '/\(working directory clean\)/p') || return
  if [ -n "${status}" ]; then
    echo "clean" 
    # echo ${CLEAN_BRANCH_COLOR}
  else
    echo "dirty" 
    # echo ${EDITED_BRANCH_COLOR}
  fi
}

function normal_color {
  echo "${NORMAL_COLOR}"
}

function current_dir_name {
  echo "${PWD##*/}"
}

PS1="\$(date +%H:%M) \$(whoami) \$(parse_git_branch)$(normal_color)\$(current_dir_name):$ "

#PS1='`date +%H:%M` `whoami` \[`cleanliness_color`\]`parse_git_branch``normal_color``current_dir_name`:$ '
#PS1="\$(__git_ps1 \"(%s)\")"

