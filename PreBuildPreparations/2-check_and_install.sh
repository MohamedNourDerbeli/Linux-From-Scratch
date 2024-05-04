#!/bin/bash
# This script checks for missing packages and attempts to install them if they are missing.

# Define a function to check for missing packages
check_and_install() {
    # Execute version-check.sh and capture its output
    output=$(bash PreBuildPreparations/1-version-check.sh)

    # Use grep to find lines starting with "ERROR:"
    errors=$(echo "$output" | grep -E '^ERROR:')

    # If there are errors, attempt to install the missing packages
    if [ -n "$errors" ]; then
        echo "The following packages are missing or outdated:"
        echo "$errors"
        sleep 3
        # Add loading animation here
        loading_icon 5 "Attempting to install missing packages..."

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
}

# Define the loading_icon function
function loading_icon() {
    local load_interval="${1}"
    local loading_message="${2}"
    local elapsed=0
    local loading_animation=( '—' "\\" '|' '/' )

    echo -n "${loading_message} "
    tput civis
    trap "tput cnorm" EXIT
    while [ "${load_interval}" -ne "${elapsed}" ]; do
        for frame in "${loading_animation[@]}" ; do
            printf "%s\b" "${frame}"
            sleep 0.25
        done
        elapsed=$(( elapsed + 1 ))
    done
    printf " \b\n"
}

# Execute the function
check_and_install
