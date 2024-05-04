#!/bin/bash

# This script is used to create a partition and mount it on the LFS directory

export LFS="/mnt/lfs"

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Function to create a partition
create_partition() {
    echo "Setup partition..."
    # Assuming the user has already created a partition and knows its name
    echo "Partition list:"
    lsblk
    echo "Please enter the name of the partition (e.g., /dev/sda1):"
    read partition_name

    # Check if the partition exists
    if [ ! -e "$partition_name" ]; then
        echo "The partition $partition_name does not exist. Please check the partition name."
        exit 1
    fi

    # Format the partition with ext4
    echo "Formatting $partition_name with ext4..."
    mkfs -v -t ext4 "$partition_name"
    # Mount the partition
    echo "Mounting $partition_name..."
    mkdir -pv $LFS
    mount -v -t ext4 $partition_name $LFS
}

# Function to initialize a swap partition
# initialize_swap() {
#     echo "Initializing swap partition..."
#     # Assuming the user has already created a swap partition and knows its name
#     echo "Please enter the name of the swap partition (e.g., /dev/sda2):"
#     read swap_partition_name

#     # Check if the swap partition exists
#     if [ ! -e "$swap_partition_name" ]; then
#         echo "The swap partition $swap_partition_name does not exist. Please check the partition name."
#         exit 1
#     fi

#     # Initialize the swap partition
#     echo "Initializing $swap_partition_name as swap..."
#     mkswap "$swap_partition_name"
#     /sbin/swapon -v /dev/$swap_partition_name
# }

# Create the root partition
create_partition

# Initialize the swap partition
# initialize_swap

echo "Partitions have been created and formatted successfully."
