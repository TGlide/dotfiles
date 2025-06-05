

#!/bin/bash

# Directory to process
TARGET_DIR="/home/thomasgl/.config/fish-backup" # Make sure this is the correct, full path

# Check if the directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' not found."
  exit 1
fi

# Find symlinks and process them
find "$TARGET_DIR" -type l -print0 | while IFS= read -r -d $'\0' SYMLINK; do
  echo "Processing symlink: $SYMLINK"

  # Get the target of the symlink
  TARGET=$(readlink "$SYMLINK")

  # Check if readlink was successful and the target exists
  if [ $? -eq 0 ] && [ -e "$TARGET" ]; then
    echo "  Target: $TARGET"

    # *** Explicitly remove the symlink BEFORE copying ***
    echo "  Removing symlink: $SYMLINK"
    rm "$SYMLINK"

    # Check if removal was successful
    if [ $? -eq 0 ]; then
      # Copy the target file to the location where the symlink was
      echo "  Copying target to $SYMLINK"
      cp "$TARGET" "$SYMLINK"

      if [ $? -eq 0 ]; then
        echo "  Replaced symlink with a copy of the target."
      else
        echo "  Error: Failed to copy target to $SYMLINK."
      fi
    else
      echo "  Error: Failed to remove symlink: $SYMLINK. Cannot proceed with copy."
    fi

  else
    echo "  Warning: Could not resolve target for '$SYMLINK' or target does not exist."
  fi
done

echo "Processing complete."
