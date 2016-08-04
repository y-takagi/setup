#!/bin/bash
set -e
current_path=`pwd`

# symbolic link
ln -sf .bash_profile ~/.bash_profile
ln -sf .bashrc ~/.bashrc
ln -sf .bash.d ~/.bash.d
ln -sf .gitconfig ~/.gitconfig
ln -sf .tmux.conf ~/.tmux.conf
ln -sf .peco ~/.peco

# ssh鍵の設定
mkdir ~/.ssh
cat id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# cask & emacs
git clone https://github.com/cask/cask.git ~/.cask
git clone https://github.com/y-takagi/emacs.d.git ~/.emacs.d
cd ~/.emacs.d && cask install

# peco
mkdir ~/tmp && cd ~/tmp/
wget "https://github.com/peco/peco/releases/download/v0.3.6/peco_linux_amd64.tar.gz" | tar zxvf
sudo cp peco_linux_amd64/peco /usr/local/bin/
rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz

cd $current_path
