#!/bin/bash
# This script sets up the LFS user and environment

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check if the LFS variable is set
if [ -z "$LFS" ]; then
    echo "The LFS variable is not set. Please set it to the root of your LFS directory."
    exit 1
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

# Handle x86_64 architecture
case $(uname -m) in
 x86_64) chown -v lfs $LFS/lib64 ;;
esac

