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
