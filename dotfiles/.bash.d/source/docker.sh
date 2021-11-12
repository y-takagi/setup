if ! which docker > /dev/null; then
    return;
fi

if ! docker stats --no-stream &> /dev/null; then
    return;
fi

gen_cmd() {
cat <<- EOF > $HOME/.bash.d/gen_cmd/$cmd
#!/bin/bash
git_root_dir=\$(git rev-parse --show-toplevel 2>/dev/null)
if [ -n "\$git_root_dir" ]; then
    mount_dir=\$git_root_dir
else
    mount_dir=\$(pwd)
fi
unset git_root_dir
if [ -p /dev/stdin ]; then
    exec cat - | docker run -i --rm -v \$HOME:/root/ -v \$mount_dir:\$mount_dir -w \$(pwd) $image $cmd "\$@"
else
    exec docker run -it --rm -v \$HOME:/root/ -v \$mount_dir:\$mount_dir -w \$(pwd) $image $cmd "\$@"
fi
unset mount_dir
EOF
chmod +x $HOME/.bash.d/gen_cmd/$cmd
}

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
            gen_cmd
        done
        unset cmd
        unset cmds
    fi
done
unset image
