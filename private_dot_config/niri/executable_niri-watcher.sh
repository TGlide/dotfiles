#!/usr/bin/env bash

# Paths
TEMPLATE_FILE="$HOME/.config/niri/config.tmpl.kdl"
COLORS_FILE="$HOME/.config/niri/colors.conf"
OUTPUT_FILE="$HOME/.config/niri/config.kdl"


# Call ./generate-config.sh
generate_config() {
    "$HOME/.config/niri/generate-config.sh"
}

generate_config

# Watch for changes
echo "Watching for changes in $TEMPLATE_FILE and $COLORS_FILE..."
inotifywait -m -e modify,create,delete,move,close_write \
    "$(dirname "$TEMPLATE_FILE")" \
    "$(dirname "$COLORS_FILE")" |
while read -r path events filename; do
    if [[ "$path$filename" == "$TEMPLATE_FILE" || "$path$filename" == "$COLORS_FILE" ]]; then
        echo "Detected change: $events in $path$filename"
        sleep 0.2
        generate_config
    fi
done
