#!/usr/bin/env bash

# Set the path to the Pictures subdirectory
pictures_dir="$XDG_PICTURES_DIR/backgrounds/neofetch-backgrounds"

# Check if the directory exists
if [ ! -d "$pictures_dir" ]; then
    echo "Pictures directory not found."
    exit 1
fi

# Get a list of all image files in the Pictures directory
image_files=("$pictures_dir"/*.png)

# Check if there are no image files
if [ ${#image_files[@]} -eq 0 ]; then
    echo "No image files found in the Pictures directory."
    exit 1
fi

# Generate a random index to select a random image
random_index=$(( RANDOM % ${#image_files[@]} ))

# Get the random image file
random_image="${image_files[$random_index]}"

neofetch --source $random_image
