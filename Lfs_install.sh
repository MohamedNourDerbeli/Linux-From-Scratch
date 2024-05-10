#!/bin/bash
# This script will run all the scripts in the order they are listed.

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
echo "All scripts have been executed successfully."
cp Cross_Toolchain_Temp_Tools/1-binutils_setup.sh /home/lfs/
chown -R lfs:lfs /home/lfs/*
chmod +x /home/lfs/1-binutils_setup.sh
sudo -E -u lfs /home/lfs/1-binutils_setup.sh
