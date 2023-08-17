#!/bin/bash
sudo apt-get -y install build-essential
sudo apt-get -y update
sudo apt -y install make
sudo apt-get -y install cmake
sudo apt-get -y install python-dev-is-python3
sudo apt -y install x11-xkb-utils
source ~/.bashrc
sudo apt-get -y update
source ~/.bashrc
cat ~/.vim/config_files/bashrc >> ~/.bashrc
touch ~/.bash_aliases
cat ~/.vim/config_files/bash_aliases >> ~/.bash_aliases
touch ~/.inputrc
grep -q "set bell-style none" ~/.inputrc || echo "set bell-style none" >> ~/.inputrc
source ~/.bashrc
