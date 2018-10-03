#!/usr/bin/env bash

REPO="git@github.com:syzygypl/export-commits.git"
LAUNCH_CONFIG_NAME="com.syzygy.export-commits"

MAIN_DIR="$HOME/.export-commits"
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"
LAUNCH_CONFIG="$LAUNCH_AGENTS/$LAUNCH_CONFIG_NAME.plist"
LAUNCH_CONFIG_SOURCE="$MAIN_DIR/src/launch_config"

install_repo() {
    cd "$MAIN_DIR"
    yarn
}

prepare_repo() {
    echo "Cloning export-commits repository into $MAIN_DIR"
    rm -rf "$MAIN_DIR"
    git clone "$REPO" "$MAIN_DIR"
    install_repo
}

export_launch_config() {
    echo "Creating launchctl config at $LAUNCH_CONFIG"
    rm "$LAUNCH_CONFIG"
    cp "$LAUNCH_CONFIG_SOURCE" "$LAUNCH_CONFIG"
    launchctl unload "$LAUNCH_CONFIG"
    launchctl load "$LAUNCH_CONFIG"
}

main() {
    prepare_repo
    export_launch_config
}

main "$@"