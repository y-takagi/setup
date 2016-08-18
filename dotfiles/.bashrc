## If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return;
fi

## history
HISTSIZE=100000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%F %T '
## share history
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'

## C-d によるログアウト入力を防止（100回までは無視する）
IGNOREEOF=100

## Load shell scripts
if [ -d "${HOME}/.bash.d" ] ; then
    . $HOME/.bash.d/lib/z/z.sh

    for f in "${HOME}"/.bash.d/source/*.sh ; do
        . "$f"
    done
    unset f

    echo == Loaded scripts under .bash.d/ ==
fi

## Load temporary settings
load_or_create $HOME/.bash.d/local/bashrc.sh

## alias
alias dc='docker-compose'
alias df='df -h'
alias diff='git diff'
alias dm='docker-machine'
alias dps='docker ps -a'
alias drm='docker rm $(docker ps -f status=exited -q)'
alias dstat='dstat -Tclmdrn'
#alias ekill='emacsclient -e "(kill-emacs)"'
alias emacs='emacsclient -t'
alias l='ls'
alias ll='ls -al'
alias ps='ps aux'
alias repo='cd $(ghq list -p | peco)'
alias s='ssh $(grep "^Host" ~/.ssh/config|peco|awk "{print \$2}")'
alias tm='tmux a'

## bind
bind -x '"\C-r": peco_history'
bind -x '"\C-xj": pcd'

## prompt
PS1="[\h@\W\$(__git_ps1)]\$ "
