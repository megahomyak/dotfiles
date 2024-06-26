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
link sing-box/proxy.service /etc/systemd/system/proxy.service
link journald.conf /etc/systemd/journald.conf
link .Xresources ~/.Xresources
link fonts/JetBrainsMono-Bold.ttf ~/.local/share/fonts/JetBrainsMono-Bold.ttf
link fonts/JetBrainsMono-SemiBold.ttf ~/.local/share/fonts/JetBrainsMono-SemiBold.ttf

if FIREFOX_PATH="$(python get_firefox_default_profile_path.py)" ; then
    FIREFOX_CHROME_PROFILE_FILE_NAME='userChrome.css'
    FIREFOX_CHROME_PATH="$FIREFOX_PATH/chrome"
    rm "$FIREFOX_CHROME_PATH"/"$FIREFOX_CHROME_PROFILE_FILE_NAME"
    mkdir -p "$FIREFOX_CHROME_PATH"
    ln -rs "firefox/$FIREFOX_CHROME_PROFILE_FILE_NAME" "$FIREFOX_CHROME_PATH/$FIREFOX_CHROME_PROFILE_FILE_NAME"
else
    echo "Couldn't find firefox, skipping the installation of its profile"
fi
