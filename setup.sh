#!/bin/sh
set -e
current_path=`pwd`
repo_path=$(cd $(dirname $0);pwd)

setup_dotfiles() {
    for f in $repo_path/dotfiles/.[^.]* ; do
        ln -sf $f $HOME/
    done
}

setup_ssh() {
    mkdir ~/.ssh
    cat $repo_path/id_rsa.pub >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
}

setup_emacs() {
    git clone https://github.com/y-takagi/emacs.d.git ~/.emacs.d
}

setup_peco() {
    mkdir ~/tmp && cd ~/tmp/
    wget "https://github.com/peco/peco/releases/download/v0.4.7/peco_linux_amd64.tar.gz" | tar zxvf
    sudo cp peco_linux_amd64/peco /usr/local/bin/
    rm -rf peco_linux_amd64 peco_linux_amd64.tar.gz
}

setup_all() {
    setup_dotfiles
    setup_ssh
    setup_emacs
    setup_peco
}

if [ -n "$1" ]; then
    setup_$1
else
    setup_all
fi

cd $current_path
