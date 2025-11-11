#!/usr/bin/env bash

TYPE="$1"
FOLDER="$2"

mkdir -p "$HOME/Pictures/$FOLDER"
FILE="$HOME/Pictures/$FOLDER/screenshot_$(date +'%Y%m%d_%H%M%S').png"

grimblast --notify copysave "$TYPE" "$FILE"
