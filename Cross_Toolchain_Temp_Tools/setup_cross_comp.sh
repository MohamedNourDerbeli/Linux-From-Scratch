#!/bin/bash

# Loop through scripts in numerical order
for script in $(ls -v $LFS/usr/*.sh | grep -E '/[0-9]+-'); do
    echo "Start: $script"
    sleep 5
    bash $script
done
