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
HISTSIZE=9999
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%F %T '
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
