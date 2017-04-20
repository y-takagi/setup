git_branch() {
    git branch 2> /dev/null | awk '{print "(" $2 ")"}'
}

hg_branch() {
    hg branch 2> /dev/null | awk '{print "(" $1 ")"}'
}
