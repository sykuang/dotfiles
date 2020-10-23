#!/bin/bash

SCRIPT_PATH=$(dirname $(realpath -s $0))
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
if [[ -z `which curl` && -z `which wget` && -z `which lftp` ]];then
  echo "Please install one of below command: curl,wget or lftp"
  exit 1
fi
if [[ ! -f $HOME/.config/alacritty/alacritty.yml ]];then
mkdir -p $XDG_CONFIG_HOME/alacritty/
ln -s $SCRIPT_PATH/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
fi
if [[ ! -f $XDG_CONFIG_HOME/nvim/init.vim ]];then
mkdir -p $XDG_CONFIG_HOME/nvim/
ln -s $SCRIPT_PATH/init.vim $XDG_CONFIG_HOME/nvim/init.vim
fi

if [[ ! -f $HOME/.gitconfig ]];then
  ln -s $SCRIPT_PATH/gitconfig $HOME/.gitconfig
fi

if [[ ! -f $HOME/.config/starship.toml ]];then
  ln -s $SCRIPT_PATH/starship.toml $HOME/.config/starship.toml
fi

if [[ ! -f $HOME/.zshrc ]];then
  if [ -z `which exa` ];then
    echo "Please install exa for zshrc"
    exit 1
  fi
  if [ -z `which svn` ];then
    echo "Please install svn for zshrc"
    exit 1
  fi
  ln -s $SCRIPT_PATH/zshrc/zshrc $HOME/.zshrc
fi

if [[ ! -f $HOME/.vimrc ]];then
  ln -s $SCRIPT_PATH/vimrc/vimrc $HOME/.vimrc
  pip install pynvim
  if [[ -f $SCRIPT_PATH/vimrc/install.sh ]];then
    $SCRIPT_PATH/vimrc/install.sh
  fi
fi
