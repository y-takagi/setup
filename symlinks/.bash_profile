#
# 環境変数を設定
#
. ~/.bash.d/common.sh

## color of ls
# export CLICOLOR=1
# export LSCOLORS=DxGxcxdxCxegedabagacad

export LANG=ja_JP.UTF-8
export ALTERNATE_EDITOR=""
export EDITOR='emacsclient -t'

## PATH
export PATH=$HOME/.cask/bin:$PATH
export PATH=$HOME/.bash.d/cmd:$PATH

## Load temporary settings
load_or_create $HOME/.bash.d/local/profile.sh

## Keep SSH_AUTH_SOCK to see same path
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi

## Load .bashrc
test -r ~/.bashrc && . ~/.bashrc
