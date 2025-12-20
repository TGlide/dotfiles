#!/bin/bash

XKB_FILE="/usr/share/X11/xkb/symbols/us"
BACKUP_FILE="${XKB_FILE}.backup.$(date +%s)"

echo "Creating backup at $BACKUP_FILE..."
sudo cp "$XKB_FILE" "$BACKUP_FILE"
if [ $? -ne 0 ]; then
    echo "Backup failed."
    exit 1
fi

echo "Modifying intl section to map acute+c to cedilla..."

# Create a temp file with the fix
TEMP_FILE=$(mktemp)

# Extract intl section, modify it, then rebuild the file
sudo bash << 'SCRIPT'
XKB_FILE="/usr/share/X11/xkb/symbols/us"
TEMP_FILE=$(mktemp)

# Replace acute+c mapping with cedilla in the intl section
sed '/xkb_symbols "intl"/,/^}/ {
    s/ccedil, Ccedil/ccedil, Ccedil/g
    s/\[ acute,/[ dead_acute,/g
}' "$XKB_FILE" > "$TEMP_FILE.new"

# If sed found the pattern, use it; otherwise, manually add cedilla to acute deadkey
if grep -q "dead_acute" "$TEMP_FILE.new"; then
    mv "$TEMP_FILE.new" "$XKB_FILE"
else
    # Fallback: inject cedilla mapping after the intl section starts
    sed '/xkb_symbols "intl"/a\    // Map apostrophe+c to cedilla\n    key <AC02> { [ c, C, ccedil, Ccedil ] };' "$BACKUP_FILE" > "$XKB_FILE"
fi

rm -f "$TEMP_FILE" "$TEMP_FILE.new"
SCRIPT

echo "Clearing XKB cache..."
rm -rf ~/.cache/xkb 2>/dev/null

echo "Reloading Niri..."
niri msg action quit

echo "Done. Log back in."
