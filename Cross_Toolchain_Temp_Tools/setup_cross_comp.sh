#!/bin/bash

# Function to execute scripts
run_script() {
    if ! bash "$1"; then
        echo "Failed to execute $1"
        exit 1
    fi
}

# Loop through scripts in numerical order
for script in $(ls -v $LFS/usr/*.sh); do
    if [[ "$(basename "$script")" =~ ^[0-22]+- ]]; then
        echo "Start: $script"
        sleep 5
        run_script "$script"
    fi
done
