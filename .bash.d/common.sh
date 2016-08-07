load_or_create() {
    if [ -f "$1" ]; then
        . "$1" && echo load "$1"
    else
        touch "$1" && echo create "$1"
    fi
}
