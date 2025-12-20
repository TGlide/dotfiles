#!/bin/bash
set -e

ENTRY_DIR="/efi/loader/entries"
BACKUP_DIR="${ENTRY_DIR}/backup-$(date +%F-%H%M%S)"
EDID_PARAM="drm.edid_firmware=DP-1:edid/g80.bin"

echo "Backing up boot entries..."
sudo mkdir -p "$BACKUP_DIR"
sudo cp -v "${ENTRY_DIR}"/*.conf "$BACKUP_DIR"

echo "Adding EDID parameter to boot entry files..."
for file in "${ENTRY_DIR}"/*.conf; do
    if grep -q "$EDID_PARAM" "$file"; then
        echo "Already present in $(basename "$file"), skipping."
        continue
    fi

    # Use | as delimiter to avoid issues with '/'
    sudo sed -i "s|^options|& ${EDID_PARAM}|" "$file"
    echo "Updated $(basename "$file")"
done

echo
echo "All done!"
echo "Backup saved to: $BACKUP_DIR"
echo "Reboot to apply changes."
