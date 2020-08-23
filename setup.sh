#!/usr/bin/env bash
set -e

current_path=`pwd`
repo_path=$(cd $(dirname $0);pwd)

setup_dotfiles() {
    for f in $repo_path/dotfiles/.[^.]* ; do
        ln -sf $f $HOME/
    done
}

setup_dotfiles
cd $current_path
