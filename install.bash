#!/bin/bash
git_hooks_dir=$(pwd)
cd ../
gitroot=$(git rev-parse --show-cdup)

if [ "${gitroot}" != "" ]; then
  cd ${gitroot};
fi

if [ -d .git ]; then
  echo "TODO";
  exit 1;
fi

if [ -f .git ]; then
  tmpfile_name=git_hooks.tmp.bash
  hooks_dir=$(cat  ".git" | sed -e "s%gitdir:[ \t]*%%" -e "/^$/d" -e "s%$%/hooks/%")
  cd $hooks_dir
  hooks_dir_absolute=$(pwd)
  relative_path=$(python -c "import os.path; print os.path.relpath('"$git_hooks_dir"', '"$hooks_dir_absolute"')")
  hook=$relative_path"/hooks/hook" 
  echo $hook
  ln -s $hook .
  #rm $tmpfile
fi
