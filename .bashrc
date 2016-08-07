## If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return;
fi

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
alias ps='ps auxf'
alias tm='tmux a'

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
    for f in "${HOME}"/.bash.d/source/*.sh ; do
        . "$f" && echo load "$f"
    done
    unset f
fi

## Load temporary settings
load_or_create $HOME/.bash.d/local/bashrc.sh

## prompt
PS1="[\h@\W\$(__git_ps1)]\$ "

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

# if [ -z "$TMUX" -a -z "$STY" ]; then
#     if tmux has-session && tmux list-sessions | egrep -q '.*]$'; then
#         # デタッチ済みセッションが存在する
#         tmux attach && echo "tmux attached session "
#     else
#         tmux new-session && echo "tmux created new session"
#     fi
# fi
