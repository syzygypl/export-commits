#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
CONFIG_EXPORTED="yes"
SRC="$MAIN/src"
BIN="$MAIN/bin"
OUTPUT="$MAIN/output"
LAST_EXPORT_CACHE="$MAIN/last_export"

MOUNT_NAME="nelson"
MOUNT_SHARE="Dowodowki"
EXPORT_PATH_PREFIX="DIGITAL"
MOUNT="$MOUNT_NAME/$MOUNT_SHARE"
