#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

# Function to pause execution
pause() {
    read -n 1 -s -r -p "Press any key to continue..."
    echo
    echo "Paused for user input" 
}

# Function for error handling
handle_error() {
    echo "Error: $1" 
    exit 1
}

# Define the list of scripts in the desired order
scripts=(
    "version-check.sh"
    "check_and_install.sh"
    #"GUI.sh"
    #"disk_setup.sh"
    #"auto_mount.sh"
    #"setup_sources.sh"
    #"lfs_user_environ.sh"
)

pushd "Part1:Preparing_for_the_Build" 2>&1
# Iterate over each script and execute it
for script in "${scripts[@]}"; do
    echo "Running $script..." 
    bash $script 
    exit_code=${PIPESTATUS[0]}
    
    # Check the exit code and handle errors
    if [ $exit_code -ne 0 ]; then
        handle_error "Failed to execute $script (Exit code: $exit_code)"
        exit 1
    fi
    
    # Pause between scripts
    # pause
done

popd 2>&1
echo "All scripts executed successfully."
