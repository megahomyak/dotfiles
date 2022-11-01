link() {
    rm ~/$1/$2 2> /dev/null
    mkdir -p ~/$1
    ln -rs $1/$2 ~/$1/$2
}

link .config/nvim init.vim
link .cargo config.toml
link . .bash_utils
link .termux termux.properties
link . .inputrc
