#!/bin/bash

# Predefined folder path
FOLDER="$HOME/wallpapers"

# Check if folder exists
if [[ ! -d "$FOLDER" ]]; then
    echo "Error: Folder '$FOLDER' does not exist." >&2
    exit 1
fi

# Find all image files recursively
images=($(find "$FOLDER" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.webp" \) 2>/dev/null))

# Check if any images were found
if [[ ${#images[@]} -eq 0 ]]; then
    echo "No image files found in '$FOLDER' or its subdirectories" >&2
    exit 1
fi

# Select and output random image path
random_index=$((RANDOM % ${#images[@]}))
echo "${images[$random_index]}"
