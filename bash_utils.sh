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

alias vpn="sudo sing-box run -D ~/.config/sing-box/vpn"
alias proxy="sudo sing-box run -D ~/.config/sing-box/proxy"

export EDITOR="nvim"
export PS1="\e[37m\t\e[0m \e[1;32m\u\e[0m:\e[1;34m\w\e[0m\$ "
