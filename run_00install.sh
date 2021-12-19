#!/bin/bash

# Packages needed and not installed by this script:
#       neovim (needs to be built from source if on ubuntu)
#       fish
#       fzf
#       powerline

USER_PATH=/home/travis/

#################
# Base 16 setup #
#################
git clone https://github.com/chriskempson/base16-shell.git $USER_PATH.config/base16-shell

################
# Neovim setup #
################
mkdir -p $USER_PATH.local/share/nvim/
mkdir -p $USER_PATH.config/nvim
python3 -m venv $USER_PATH.local/share/nvim/venv

# Install python neovim package for python support
$USER_PATH.local/share/nvim/venv/bin/python3 -m pip install neovim
$USER_PATH.local/share/nvim/venv/bin/python3 -m pip install python-language-server
$USER_PATH.local/share/nvim/venv/bin/python3 -m pip install rope pyflakes

# Install vim-plug
curl -fLo $USER_PATH.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install and update if there were changes
nvim --headless +PlugInstall +qa
nvim --headless +PlugUpdate +qa
