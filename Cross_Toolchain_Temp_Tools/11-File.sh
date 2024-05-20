#!/bin/bash

# Change into the sources directory
cd $LFS/sources

# Extract the file-5.45.tar.gz archive
echo "Extracting File"
tar -xzvf file-5.45.tar.gz

# Change into the extracted file-5.45 directory
cd $LFS/sources/file-5.45

# Print a message indicating the configuration and build process
echo "Configuring and building File"

# Create a build directory
mkdir build

# Change into the build directory and configure the build process
pushd build
  # Configure the build process with specific options
 ../configure --disable-bzlib      \
               --disable-libseccomp \
               --disable-xzlib      \
               --disable-zlib
  # Start the build process
  make
popd

# Configure the build process with specific options for the final installation
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)

# Build the file command
make FILE_COMPILE=$(pwd)/build/src/file

# Install the file command to the specified destination
make DESTDIR=$LFS install

# Remove the libmagic.la file
rm -v $LFS/usr/lib/libmagic.la

# Change back into the sources directory
cd $LFS/sources

# Remove the extracted file-5.45 directory
rm -rf file-5.45
