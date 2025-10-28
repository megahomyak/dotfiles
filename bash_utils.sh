PROJECTS_PATH=~/i
export EDITOR="nvim"

alias superclippy="cargo clippy -- -W clippy::pedantic -W clippy::nursery -W clippy::all"
alias rand="ls | shuf -n 1"
detach() {
    "$@" &
    disown -h %%
}
shopt -s expand_aliases
until0() {
    while ! "$@"; do
        echo 'Retrying...' >&2
    done
}
alias gc="git add --all && git commit"
alias gl="git log"
alias gp="until0 git push --tags && until0 git push --all"
alias gcp="gc && gp"
alias gs="git status"
alias gcpd="gc && gp && m deploy"
alias gd="git diff --color-words"
alias gdh="gd HEAD"

alias nn="nvim -c 'set noeol'"
gen() {
    if [ "$1" == "" ]; then
        tail -n 20 general
    else
        printf "%s" "$1" >> general
        blabu general
    fi
}

HISTSIZE=300000
HISTFILESIZE=300000

push() (
    cd $PROJECTS_PATH/"$1" && ( gc ; gp )
)
complete -F _i push

pull() (
    cd $PROJECTS_PATH/"$1" && git pull
)
complete -F _i pull

reload() {
    source ~/.bashrc
}

c() {
    cd "$@" && ls
}
_cd() {
    COMPREPLY=( $(compgen -d -- "$2") )
}
complete -F _cd c
complete -F _cd cd
d() {
    c ..
}
i() {
    c ~/i/$1
}
_i() {
    COMPREPLY=( $( ls -pA ~/i | grep / | grep "^$2" ) )
}
complete -F _i i

export PS1="$(
    GRAY="\[\e[37m\]"
    RESET="\[\e[0m\]"
    GREEN="\[\e[1;32m\]"
    BLUE="\[\e[1;34m\]"
    #echo "\D{%d.%m.%Y} \t \u@\h:\w\$ "
    echo "$GRAY\D{%d.%m.%Y} \t$RESET $GREEN\u@\h$RESET:$BLUE\w$RESET\n\$ "
)"

alias orange="ssh orange"

recent() {
    ls -tlA | head
    ls -tlA | less
}

m() {
    SCRIPT_HOME=~/i/project_manager ~/i/project_manager/"$@"
}
_m() {
    COMPREPLY=( $( ls ~/i/project_manager | grep "^$2" ) )
}
complete -F _m m

alias nvim="nvim -n"

alias py="python"

what_hogs_port() {
    sudo netstat -tulpn | grep :$1
}

steal() {
    git clone git@github.com:megahomyak/$1.git
}

alias sudok="sudo docker"

alias n="nvim"
alias f="nvim"
_f() {
    # find -type f -regex "\\./$1[^/]" -printf "%d %p\n" | sort -n | sed -e 's/^[0-9]\+\s.\///;'
    if [ "$(basename "$2.")" = "." ]; then
        FILEPREFIX=""
    else
        FILEPREFIX="$(basename "$2")"
    fi
    readarray -d $'\n' -t COMPREPLY <<< "$(find -L "$(eval echo "$(dirname "$2.")")" -maxdepth 1 -type f -name "$FILEPREFIX*" | sed "s#^./##" | xargs -I '{}' printf '%q\n' '{}')"
}
complete -F _f f

docker_purge_containers() {
    sudok rm -vf $(sudok ps -aq)
}

docker_purge_images() {
    sudok rmi -f $(sudok images -aq)
}

docker_explode() {
    docker_purge_containers
    docker_purge_images
}

shit() {
    echo \> sudok images
    sudok images
    echo
    echo \> sudok ps -a
    sudok ps -a
}

alias pyi="python -i"

dockdebug() {
    sudok run -it --rm "$1" sh
}

export BUILDKIT_PROGRESS=plain

proxify() {
    export https_proxy=http://localhost:2334/
    export http_proxy=http://localhost:2334/
    export no_proxy=localhost
}

deproxify() {
    unset https_proxy
    unset http_proxy
    unset no_proxy
}

chat() {
    ~/i/simple_chat/venv/bin/python ~/i/simple_chat/chat.py "$1"
}

alias lsd='ls --group-directories-first'

alias pye="nvim ~/a.py"
alias pyr="python -i ~/a.py"
alias pos="poetry shell"
alias nah="nvim -u NONE"
alias por="poetry run python"

lighthouse() (
    cd ~/lighthouse
    CMDNAME=$1
    shift
    ~/i/lighthouse_minecraft_launcher/lighthouse-$CMDNAME $@
)

source ~/i/frozen_speech/utils/utils.bash 2&> /dev/null

sizeof() (
    set -e

    cd ~

    gcc -x c - << EOF
        #include <stdio.h>

        $2

        void main(void) {
            printf("%zu\n", sizeof($1));
        }
EOF

    ./a.out
)

unset DEBUGINFOD_URLS # For gdb not to FUCK MY BRAIN about some FUCKING UBUNTU DEBUG INFOS that i NEVER NEEDED

alias shite="~/i/shitcryption/shitcryption.sh"

export MICRONOTES_LOCAL_DIR=~/micronotes
export MICRONOTES_REMOTE_DIR=state/micronotes
export MICRONOTES_REMOTE_CREDENTIALS=main
alias mi=~/i/micronotes/micronotes.sh

export CONVENIENT_AGE_STORAGE_DIRECTORY=~/convenient-age
alias ca=~/i/convenient-age/convenience.sh

export secret_stash_remote_dir=state/ss
export secret_stash_local_dir=~/ss
export secret_stash_remote_host=main
export secret_stash_connect_timeout=5
alias ss=~/i/secret_stash/secret_stash.sh

export PAGER=less
