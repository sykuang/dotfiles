#!/bin/bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

if [[ -z `which curl` && -z `which wget` && -z `which lftp` ]];then
  echo "Please install one of below command: curl, wget or lftp"
  exit 1
fi

if command -v alacritty &> /dev/null;then
  if [[ ! -f $HOME/.config/alacritty/alacritty.yml ]];then
    mkdir -p $XDG_CONFIG_HOME/alacritty/
    ln -s $SCRIPT_PATH/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
  fi
fi

# Setup for neovim
if command -v nvim &> /dev/null;then
  $SCRIPT_PATH/nvim-config/install.sh
fi

# Setup for git config
if [[ ! -f $HOME/.gitconfig ]];then
  ln -s $SCRIPT_PATH/gitconfig $HOME/.gitconfig
fi

# Setup zshrc
[[ -f $SCRIPT_PATH/zshrc/install.sh ]] && $SCRIPT_PATH/zshrc/install.sh
