PROJECTS_PATH="$(cat ~/.projects_path)"
export EDITOR="nvim"

alias superclippy="cargo clippy -- -W clippy::pedantic -W clippy::nursery -W clippy::all"
alias rand="ls | shuf -n 1"
detach() {
    "$@" &
    disown -h %%
}
shopt -s expand_aliases
alias gc="git add --all && git commit"
alias gl="git log"
alias gp="git push --tags && git push --all"
alias gcp="gc && gp"
alias gs="git status"
alias gcpd="gc && gp && mi deploy"
alias gd="git diff --color-words"
alias gdh="gd HEAD"

HISTSIZE=300000
HISTFILESIZE=300000

push() (
    cd $PROJECTS_PATH/"$1" && ( gc ; gp )
)

pull() (
    cd $PROJECTS_PATH/"$1" && git pull
)

reload() {
    source ~/.bashrc
}

c() {
    cd "$1" && ls
}
complete -F _cd c
d() {
    c ..
}
i() {
    c ~/i/$1
}
_i() {
    COMPREPLY=( $( ls -pA ~/i | grep / | grep "^$2" ) );
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

switch() {
    sudo bash << EOF
echo "CONFIG_NAME=$1" > /etc/.current_proxy
systemctl restart proxy
EOF
}

check() (
    source /etc/.current_proxy
    echo $CONFIG_NAME
)

alias orange="ssh-add; ssh orange"

recent() {
    ls -tlA | head
    ls -tlA | less
}

far() {
python - "$1" "$2" << EOF
import os
import sys

_progname, pattern, replacement, *paths = sys.argv

for root, dirs, files in os.walk("."):
    for file in files:
        file = os.path.join(root, file)
        try:
            with open(file, encoding="utf-8") as f:
                contents = f.read()
        except:
            pass
        else:
            replaced = contents.replace(pattern, replacement)
            if replaced != contents:
                with open(file, "w", encoding="utf-8") as f:
                    f.write(replaced)
EOF
}

alias m="manager"
mi() {
    SCRIPT_NAME=$1
    shift
    SCRIPT_HOME=~/i/project_manager ~/i/project_manager/$SCRIPT_NAME "$@"
}
_mi() {
    COMPREPLY=( $( ls ~/i/project_manager | grep "^$2" ) );
}
complete -F _mi mi

alias nvim="nvim -n"

alias py="python"

what_hogs_port() {
    sudo netstat -tulpn | grep :$1
}

steal() {
    git clone git@github.com:megahomyak/$1.git
}

RCLONE_FLAGS="--links --progress --fast-list --transfers 20 --checkers 20 -vvv --metadata"

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
    python ~/i/simple_chat/chat.py "$1"
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

source ~/i/frozen_speech/contents/bash_helpers.sh

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

unset DEBUGINFOD_URLS
