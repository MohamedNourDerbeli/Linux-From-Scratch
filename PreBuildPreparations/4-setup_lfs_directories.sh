#!/bin/bash
# This script sets up the directory layout for the LFS system.

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

# Create the required directory layout
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

# Create symbolic links
for i in bin lib sbin; do
 ln -sv usr/$i $LFS/$i
done

# Create lib64 directory for x86_64 systems
case $(uname -m) in
 x86_64) mkdir -pv $LFS/lib64 ;;
esac

# Create the tools directory for the cross-compiler
mkdir -pv $LFS/tools

echo "LFS directory layout setup complete."
