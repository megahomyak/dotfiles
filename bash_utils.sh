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

hint() {
    (
    source ~/proxies.sh
    chatgpt cmd
    )
}

chat() {
    (
    source ~/proxies.sh
    chatgpt
    )
}

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

source $PROJECTS_PATH/automation/shortcuts.sh

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

export PS1="\e[37m\t\e[0m \e[1;32m\u@\h\e[0m:\e[1;34m\w\e[0m\$ "

switch() {
    # vpn: sing-box config from the VPN provider with TUN
    # nonglobal_vpn: sing-box config from the VPN provider without TUN (I removed TUN manually)
    # proxy: sing-box HTTP in+out only (written manually)
    # off: sing-box HTTP in+out only, passthrough, accepts from localhost and releases from localhost (written manually)

    #[Unit]
    #
    #[Service]
    #User=root
    #EnvironmentFile=/etc/.current_proxy
    #ExecStart=/usr/bin/sing-box run -D /home/megahomyak/.config/sing-box/${CONFIG_NAME}
    #
    #[Install]
    #WantedBy=multi-user.target
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
