#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

# Function to check if a command succeeded
check_command() {
  if [ $? -ne 0 ]; then
    echo "Error: $1 failed."
    exit 1
  fi
}

source $Info

# Unmount any mounted partitions on the disk
echo "Unmounting any mounted partitions on $DISK_NAME..."
for PART in $(lsblk -ln -o NAME "$DISK_NAME" | grep -v NAME); do
  umount "/dev/$PART" &> /dev/null || true  # Ignore errors if no partitions are mounted
  swapoff "/dev/$PART" &> /dev/null || true # Disable swap if it's a swap partition
done

# Create the partitions
echo "Creating partitions on $DISK_NAME..."
(
echo g     # Create a new GPT partition table
echo n     # Add a new partition (1)
echo       # Default partition number (1)
echo       # Default first sector
echo +$PART1_SIZE # Last sector (+500M size)
echo t     # Change partition type
echo 1     # EFI System partition

echo n     # Add a new partition (2)
echo       # Default partition number (2)
echo       # Default first sector
echo +$PART2_SIZE   # Last sector (+1G size)
echo t     # Change partition type
echo 2     # Select partition 2
echo 20    # Linux filesystem

echo n     # Add a new partition (3)
echo       # Default partition number (3)
echo       # Default first sector
echo +$PART3_SIZE   # Last sector (+2G size)
echo t     # Change partition type
echo 3     # Select partition 3
echo 19    # Linux swap

echo n     # Add a new partition (4)
echo       # Default partition number (4)
echo       # Default first sector
if [ -n "$PART4_SIZE" ]; then
  echo +$PART4_SIZE # Last sector (+4 size)
else
  echo         # Default last sector (use rest of the disk)
fi
echo t     # Change partition type
echo 4     # Select partition 4
echo 20    # Linux filesystem

echo w     # Write changes
) | fdisk "$DISK_NAME" #> /dev/null 2>&1
check_command "Partitioning the disk"

# Wait for a moment to ensure the partition table is updated
sync
sleep 5

# Create filesystems on the partitions
echo "Creating filesystems..."

# /boot/efi partition (second partition)
mkfs.fat -F32 ${DISK_NAME}1
check_command "Creating FAT32 filesystem on /boot/efi"

# /boot partition (first partition)
mkfs.ext4 ${DISK_NAME}2
check_command "Creating ext4 filesystem on /boot"

# Swap partition (third partition)
mkswap ${DISK_NAME}3
check_command "Creating swap filesystem"
swapon ${DISK_NAME}3
check_command "Activating swap"

# / (root) partition (fourth partition)
mkfs.ext4 ${DISK_NAME}4
check_command "Creating ext4 filesystem on /"


# Get UUIDs and write to file
echo BOOT_UUID=$(blkid -s UUID -o value ${DISK_NAME}2) >> $Info
echo EFI_UUID=$(blkid -s UUID -o value ${DISK_NAME}1) >> $Info
echo ROOT_UUID=$(blkid -s UUID -o value ${DISK_NAME}4) >> $Info
echo SWAP_UUID=$(blkid -s UUID -o value ${DISK_NAME}3) >> $Info
echo ROOT_PARTUUID=$(blkid -s PARTUUID -o value ${DISK_NAME}4) >> $Info

echo "Partitioning and formatting complete."
echo "Mount points and labels:"
echo "${DISK_NAME}2 -> /boot (ext4)"
echo "${DISK_NAME}3 -> swap"
echo "${DISK_NAME}4 -> / (ext4)"
