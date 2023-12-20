link() {
    rm ~/"$1/$2"
    mkdir -p ~/"$1"
    ln -rs "$1/$2" ~/"$1/$2"
}

link .config/nvim init.vim
link .config/hotfuzz_control_panel commands
link .cargo config.toml
link . bash_utils.sh
link .termux termux.properties
link . .inputrc
link . .gitconfig

if FIREFOX_PATH="$(python get_firefox_default_profile_path.py)" ; then
    FIREFOX_CHROME_PROFILE_FILE_NAME='userChrome.css'
    FIREFOX_CHROME_PATH="$FIREFOX_PATH/chrome"
    rm "$FIREFOX_CHROME_PATH"/"$FIREFOX_CHROME_PROFILE_FILE_NAME"
    mkdir -p "$FIREFOX_CHROME_PATH"
    ln -rs "firefox/$FIREFOX_CHROME_PROFILE_FILE_NAME" "$FIREFOX_CHROME_PATH/$FIREFOX_CHROME_PROFILE_FILE_NAME"
else
    echo "Couldn't find firefox, skipping the installation of its profile"
fi
