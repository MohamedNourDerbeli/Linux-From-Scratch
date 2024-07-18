#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

# Setting the $LFS variable
echo "Setting the LFS variable..."
export LFS=/mnt/lfs
source ../info.txt

# source disk_setup.sh
# Extract the path after /mnt/
lfs_path="${LFS#/mnt/}"

if [ -d "/mnt/$lfs_path" ]; then
    echo "Removing existing /mnt/$lfs_path directory..."
    rm -rf "/mnt/$lfs_path"
fi
echo "Creating /mnt/$lfs_path directory..."
mkdir -pv "/mnt/$lfs_path"
# Mount partitions in the correct order
echo "Mounting partitions..."
mount -v ${DISK_NAME}4 $LFS || (echo "Error: Mounting root partition failed"; exit 1)
mkdir -p $LFS/boot
mount -v ${DISK_NAME}2 $LFS/boot || (echo "Error: Mounting /boot partition failed"; exit 1)

echo "Mounting complete."
