if [ "$(uname)" == 'Darwin' ]; then
    return
fi

if which tmux > /dev/null && [ -z "$TMUX" -a -z "$STY" ]; then
    if tmux has-session && tmux list-sessions | egrep -q '.*]$'; then
        # デタッチ済みセッションが存在する
        tmux attach && echo "tmux attached session "
    else
        tmux new-session && echo "tmux created new session"
    fi
fi
