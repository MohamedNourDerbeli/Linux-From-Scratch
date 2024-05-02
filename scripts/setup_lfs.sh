#!/bin/bash
# This script will run all the scripts in the order they are listed.

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install Host System Requirements
echo "Running 2-check_and_install.sh..."

export LFS="/mnt/lfs"


sleep 2

./2-check_and_install.sh

# create partitions and mount the LFS file system
echo "Running 2-check_and_install.sh..."

sleep 2

./0-create_partitions.sh

# Set the LFS variable
export LFS="/mnt/lfs"

# Check if the LFS directory exists
if [ ! -d "$LFS" ]; then
    echo "The LFS directory does not exist. Please create it before running this script."
    exit 1
fi

# downlod and verify the LFS sources code
echo "Running 3-download_and_verify.sh..."

sleep 2

./3-download_and_verify.sh

# Setup the LFS directories
echo "Running 4-setup_lfs_directories.sh..."

sleep 2

./4-setup_lfs_directories.sh

# sets up the LFS user
echo "sets up the LFS user"

sleep 2

./5-add_lfs_user.sh

# setup the LFS user's environment
echo "Setting up lfs user's environment..."

sleep 2

./6-setup_lfs_profile.sh


echo "All scripts have been executed successfully."
