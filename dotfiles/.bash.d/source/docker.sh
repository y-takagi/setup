if ! which docker > /dev/null; then
    return;
fi

ruby_cmds=("ruby" "irb" "bundle")
node_cmds=("node" "npm")

declare -A imageCmdsMap
imageCmdsMap=( \
    ["ytakagi/ruby:2.3-slim"]=${ruby_cmds[@]} \
    ["node:6.4.0-slim"]=${node_cmds[@]} \
)

local_images=(`docker images | awk 'NR > 1 {print $1 ":" $2}'`)

for image in ${!imageCmdsMap[@]}; do
    if [[ " ${local_images[*]} " == *" $image "* ]]; then
        cmds=${imageCmdsMap[$image][@]}
        for cmd in ${cmds[@]}; do
            alias $cmd="docker run -it --rm -w /app -v \$(pwd):/app -v \$HOME:/root/ $image $cmd"
        done
        unset cmd
    fi
    unset cmds
done
unset image
