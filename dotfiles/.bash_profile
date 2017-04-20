#
# 環境変数を設定
#
. ~/.bash.d/util.sh

export LANG=ja_JP.UTF-8
export LESS='-g -i -M -R'
export ALTERNATE_EDITOR=""
export EDITOR='emacsclient -t'
export _Z_DATA=$HOME/.zdata/.z
export GOPATH=$HOME/.go

if [ "$(uname)" == 'Darwin' ] || [ "$(uname)" == 'FreeBSD' ]; then
    eval $(gdircolors $HOME/.bash.d/lib/dircolors-solarized/dircolors.ansi-universal)
elif [ "$(uname)" == 'Linux' ]; then
    eval $(dircolors $HOME/.bash.d/lib/dircolors-solarized/dircolors.ansi-universal --sh)
fi

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
fi

## PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.bash.d/cmd:$PATH
export PATH=$HOME/.bash.d/gen_cmd:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

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
