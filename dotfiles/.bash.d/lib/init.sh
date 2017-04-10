## z
if [ ! -d $HOME/.zdata ]; then
    mkdir $HOME/.zdata
fi

## Load scripts
. $HOME/.bash.d/lib/z/z.sh
. $HOME/.bash.d/lib/sh-pathctl/pathctl.shrc
