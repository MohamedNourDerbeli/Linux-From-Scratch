#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

export LFS=/mnt/lfs

# Create the $LFS/sources directory if it doesn't exist
echo "Creating $LFS/sources directory if it doesn't exist..."
mkdir -p $LFS/sources

# Make the directory writable and sticky
echo "Making the $LFS/sources directory writable and sticky..."
chmod a+wt $LFS/sources

# Check if the sources directory exists in the working directory
if [ -d "sources" ]; then
  echo "Sources directory found in the working directory. Copying to $LFS..."
  cp -r sources/* $LFS/sources
else
  echo "Sources directory not found. Downloading necessary packages and patches..."
  # Add your wget command here, for example:
  wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
fi

# # Verify the downloaded files using md5sums
# echo "Verifying downloaded files..."
# pushd $LFS/sources > /dev/null

# # Check if md5sums file exists
# if [ ! -f md5sums ]; then
#   echo "Error: md5sums file not found in $LFS/sources."
#   exit 1
# fi

# # Run the md5sum check
# md5sum -c md5sums || true

# # Extract the names of the missing files from the md5sum output
# missing_files=$(md5sum -c md5sums 2>&1 | grep 'FAILED' | awk -F':' '{print $1}')
# popd > /dev/null

# if [ -z "$missing_files" ]; then
#   echo "All files are present and correct."
# else
#   echo "The following files are missing or corrupted:"
#   for file in $missing_files; do
#     filename=$(basename "$file")  # Extract filename without path
#     echo "$filename"
#   done
#   exit 1
# fi

# Change the ownership of the files to root
echo "Changing the ownership of the files to root..."
chown root:root $LFS/sources/*

echo "Script completed successfully."
