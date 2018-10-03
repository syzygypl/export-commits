#!/usr/bin/env bash

REPO="git@github.com:syzygypl/export-commits.git"
LAUNCH_CONFIG_NAME="com.syzygy.export-commits"

MAIN_DIR="$HOME/.export-commits"
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"
LAUNCH_CONFIG="$LAUNCH_AGENTS/$LAUNCH_CONFIG_NAME.plist"
LAUNCH_CONFIG_SOURCE="$MAIN_DIR/src/launch_config.xml"
USER_CONFIG="$MAIN_DIR/src/user_config.sh"

install_repo() {
    yarn --cwd "$MAIN_DIR"
}

prepare_repo() {
    echo "Cloning export-commits repository into $MAIN_DIR"
    git clone "$REPO" "$MAIN_DIR" || exit 1;
    install_repo
}

clean() {
    if [[ -d "$MAIN_DIR" ]]; then
        read -p "Previous installation found, remove main directory: $MAIN_DIR ?[Y/n]" -n 1 answer
        echo
        if [[ $answer =~ ^[Yy]$ ]]; then
            rm -rf "$MAIN_DIR" || exit 1;
        fi
    fi
}

export_launch_config() {
    echo "Creating launchctl config at $LAUNCH_CONFIG"
    rm "$LAUNCH_CONFIG" 2> /dev/null
    cp "$LAUNCH_CONFIG_SOURCE" "$LAUNCH_CONFIG" || exit 1;
    launchctl unload "$LAUNCH_CONFIG" || exit 1;
    launchctl load "$LAUNCH_CONFIG" || exit 1;
}

user_config() {
    read -p "Please provide name to be used as catalog name:" name
    touch "$USER_CONFIG" || exit 1;
    echo "\$NAME=$name" > "$USER_CONFIG" || exit 1;
    echo "Config is exported, if you want to correct it - location is $USER_CONFIG"
}

main() {
    clean
    prepare_repo
    export_launch_config
    user_config
}

main "$@"