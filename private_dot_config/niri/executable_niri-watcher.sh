#!/usr/bin/env bash

# Paths
TEMPLATE_FILE="$HOME/.config/niri/config.tmpl.kdl"
COLORS_FILE="$HOME/.config/niri/colors.conf"
OUTPUT_FILE="$HOME/.config/niri/config.kdl"

# Function to generate config
generate_config() {
    echo "Regenerating niri config..."
    
    # Check if colors file exists
    if [[ ! -f "$COLORS_FILE" ]]; then
        echo "Colors file not found: $COLORS_FILE"
        return 1
    fi
    
    # Check if template file exists
    if [[ ! -f "$TEMPLATE_FILE" ]]; then
        echo "Template file not found: $TEMPLATE_FILE"
        return 1
    fi
    
    # Read colors and create temporary variables
    declare -A colors
    while IFS='=' read -r key value; do
        if [[ $key =~ ^@([a-zA-Z_][a-zA-Z0-9_]*) ]]; then
            color_name="${BASH_REMATCH[1]}"
            color_value=$(echo "$value" | tr -d ' ')
            colors["$color_name"]="$color_value"
        fi
    done < "$COLORS_FILE"
    
    # Process template and substitute colors
    cp "$TEMPLATE_FILE" "$OUTPUT_FILE"
    
    # Replace @color_name with actual color values
    for color_name in "${!colors[@]}"; do
        sed -i "s/@${color_name}/${colors[$color_name]}/g" "$OUTPUT_FILE"
    done
    
    echo "Config regenerated successfully!"
}

# Generate config once on startup
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
