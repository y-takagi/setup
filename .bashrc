if [ -z "$PS1" ]; then
    return;
fi

## alias
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -al'
alias df='df -h'
alias tm='tmux a'
alias diff='git diff'
alias pry='irb'
alias emacs='emacs -nw'
alias dm='docker-machine'
alias dc='docker-compose'
alias dps='docker ps -a'
# alias ekill='emacsclient -e "(kill-emacs)"'

## history
HISTSIZE=100000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%F %T '
HISTIGNORE='history:ls*:l*:ll*:cd*:fg*:bg*:pwd'
## share history
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'

# load shell scripts
if [ -d "${HOME}/.bash.d" ] ; then
    for f in "${HOME}"/.bash.d/source/*.sh ; do
        . "$f" && echo load "$f"
    done
    unset f
fi

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

if [ -z "$TMUX" -a -z "$STY" ]; then
    if tmux has-session && tmux list-sessions | egrep -q '.*]$'; then
        # デタッチ済みセッションが存在する
        tmux attach && echo "tmux attached session "
    else
        tmux new-session && echo "tmux created new session"
    fi
fi
