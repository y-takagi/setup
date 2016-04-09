# 逆順にして直近の履歴を上にもってくる
peco_history() {
    declare l=$(HISTTIMEFORMAT='' history | LC_ALL=C sort -r | awk '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}' | awk '!a[$0]++' |peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}

pcd() {
    declare dir=$(z -t | awk '{print $2}' | sort | uniq | peco)
    READLINE_LINE="cd $dir"
    READLINE_POINT=${#READLINE_LINE}
}

bind -x '"\C-r": peco_history'
bind -x '"\C-xj": pcd'

alias s='ssh $(grep "^Host" ~/.ssh/config|peco|awk "{print \$2}")'
alias repo='cd $(ghq list -p | peco)'

if [ -n "`which peco 2> /dev/null`" ]; then

    # unshift the 1st argument string into output
    function peco-unshift() {
        echo "$1"
        while read x; do
            echo $x
        done
    }

    # pd (peco-change-directory)
    # Usage:
    #     - Select ${CD_LINE} to change directory
    #     - Select ${CANCEL_LINE} to cancel
    function pd() {
        local DIR_TMP=""
        local DIR_PATH="$1"
        local CD_LINE="Change-Directory"
        local CANCEL_LINE="Cancel"
        while true
        do
            DIR_TMP=$(\ls -1aF ${DIR_PATH} | sed -e "s/@$/\//" | grep / | peco-unshift ${CANCEL_LINE} | peco-unshift ${CD_LINE} | peco)
            if [ "${DIR_TMP}" = "${CD_LINE}" ]; then
                cd $DIR_PATH
                return
            elif [ "${DIR_TMP}" = "${CANCEL_LINE}" ]; then
                return
            else
                DIR_PATH="${DIR_PATH}${DIR_TMP}"
            fi
        done
    }

    # process kill
    function peco-kill() {
        for pid in `ps aux | peco | awk '{print $2}'`
        do
            kill $pid
            echo "Killed ${pid}"
        done
    }

    # select command from history
    function peco-select-history() {
        local tac="tail -r"
        if [ -n "`which tac 2> /dev/null`" ]; then
            tac="tac"
        elif [ -n "`which gtac 2> /dev/null`" ]; then
            tac="gtac"
        fi
        $(history | ${tac} | peco | awk '{for(i=8;i<NF;i++)printf("%s ",$i);print $NF}')
    }
fi
