#!/bin/bash
# Download the packages and patches

# Check if the LFS environment variable is set
if [ -z "$LFS" ]; then
    echo "Error: LFS environment variable is not set."
    echo "Please set the LFS environment variable to the path of your Linux From Scratch source directory."
    exit 1
fi

# Download the packages and patches
wget --input-file=wget-list-systemd --continue --directory-prefix="$LFS/sources"

# Download the md5sums file
wget --continue --directory-prefix="$LFS/sources" https://www.linuxfromscratch.org/lfs/view/12.1-systemd/md5sums

# Verify the downloaded files
pushd "$LFS/sources" >/dev/null
md5sum -c md5sums
popd >/dev/null
