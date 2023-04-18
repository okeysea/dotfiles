fcd() {
    local cdDir
    cdDir=`ls -d */ | fzf`

    if [ "$cdDir" = "" ]; then
        # ex) Ctrl-C.
        return 1
    fi

    cd ${cdDir}
}
