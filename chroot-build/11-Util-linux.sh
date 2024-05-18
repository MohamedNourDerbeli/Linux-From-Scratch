#!/bin/bash

# Change to the $LFS/sources directory
cd $LFS/sources

# Extract Util-linux
echo "Extracting Util-linux"
tar -xvJf util-linux-2.39.3.tar.xz

# Change to the extracted Util-linux directory
cd $LFS/sources/util-linux-2.39.3.tar.xz

# Create the /var/lib/hwclock directory
mkdir -pv /var/lib/hwclock

# Configure the Util-linux build with various options and settings
# --libdir=/usr/lib: Set the library installation directory to /usr/lib
# --runstatedir=/run: Set the runstate directory to /run
# --disable-chfn-chsh: Disable the chfn and chsh commands
# --disable-login: Disable the login command
# --disable-nologin: Disable the nologin command
# --disable-su: Disable the su command
# --disable-setpriv: Disable the setpriv command
# --disable-runuser: Disable the runuser command
# --disable-pylibmount: Disable the pylibmount library
# --disable-static: Disable static linking
# --without-python: Do not build with Python support
# ADJTIME_PATH=/var/lib/hwclock/adjtime: Set the adjtime file path to /var/lib/hwclock/adjtime
# --docdir=/usr/share/doc/util-linux-2.39.3: Set the documentation installation directory to /usr/share/doc/util-linux-2.39.3
./configure --libdir=/usr/lib    \
            --runstatedir=/run   \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.39.3

# Build Util-linux
make

# Install Util-linux
make install

# Change back to the $LFS/sources directory
cd $LFS/sources

# Remove the extracted Util-linux directory
rm -rf util-linux-2.39.3