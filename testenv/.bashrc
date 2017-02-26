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

IGNOREEOF=100

## alias
alias df='df -h'
alias diff='git diff'
alias ekill='emacsclient -e "(kill-emacs)"'
alias emacs='emacsclient -t'
alias l='ls --color=auto --group-directories-first'
alias ll='l -ahl --time-style long-iso'
alias ps='ps auxf'

## function
peco_history() {
    declare l=$(HISTTIMEFORMAT='' history | LC_ALL=C sort -r | awk '{for(i=2;i<NF;i++){printf("%s%s",$i,OFS=" ")}print $NF}' | awk '!a[$0]++' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}

## bind
bind -x '"\C-r": peco_history'

## prompt
PROMPT_DIRTRIM=2
