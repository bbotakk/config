use std 

export def-env main [] {
    let exit_path = "/tmp/lfcd.tmp"
    touch $exit_path
    lf -last-dir-path $exit_path
    std assert ( $exit_path | path exists )
    cd ( cat $exit_path )
    rm $exit_path
}
