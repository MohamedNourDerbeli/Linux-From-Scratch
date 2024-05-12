#!/bin/bash

# Loop through scripts in numerical order
for script in $(ls -v $LFS/usr/*.sh); do
    bash $script
done

# Remove the setup scripts
rm -f $LFS/usr/*.sh
