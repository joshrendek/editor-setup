#!/bin/bash
normal=$'\e[0m'                           # (works better sometimes)
bold=$(tput bold)                         # make colors bold/bright
green=$(tput setaf 2)                     # dim green text
pwd=$(pwd)
if [ ! -d "~/.emacs.d/prelude" ]; then
  echo "Installing Prelude"
  curl -L https://git.io/epre | sh
else
  echo "Updating prelude"
  cd ~/.emacs.d; git pull origin master
  cd $pwd
fi

echo "Installing custom.el"
cp custom.el ~/.emacs.d/personal/custom.el

echo "Installing & Updating language specific plugins:"

echo -n "   -> Go plugins..."
./go.sh
echo "${green}${bold} [ DONE ] ${normal}"
