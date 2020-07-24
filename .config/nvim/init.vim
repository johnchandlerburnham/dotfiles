set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let $RUST_SRC_PATH=system("rustc --print sysroot")
source ~/.vimrc

