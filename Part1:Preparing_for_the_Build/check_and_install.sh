#!/bin/bash
# This script checks for missing packages and attempts to install them if they are missing.

set -e  # Exit immediately if a command exits with a non-zero status
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

# Define a function to check for missing packages
check_and_install() {
    # Execute version-check.sh and capture its output
    output=$(bash version-check.sh)
    
    # Use grep to find lines starting with "ERROR:"
    errors=$(echo "$output" | grep -E '^ERROR:') ||  echo "All required packages are installed and up to date."
    
    
    # If there are errors, attempt to install the missing packages
    if [ -n "$errors" ]; then
        echo "The following packages are missing or outdated:"
        echo "$errors"
        sleep 3
        # Extract package names from the errors
        packages=$(echo "$errors" | grep -oP 'ERROR: Cannot find \K\w+')
        
        # Map package names to their correct names in Debian/Ubuntu repositories
        packages=$(echo "$packages" | sed 's/texi2any/texinfo/')
        
        # Install the packages
        sudo apt-get update
        sudo apt-get install -y $packages

        # Check if /bin/sh is symlinked to Bash, if not, fix it
        if [ "$(readlink -f /bin/sh)" != "/usr/bin/bash" ]; then
            echo "Fixing /bin/sh symlink..."
            sudo ln -sf /bin/bash /bin/sh
            echo "Symlink /bin/sh to Bash fixed."
        fi
        echo "All required packages are installed and up to date."
        
        
    fi
    
}
# Execute the function
check_and_install
