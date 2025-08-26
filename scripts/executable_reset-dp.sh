#!/bin/bash
# Wait for Hyprland to fully initialize
sleep 2

OUTPUT="DP-1"
MODE="3840x2160@239.914001" # exact mode from wlr-randr

# Turn off and back on
wlr-randr --output "$OUTPUT" --off
sleep 1
wlr-randr --output "$OUTPUT" --mode "$MODE"
