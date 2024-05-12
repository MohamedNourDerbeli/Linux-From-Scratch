#!/bin/bash

# This script downloads packages and patches From (LFS) website.

export LFS="/mnt/lfs"

# Check if the LFS environment variable is set
if [ -z "$LFS" ]; then
    echo "Error: LFS environment variable is not set."
    echo "Please set the LFS environment variable"
    exit 1
fi
# Check if the folder $LFS/sources exists
if [ -d "sources" ]; then
    cp -r sources $LFS
    chmod -v a+wt $LFS/sources
    # Verify the downloaded files
    pushd "$LFS/sources" >/dev/null || exit 1  # Change to the sources directory
    md5sum -c md5sums >/dev/null 2>&1           # Verify MD5 checksums
    chown root:root $LFS/sources/*
    popd >/dev/null || exit 1                   # Return to the previous directory
    exit 0
fi


# Function to download a file with a given URL and output file name
# with progress reporting
download_with_name() {
    local url=$1
    local output_file=$2
    local filename=$(basename "$url")  # Extract the filename from the URL
    echo "Downloading $filename"        # Print the package name
    # Use wget to download the file with simplified progress reporting
    wget -O "$output_file" "$url" >/dev/null 2>&1
}

# Create the sources directory
mkdir -v $LFS/sources

chmod -v a+wt $LFS/sources


# Download the packages and patches from the wget-list-systemd file
while read -r url; do
    output_file="$LFS/sources/$(basename "$url")"  # Construct the output file path
    if [[ ! -f $output_file ]]; then
        download_with_name "$url" "$output_file"   # Download the file with progress reporting
    fi
done < PreBuildPreparations/wget-list-systemd

# Download the md5sums file
wget --continue --directory-prefix="$LFS/sources" "https://www.linuxfromscratch.org/lfs/view/12.1-systemd/md5sums" >/dev/null 2>&1
chown root:root $LFS/sources/*
# Verify the downloaded files
pushd "$LFS/sources" >/dev/null || exit 1  # Change to the sources directory
md5sum -c md5sums >/dev/null 2>&1           # Verify MD5 checksums
popd >/dev/null || exit 1                   # Return to the previous directory
