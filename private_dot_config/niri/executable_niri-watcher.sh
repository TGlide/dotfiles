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
    
    # Check if template file is not empty
    if [[ ! -s "$TEMPLATE_FILE" ]]; then
        echo "Template file is empty: $TEMPLATE_FILE"
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
    
    # Create temporary file for atomic write
    TEMP_FILE="${OUTPUT_FILE}.tmp"
    
    # Copy template to temporary file
    if ! cp "$TEMPLATE_FILE" "$TEMP_FILE"; then
        echo "Failed to copy template file"
        rm -f "$TEMP_FILE"
        return 1
    fi
    
    # Replace @color_name with actual color values
    for color_name in "${!colors[@]}"; do
        if ! sed -i "s/@${color_name}/${colors[$color_name]}/g" "$TEMP_FILE"; then
            echo "Failed to substitute colors"
            rm -f "$TEMP_FILE"
            return 1
        fi
    done
    
    # Verify the temporary file is not empty
    if [[ ! -s "$TEMP_FILE" ]]; then
        echo "Generated config is empty, not overwriting existing config"
        rm -f "$TEMP_FILE"
        return 1
    fi
    
    # Atomically move temp file to final location
    if mv "$TEMP_FILE" "$OUTPUT_FILE"; then
        echo "Config regenerated successfully!"
        return 0
    else
        echo "Failed to move config to final location"
        rm -f "$TEMP_FILE"
        return 1
    fi
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
