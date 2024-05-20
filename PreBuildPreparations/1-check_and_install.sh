#!/bin/bash
# This script checks for missing packages and attempts to install them if they are missing.

# Define a function to check for missing packages
check_and_install() {
    # Execute version-check.sh and capture its output
    output=$(bash PreBuildPreparations/0-version-check.sh)

    # Use grep to find lines starting with "ERROR:"
    errors=$(echo "$output" | grep -E '^ERROR:')

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
    else
        echo "All required packages are installed and up to date."
    fi

    # Check if /bin/sh is symlinked to Bash, if not, fix it
    if [ "$(readlink -f /bin/sh)" != "/bin/bash" ]; then
        echo "Fixing /bin/sh symlink..."
        sudo ln -sf /bin/bash /bin/sh
        echo "Symlink /bin/sh to Bash fixed."
    fi
}

# Define the packages to check and install
packages=("build-essential" "pv")

# Loop through each package
for pkg in "${packages[@]}"; do
    # Check if the package is already installed
    if dpkg -s "$pkg" > /dev/null 2>&1; then
        echo "$pkg is already installed."
    else
        echo "Installing $pkg..."
        sudo apt-get update
        sudo apt-get install -y "$pkg"
    fi
done

# Execute the function
check_and_install
