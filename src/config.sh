#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
CONFIG_EXPORTED="yes"
SRC="$MAIN/src"
BIN="$MAIN/bin"
OUTPUT="$MAIN/output"
LAST_EXPORT_CACHE="$MAIN/last_export"

MOUNT_NAME="carl"
MOUNT_SHARE="Dowodowki"
MOUNT_SHARE_GREP="[dD]owodowki"

EXPORT_PATH_PREFIX="DIGITAL"
MOUNT="$MOUNT_NAME/$MOUNT_SHARE"
MOUNT_GREP="@$MOUNT_NAME/$MOUNT_SHARE_GREP"
