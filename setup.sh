#!/bin/bash

# ssh鍵の設定
mkdir ~/.ssh
cat id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# symbolic link
ln -s .bashrc ~/.bashrc
ln -s .tmux.conf ~/.tmux.conf

# cask & emacs

# peco
