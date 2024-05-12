#!/bin/bash

# Change the current directory to $LFS/sources
cd $LFS/sources

# Extract the Sed archive
echo "Extracting Sed"
tar -xvJf sed-4.9.tar.xz

# Change the current directory to $LFS/sources/sed-4.9
cd $LFS/sources/sed-4.9

# Display a message indicating the start of the Sed configuration and build process
echo "Configuring and building Sed"

# Execute the configure script, specifying the installation prefix as /usr,
# the build target as $LFS_TGT, and the build configuration using config.guess,
# then build and install Sed into the $LFS directory
time ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess) && make && make DESTDIR=$LFS install

# Change the current directory back to $LFS/sources
cd $LFS/sources

# Remove the extracted Sed directory
rm -rf sed-4.9
