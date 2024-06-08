#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change to the /sources directory
cd /sources

# Extract Util-linux
echo "Extracting Util-linux"
tar -xvf util-linux-2.39.3.tar.xz

# Change to the extracted Util-linux directory
cd util-linux-2.39.3

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

# Change back to the /sources directory
cd /sources

# Remove the extracted Util-linux directory
rm -rf util-linux-2.39.3
