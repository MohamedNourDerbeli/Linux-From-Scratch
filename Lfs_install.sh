#!/bin/bash
# This script automates the setup process for a Linux From Scratch (LFS) system.

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Directory where LFS will be mounted
LFS="/mnt/lfs"

# Function to execute scripts
run_script() {
    if! bash "$1"; then
        echo "Failed to execute $1"
        exit 1
    fi
}

# Run each script in PreBuildPreparations directory
for script in $(ls -v PreBuildPreparations/*.sh); do
    if [[ "$(basename "$script")" =~ ^[0-5]+- ]]; then
        run_script "$script"
    fi
done

# Execute the setup_lfs_profile.sh script
./PreBuildPreparations/6-setup_lfs_profile.sh

# Copy temporary tools to LFS
cp Cross_Toolchain_Temp_Tools/* "$LFS/usr" && chmod +x "$LFS/usr"/*.sh

# Switch to LFS user for further setup
su - lfs 
