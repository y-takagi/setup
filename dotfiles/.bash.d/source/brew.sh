if ! which brew > /dev/null; then
    return;
fi

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
