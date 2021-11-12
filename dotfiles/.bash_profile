#
# 環境変数を設定
#
. ~/.bash.d/util.sh

## Environment Variable
export ANDROID_HOME=$HOME/Library/Android/sdk
export EDITOR='mg'
export GOPATH=$HOME/.go
export LANG=ja_JP.UTF-8
export LESS='-g -i -M -R'
export PAGER=less
export PIPENV_VENV_IN_PROJECT=1
export _Z_DATA=$HOME/.zdata/.z
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export DBC_USER=yukiya.takagi@every.tv

if [ -d "/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/" ]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/"
fi

## Load temporary settings
load_or_create $HOME/.bash.d/local/profile.sh

## PATH
export PATH=$HOME/.bash.d/cmd:$PATH
export PATH=$HOME/.bash.d/gen_cmd:$PATH
export PATH=$HOME/.anyenv/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$PYENV_ROOT/bin:$PATH

## Init
if [ "$(uname)" == 'Darwin' ] || [ "$(uname)" == 'FreeBSD' ]; then
    eval $(gdircolors $HOME/.bash.d/lib/dircolors-solarized/dircolors.ansi-universal)
elif [ "$(uname)" == 'Linux' ]; then
    eval $(dircolors $HOME/.bash.d/lib/dircolors-solarized/dircolors.ansi-universal --sh)
fi

if which anyenv > /dev/null; then
    if which pyenv > /dev/null; then
        eval "$(pyenv init --path)"
    fi
    eval "$(anyenv init -)"
fi

## rustup
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

## ghcup-env
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

## Keep SSH_AUTH_SOCK to see same path
# agent="$HOME/.ssh/agent"
# if [ -S "$SSH_AUTH_SOCK" ]; then
#     case $SSH_AUTH_SOCK in
#         /tmp/*/agent.[0-9]*)
#             ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
#     esac
# elif [ -S $agent ]; then
#     export SSH_AUTH_SOCK=$agent
# else
#     echo "no ssh-agent"
# fi

## Setup keychain
if which keychain > /dev/null; then
    keychain --nogui -q $HOME/.ssh/id_rsa $HOME/.ssh/github_id_rsa $HOME/.ssh/bitbucket_id_rsa
    source $HOME/.keychain/$HOSTNAME-sh
fi

## Load .bashrc
test -r ~/.bashrc && . ~/.bashrc
