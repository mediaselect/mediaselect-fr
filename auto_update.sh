#!/bin/bash

REPO_API="https://api.github.com/repos/mediaselect/mediaselect-fr/commits/master"
LOCAL_COMMIT_FILE="$HOME/.config/mediaselect-fr/.last_commit"

latest_commit=$(curl -s $REPO_API | jq -r '.sha')

if [ -z "$latest_commit" ]; then
    echo "Failed to fetch the latest commit hash from GitHub." >&2
    exit 1
fi
# Compare with the last commit
if [ -f "$LOCAL_COMMIT_FILE" ]; then
    last_commit=$(cat "$LOCAL_COMMIT_FILE")
    if [ "$last_commit" == "$latest_commit" ]; then
        echo "No updates available."
        exit 0
    fi
fi

wget https://github.com/mediaselect/mediaselect-fr/archive/refs/heads/master.zip -O /tmp/master_mediaselect_fr.zip
if [ $? -ne 0 ]; then
    echo "Download failed."
    exit 1
fi

[ -d "$HOME/mediaselect-fr" ] && rm -rf "$HOME/mediaselect-fr"

unzip -o /tmp/master_mediaselect_fr.zip -d "$HOME"
if [ $? -ne 0 ]; then
    echo "Unzip failed."
    exit 1
fi
rm /tmp/master_mediaselect_fr.zip
mv "$HOME/mediaselect-fr-master" "$HOME/mediaselect-fr"

echo "$latest_commit" > "$LOCAL_COMMIT_FILE"

echo "Program updated successfully."
