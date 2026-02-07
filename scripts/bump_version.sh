#!/bin/bash
set -e
FILE=$1
PART=$2
if [ -z "$FILE" ] || [ -z "$PART" ]; then
    echo "Usage: $0 <file> <major|minor|patch>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "File $FILE not found!"
    exit 1
fi

curr=$(cat "$FILE" | tr -d '[:space:]')
IFS='.' read -r major minor patch <<< "$curr"

if [ "$PART" == "major" ]; then
    major=$((major + 1))
    minor=0
    patch=0
elif [ "$PART" == "minor" ]; then
    minor=$((minor + 1))
    patch=0
elif [ "$PART" == "patch" ]; then
    patch=$((patch + 1))
else
    echo "Unknown increment: $PART"
    exit 1
fi

new_ver="$major.$minor.$patch"
echo "$new_ver" > "$FILE"
echo "Bumped $FILE to $new_ver"
