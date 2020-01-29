#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

calculate_period() {
    declare month=$1

    php -r "$(printf 'echo date("Y-m-d", strtotime("%s-01 +1 month -1 day"));' "$month")"
}

export_diff() {
    declare project="$1" hash="$2"

    local person="$(git -C "$project" show --format="%an" -s "$hash")"
    local target="output/$(basename "$project")/$hash.html"

    mkdir -p "$(dirname "$target")"

    git -C "$project" show "$hash" | head -n 2500 \
        | $DIR/../bin/node ./node_modules/.bin/diff2html --input stdin --file "$target"
}

export_project() {
    declare project="$1" since="$2" until="$3"

    local author="$(git -C "$project" config user.email)"

    git -C "$project" log --no-merges --format='%H' --branches \
        --since "$since" --until "$until" --author "$author" \
    | while read hash ; do
        export_diff "$project" "$hash"
    done

}

export_projects() {
    declare month="${1:-$(date -v '-25d' +"%Y-%m")}"

    if [[ ! "$month" =~ ^20[0-9]{2}-[0-9]{2}$ ]]; then
        echo 'You need to provide the month in YYYY-MM format' >&2
        return 2
    fi

    if [[ ! -d "projects/" ]]; then
        echo "Create a projects/ directory and create symlinks to your projects there" >&2
        return 1
    fi

    local since="${month}-01" until="$(calculate_period "$month")"

    echo "Exporting commits for ${since} -- ${until}"

    rm -fr ./output

    shopt -s nullglob

    for name in projects/*; do
        if [[ ! -d "$name/.git" ]]; then
            continue;
        fi

        if [[ -f excluded.txt ]] && grep -F "$(basename "$name")" excluded.txt >/dev/null; then
            echo " ✘ $(basename "$name")"
            continue;
        fi

        echo " ✔ ︎$(basename "$name")"
        export_project "$name" "$since" "$until"
    done
}
