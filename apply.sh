link() {
    sudo rm "$2"
    sudo mkdir -p $(dirname "$2")
    sudo ln -rs "$1" "$2"
}

link init.vim ~/.config/nvim/init.vim
link hotfuzz_control_panel/commands ~/.config/hotfuzz_control_panel/commands
link cargo/config.toml ~/.cargo/config.toml
link bash_utils.sh ~/bash_utils.sh
link termux.properties ~/.termux/termux.properties
link .inputrc ~/.inputrc
link .gitconfig ~/.gitconfig
link kitty.conf ~/.config/kitty/kitty.conf
link journald.conf /etc/systemd/journald.conf
link .Xresources ~/.Xresources
link fonts/JetBrainsMono-Bold.ttf ~/.local/share/fonts/JetBrainsMono-Bold.ttf
link fonts/JetBrainsMono-SemiBold.ttf ~/.local/share/fonts/JetBrainsMono-SemiBold.ttf
link flameshot.ini ~/.config/flameshot/flameshot.ini
link copyq.conf ~/.config/copyq/copyq.conf
link xinput/90-darn-tablet.conf /usr/share/X11/xorg.conf.d/90-darn-tablet.conf
link hwdb.d/99-capslk-esc-swap.hwdb /etc/udev/hwdb.d/99-capslk-esc-swap.hwdb
link .vimrc ~/.vimrc
