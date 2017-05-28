_branch() {
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
        git branch 2> /dev/null | awk '{ if($1=="*") print "(" $2 ")"}'
    elif hg root > /dev/null 2>&1; then
        bookmark=`hg bookmark 2> /dev/null | awk '{ if($1=="*") print "(" $2 ")"}'`
        if [ -n "$bookmark" ]; then
            echo $bookmark
        else
            hg branch 2> /dev/null | awk '{print "(" $1 ")"}'
        fi
    fi
}
