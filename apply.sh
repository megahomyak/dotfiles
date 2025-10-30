nosudo() { "$@"; }

link() {
    "$1" rm "$3"
    "$1" mkdir -p "$(dirname "$3")"
    "$1" ln -rs "$2" "$3"
}

link nosudo init.vim ~/.config/nvim/init.vim
link nosudo hotfuzz_control_panel/commands ~/.config/hotfuzz_control_panel/commands
link nosudo cargo/config.toml ~/.cargo/config.toml
link nosudo bash_utils.sh ~/bash_utils.sh
link nosudo termux.properties ~/.termux/termux.properties
link nosudo .inputrc ~/.inputrc
link nosudo .gitconfig ~/.gitconfig
link nosudo kitty.conf ~/.config/kitty/kitty.conf
link sudo journald.conf /etc/systemd/journald.conf
link nosudo .Xresources ~/.Xresources
link nosudo fonts/JetBrainsMono-Bold.ttf ~/.local/share/fonts/JetBrainsMono-Bold.ttf
link nosudo fonts/JetBrainsMono-SemiBold.ttf ~/.local/share/fonts/JetBrainsMono-SemiBold.ttf
link nosudo fonts/JetBrainsMono-Bold.ttf ~/.termux/font.ttf
link nosudo flameshot.ini ~/.config/flameshot/flameshot.ini
link nosudo copyq.conf ~/.config/copyq/copyq.conf
link sudo xinput/90-darn-tablet.conf /usr/share/X11/xorg.conf.d/90-darn-tablet.conf
link sudo hwdb.d/99-capslk-esc-swap.hwdb /etc/udev/hwdb.d/99-capslk-esc-swap.hwdb
link nosudo .vimrc ~/.vimrc
link sudo security/limits.conf /etc/security/limits.conf
