#!/bin/bash
#set -e;

cd hooks;
git_hooks_dir=$(pwd)
all_hooks=$(find -type f);

cd ../../
gitroot=$(git rev-parse --show-cdup)

if [ "${gitroot}" != "" ]; then
  cd ${gitroot};
fi

if [ -d .git ]; then
  echo "TODO";
  exit 1;
fi

if [ -f .git ]; then
  hooks_dir=$(cat  ".git" | sed -e "s%gitdir:[ \t]*%%" -e "/^$/d" -e "s%$%/hooks/%")
  cd $hooks_dir
  hooks_dir_absolute=$(pwd)
  relative_path=$(python -c "import os.path; print os.path.relpath('"$git_hooks_dir"', '"$hooks_dir_absolute"')")
  echo "making links: "$all_hooks
  echo $all_hooks" " | while read -d " " hook; do
    full_path=$relative_path"/"$hook
    echo "ln -s "$full_path";"
    ln -s $full_path .
  done
fi
