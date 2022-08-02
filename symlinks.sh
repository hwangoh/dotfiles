#!/bin/bash

# Vim
ln -s ~/.vim/vimrc ~/.vimrc

# i3
ln -s ~/.vim/config_files/i3_config ~/.config/i3/config
ln -s ~/.vim/config_files/i3_status.conf ~/.config/i3status/config

# tmux
tmux -f ~/.vim/config_files/tmux.conf
