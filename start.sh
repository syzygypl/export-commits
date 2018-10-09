#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
MAIN="$DIR"
set +e

echo "----------------------------------------------------------";
echo "Starting script at: "$(date)

echo "Pulling last repository version"
git pull

cd $MAIN
source "$DIR/src/config.sh"
source "$SRC/user_config.sh"
source "$SRC/scheduling.sh"
source "$SRC/publish.sh"
source "$SRC/export.sh"

determine_scheduled

echo "Exporting commits for $scheduled_formatted"
export_projects "$scheduled_formatted" || exit;
echo "Publishing for $scheduled"
publish "$scheduled" "$scheduled_year" || exit;

remember_last_export
