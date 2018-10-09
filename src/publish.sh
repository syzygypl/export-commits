#!/usr/bin/env bash

if [ "$CONFIG_EXPORTED" = "" ]; then
    exit;
fi
source "$SRC/library.sh";

determine_mount_point() {
    echo "$MOUNT_GREP";
    escaped_mount_names=$(echo "${MOUNT_GREP}" | sed 's/\//\\\//g')
    echo "$escaped_mount_names";
    sed_math="'s/^.*$escaped_mount_names on \(.*\) (.*$/\1/p'"
    MOUNT_POINT=$(eval "mount | sed -n $sed_math")
    if [ "$MOUNT_POINT" = "" ]; then
        error "mount point was not found"
    fi
}

mount_smb() {
    osascript -e "mount volume \"smb://$MOUNT\"" || error "Cannot mount volume"
    determine_mount_point
    echo "Found mount point: $MOUNT_POINT"
    exit;
}

publish_output() {
    schedule=$1
    scheduled_year=$2
    destination="$MOUNT_POINT/$EXPORT_PATH_PREFIX/$scheduled_year/$schedule/$NAME"
    echo "Publishing to $destination"
    mkdir -p "$destination" || error "Cannot create $destination"
    cp -a "$OUTPUT/." "$destination" || error "Cannot copy output to $destination"
}

publish() {
    schedule=$1
    scheduled_year=$2
    mount_smb
    publish_output ${schedule} ${scheduled_year};
}

main() {
    publish "$@"
}