#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change into the sources directory
cd $LFS/sources

# Extract the xz-5.4.6 archive
echo "Extracting Xz"
tar -xvJf xz-5.4.6.tar.xz

# Move into the extracted xz-5.4.6 directory
cd $LFS/sources/xz-5.4.6

# Display a message to indicate the configuration and building of Xz
echo "Configuring and building Xz"

# Run the configure script with specified options
# --prefix=/usr sets the installation prefix
# --host=$LFS_TGT specifies the host platform
# --build=$(build-aux/config.guess) determines the build platform
# --disable-static disables the building of static libraries
# --docdir=/usr/share/doc/xz-5.4.6 sets the documentation directory
# time command is used to display the execution time
./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.4.6

# Build and install Xz
make

make DESTDIR=$LFS install

# Remove the liblzma.la file
rm -v $LFS/usr/lib/liblzma.la

# Move back to the sources directory
cd $LFS/sources

# Remove the xz-5.4.6 directory
rm -rf xz-5.4.6
