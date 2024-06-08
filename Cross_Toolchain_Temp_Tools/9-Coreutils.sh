#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change to the LFS/sources directory
cd $LFS/sources

# Extract Coreutils
echo "Extracting Coreutils"
tar -xvJf coreutils-9.4.tar.xz

# Change to the extracted Coreutils directory
cd $LFS/sources/coreutils-9.4

# Configure and build Coreutils with specified parameters
echo "Configuring and building Coreutils"
time ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime && make && make DESTDIR=$LFS install

# Move the chroot binary to the /usr/sbin directory
mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin

# Create the /usr/share/man/man8 directory
mkdir -pv $LFS/usr/share/man/man8

# Move the chroot.1 man page to the /usr/share/man/man8 directory
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8

# Update the man page section number from 1 to 8
sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8

# Change back to the LFS/sources directory
cd $LFS/sources

# Remove the extracted Coreutils directory
rm -rf coreutils-9.4
