cdwt() {
    local cdDir
    cdDir=`make git-wt-cd`

    if [ "$cdDir" = "" ]; then
        # ex) Ctrl-C.
        return 1
    fi

    cd ${cdDir}
}
