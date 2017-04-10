load_or_create() {
    if [ -f "$1" ]; then
        . "$1" && echo == Loaded "$1" ==
    else
        touch "$1" && echo == Created "$1" ==
    fi
}
