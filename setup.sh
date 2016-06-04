#!/bin/bash
set -e

# ssh鍵の設定
mkdir ~/.ssh
cat id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# cask & emacs
git clone https://github.com/cask/cask.git ~/.cask
git clone https://github.com/y-takagi/emacs.d.git ~/.emacs.d
cd ~/.emacs.d && cask install && cd -

# peco
wget "https://github.com/peco/peco/releases/download/v0.3.6/peco_linux_amd64.tar.gz" | tar zxvf
sudo cp peco_linux_amd64/peco /usr/local/bin/
rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz

# symbolic link
ln -s .bash_profile ~/.bash_profile
ln -s .bashrc ~/.bashrc
ln -s .bash.d ~/.bash.d
ln -s .gitconfig ~/.gitconfig
ln -s .tmux.conf ~/.tmux.conf
