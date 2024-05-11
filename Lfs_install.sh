#!/bin/bash
# This script will run all the scripts in the order they are listed.

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install Host System Requirements
./PreBuildPreparations/2-check_and_install.sh


# Set the LFS variable
export LFS="/mnt/lfs"

# create partitions and mount the LFS file system
./PreBuildPreparations/0-create_partitions.sh

# Check if the LFS directory exists
if [ ! -d "$LFS" ]; then
    echo "The LFS directory does not exist."
    exit 1
fi

# downlod and verify the LFS sources code
./PreBuildPreparations/3-download_and_verify.sh

# Setup the LFS directories
./PreBuildPreparations/4-setup_lfs_directories.sh

# sets up the LFS user

./PreBuildPreparations/5-add_lfs_user.sh

# setup the LFS user's environment
./PreBuildPreparations/6-setup_lfs_profile.sh

#./Cross_Toolchain_Temp_Tools/1-binutils_setup.sh
cp Cross_Toolchain_Temp_Tools/* $LFS/usr
chmod +x  $LFS/usr/1-binutils_setup.sh
chmod +x  $LFS/usr/2-GCC_setup.sh

su - lfs
echo "All scripts have been executed successfully."
