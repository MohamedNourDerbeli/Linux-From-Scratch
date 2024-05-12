#!/bin/bash
# This script sets up the LFS user and environment

export LFS="/mnt/lfs"


# sets up the LFS user
echo "sets up the LFS user"

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check if the LFS variable is set
if [ -z "$LFS" ]; then
    echo "The LFS variable is not set."
    exit 1
fi

# Check if the user 'lfs' exists
if id "lfs" &>/dev/null; then
    userdel -r lfs
fi
# Add the LFS group
groupadd lfs

# Add the LFS user
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

# Set the password for the LFS user
echo "Setting password for lfs user..."
passwd lfs

# Grant lfs full access to all the directories under $LFS
echo "Granting ownership to lfs user..."
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
