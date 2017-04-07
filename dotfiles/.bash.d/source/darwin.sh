if [ ! "$(uname)" == 'Darwin' ]; then
    return
fi

## Add ssh keys to ssh-agent from keychain
if [ "$(ssh-add -l)" == "The agent has no identities." ]; then
    ssh-add -A > /dev/null 2>&1
fi

if which brew > /dev/null; then
    ## bash completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    ## git completion
    git_completions=("git-completion.bash" "git-promt.sh")
    for completion in ${git_completions[@]}
    do
        if [ -f $(brew --prefix)/etc/bash_completion.d/${completion} ]; then
            . $(brew --prefix)/etc/bash_completion.d/${completion}
        fi
    done
fi
