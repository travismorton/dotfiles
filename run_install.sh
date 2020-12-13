#!/bin/bash

# Packages needed and not installed by this script:
#       neovim (needs to be built from source if on ubuntu)
#       fish
#       fzf
#       powerline

USER_PATH=/home/travis/

################
# Neovim setup #
################
mkdir -p $USER_PATH.local/share/nvim/
mkdir -p $USER_PATH.config/nvim
python3 -m venv $USER_PATH.local/share/nvim/venv

# Install python neovim package for python support
$USER_PATH.local/share/nvim/venv/bin/python3 -m pip install neovim

# Install vim-plug
curl -fLo $USER_PATH.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install and update if there were changes
nvim --headless +PlugInstall +qa
nvim --headless +PlugUpdate +qa
