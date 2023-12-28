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

cpf() { cp -r ~/i/copypastefiles/$@ .; }

alias pybot="cpf python/pybot/."

shell_proxy() {
    bash --rcfile <(echo 'source ~/.bashrc; source ~/proxies.sh; PS1="(proxied) $PS1"')
}

source ~/i/automation/shortcuts.sh

o() {
    if [[ -e "$1" ]]; then
        xdg-open "$1"
    else
        echo "This file does not exist"
    fi
}

push() {
    (
    cd ~/i/"$1" &&
    gcp
    )
}

pull() {
    (
    cd ~/i/"$1" &&
    git pull
    )
}

refresh() {
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
            nvim "$1"
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

export EDITOR="nvim"
export PS1="\e[37m\t\e[0m \e[1;32m\u\e[0m:\e[1;34m\w\e[0m\$ "

switch() {
    # globalvpnthing: sing-box config from the VPN provider with TUN
    # vpnthing: sing-box config from the VPN provider without TUN (I removed it manually)
    # proxything: sing-box HTTP in+out only (written manually)
    # passthroughthing: sing-box HTTP in+out only, passthrough, accepts from localhost and releases from localhost (written manually)

    #[Unit]
    #
    #[Service]
    #User=root
    #ExecStart=/usr/bin/sing-box run -D /home/megahomyak/.config/sing-box/[CONFIG NAME HERE]
    #
    #[Install]
    #WantedBy=multi-user.target
    sudo bash << EOF
for service_name in proxything globalvpnthing
do
    if (systemctl --quiet is-active "\$service_name"); then
        systemctl stop "\$service_name"
    fi
done
service_to_run="$1"
if [ "\$service_to_run" = "vpn" ]; then
    service_to_run="globalvpnthing"
fi
if [ "\$service_to_run" = "proxy" ]; then
    service_to_run="proxything"
fi
if [ "\$service_to_run" == "off" ]; then
    service_to_run="passthroughthing"
fi
systemctl start "\$service_to_run"
EOF
}
