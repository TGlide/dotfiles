#!/bin/bash

# Get the list of sinks and format for Rofi (index and name)
sinks=$(pactl list sinks short | awk '{print $2}')

# Use Rofi to select a sink (case-insensitive search)
selected_sink_name=$(echo "$sinks" | rofi -i -dmenu -p "Select audio output:")

# If a sink was selected
if [ -n "$selected_sink_name" ]; then
    # Get the index of the selected sink
    selected_sink_index=$(pactl list sinks short | grep -F "$selected_sink_name" | awk '{print $1}' | head -n 1)

    # Set the default sink
    pactl set-default-sink "$selected_sink_index"
fi
