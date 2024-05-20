#!/bin/bash

# Change to the LFS/sources directory
cd $LFS/sources

# Echo a message to the console indicating that Gettext is being extracted
echo "Extracting Gettext"

# Extract the Gettext tarball using the tar command with the -x (extract) and -v (verbose) options,
# and the -J (xz) option to specify the compression algorithm
tar -xvf gettext-0.22.4.tar.xz

# Change to the extracted Gettext directory
cd $LFS/sources/gettext-0.22.4

# Run the configure script with the --disable-shared option to disable the creation of shared libraries
./configure --disable-shared

# Build the Gettext package using the make command
make

# Copy the msgfmt, msgmerge, and xgettext utilities to the /usr/bin directory
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Gettext directory and its contents
rm -rf gettext-0.22.4
