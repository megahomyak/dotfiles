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
alias gp="git push --all"
alias gcp="gc && gp"
alias gs="git status"
alias gcpd="gc && gp && m deploy"

hint() {
    (
    source ~/proxies.sh
    chatgpt cmd
    )
}

p() (
    source ~/proxies.sh
    "$@"
)

HISTSIZE=300000
HISTFILESIZE=300000

cpf() { cp -r $PROJECTS_PATH/copypastefiles/$@ .; }

alias pybot="cpf python/pybot/."

export no_proxy=localhost,127.0.0.0,127.0.1.1,127.0.1.1

proxy() {
    if [[ "$1" == "on" ]]; then
        export http_proxy=http://127.0.0.1:2334
        export https_proxy=http://127.0.0.1:2334
    elif [[ "$1" == "off" ]]; then
        export http_proxy=
        export https_proxy=
    else
        echo Option not recognized
    fi
}

o() {
    if [[ -e "$1" ]]; then
        xdg-open "$1"
    else
        echo "This file does not exist"
    fi
}

push() {
    (
    cd $PROJECTS_PATH/"$1" &&
    gcp
    )
}

pull() {
    (
    cd $PROJECTS_PATH/"$1" &&
    git pull
    )
}

reload() {
    source ~/.bashrc
}

c() {
    if [[ -d "$1" || "$1" == "-" ]]; then
        cd "$1"
        ls
        return
    fi
    for extension in sh py c cpp cxx txt toml cson json yaml rs
    do
        if [[ "$1" == *."$extension" ]]; then
            $EDITOR "$1"
            return
        fi
    done
    for extension in png jpeg jpg bmp
    do
        if [[ "$1" == *."$extension" ]]; then
            xviewer "$1"
            return
        fi
    done
    for extension in svg
    do
        if [[ "$1" == *."$extension" ]]; then
            inkscape "$1"
            return
        fi
    done
    o "$1"
}

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

check() {
    (
    source /etc/.current_proxy
    echo $CONFIG_NAME
    )
}

alias orange="ssh-add; ssh orange"

vserv() {
    $EDITOR /etc/systemd/system/$1.service
}

pycompile() {
    scriptname="$1"
    osname="$2"
    if [[ "$osname" == "windows" ]]; then
        pyinstaller --onefile --name program.exe "$scriptname"
    fi
    if [[ "$osname" == "linux" ]]; then
        pyinstaller --onefile --name program "$scriptname"
    fi
}

recent() {
    ls -tl | head
    ls -tl | less
}

alias gd="git diff --color-words"
alias gdh="gd HEAD"

TELEGRAM_DIR="~/.local/share/TelegramDesktop/tdata"

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

alias nvim="nvim -n"
alias gdiff="git diff HEAD"

alias py="python"

find_ps() {
    echo "$(ps -ax | grep $1)"
}

alias fix_outline="sudo systemctl restart outline_proxy_controller.service"

what_hogs_port() {
    sudo netstat -tulpn | grep :$1
}

steal() {
    git clone git@github.com:megahomyak/$1.git
}

i() {
    c ~/i/$1
}

RCLONE_FLAGS="--links --progress --fast-list --transfers 20 --checkers 20 -vvv --metadata"

rpull() (
    rtransfer server_crypt: ~/i
)

rquickpush() (
    RCLONE_FLAGS+=" --max-age 24h"
    rpush
)

rtransfer() (
    rclone sync "$1" "$2" $RCLONE_FLAGS
)

rpush() (
    read -s -p 'rclone password: ' RCLONE_CONFIG_PASS
    export RCLONE_CONFIG_PASS
    rtransfer ~/i server_crypt:
    rtransfer ~/i yadisk_crypt:
)

alias fuck='sudo $(history -p "!!")'

fucking_work() (
    gsettings set org.gnome.mutter check-alive-timeout 0
)

fucking_stop() (
    gsettings set org.gnome.mutter check-alive-timeout 10000
)

alias pr="poetry run"
alias pn="poetry run nvim"

alias notes="nvim ~/notes.txt"

alias sudok="sudo docker"

alias gok="sudo docker compose -f docker-compose-development.yml up --build"

rlisten() {
    cd ~/i/rclone_listener
    read -s -p 'rclone password: ' RCLONE_CONFIG_PASS
    export RCLONE_CONFIG_PASS
    poetry run python listener.py
}

alias n="nvim"

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

deproxy() {
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
