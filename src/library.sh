#!/usr/bin/env bash

if [ "$CONFIG_EXPORTED" = "" ]; then
    exit;
fi

error() {
    echo "$1"; exit;
}