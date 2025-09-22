#!/bin/bash
set -e

echo "=== Snapper Cleanup Script ==="

# 1. Show existing configs
echo "[*] Listing Snapper configs..."
snapper list-configs || { echo "No snapper configs found."; exit 0; }

# 2. For each config, list snapshots and ask to delete
for config in $(snapper list-configs | awk 'NR>1 {print $1}'); do
    echo ""
    echo "[*] Config: $config"
    snapper -c "$config" list || true
    read -rp "Delete ALL snapshots for config '$config'? [y/N] " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        echo "  -> Deleting snapshots for $config"
        snapper -c "$config" delete 1-999999 || true
    fi
    read -rp "Remove config '$config'? [y/N] " ans2
    if [[ "$ans2" =~ ^[Yy]$ ]]; then
        echo "  -> Removing config $config"
        snapper delete-config "$config" || true
    fi
done

# 3. Optionally uninstall Snapper
read -rp "Do you also want to uninstall Snapper? [y/N] " ans3
if [[ "$ans3" =~ ^[Yy]$ ]]; then
    if command -v zypper >/dev/null 2>&1; then
        sudo zypper remove -y snapper
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf remove -y snapper
    elif command -v apt >/dev/null 2>&1; then
        sudo apt remove -y snapper
    else
        echo "Could not detect package manager. Please uninstall Snapper manually."
    fi
else
    echo "Snapper package left installed."
fi

echo "=== Snapper cleanup complete ==="
