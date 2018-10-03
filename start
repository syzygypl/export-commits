#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
MAIN="$DIR"
set +e

source "$DIR/src/config.sh"
source "$SRC/scheduling.sh"
source "$SRC/publish.sh"
source "$SRC/export.sh"

echo "Pulling last repository version"
git pull

determine_scheduled

echo "Exporting commits for $scheduled_formatted"
export_projects "$scheduled_formatted" || exit;
echo "Publishing for $scheduled"
publish "$scheduled" "$scheduled_year" || exit;

remember_last_export
