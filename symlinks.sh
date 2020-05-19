#!/bin/bash

# Vim
ln -s ~/.vim/vimrc ~/.vimrc

# i3
ln -s ~/.vim/i3_config ~/.config/i3/config
ln -s ~/.vim/i3_status.conf ~/.config/i3status/config

# tmux
tmux -f ~/.vim/tmux.conf
