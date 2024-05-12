#!/bin/bash

# Create.bashrc for the lfs user
cat > /home/lfs/.bashrc << "EOF"
# Disable hash lookup for commands
set +h

# Set the file mode creation mask to 022
umask 022

# Set the LFS variable to /mnt/lfs
LFS=/mnt/lfs

# Set the LC_ALL environment variable to POSIX
LC_ALL=POSIX

# Set the LFS_TGT variable to the target architecture
LFS_TGT=$(uname -m)-lfs-linux-gnu

# Set the PATH environment variable to /usr/bin
PATH=/usr/bin

# If /bin is not a symbolic link, add it to the PATH
if [! -L /bin ]; then PATH=/bin:$PATH; fi

# Add the LFS tools directory to the PATH
PATH=$LFS/tools/bin:$PATH

# Set the CONFIG_SITE environment variable to the config site file
CONFIG_SITE=$LFS/usr/share/config.site

# Export the LFS, LC_ALL, LFS_TGT, PATH, and CONFIG_SITE variables
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE

# Export the MAKEFLAGS variable with the number of processors
export MAKEFLAGS=-j$(nproc)

# If the binutils setup script exists, run it
if [ -f $LFS/usr/1-binutils_setup.sh ]; then
    # Run the binutils setup script
    $LFS/usr/1-binutils_setup.sh

    # Run the GCC setup script
    $LFS/usr/2-GCC_setup.sh

    # Run the Linux API headers setup script
    $LFS/usr/3-Linux_API_Headers.sh

    # Run the Glibc setup script
    $LFS/usr/4-Glibc_setup.sh

    # Remove the setup scripts
    rm -f $LFS/usr/*.sh

    # Exit the script
    exit 1
fi

EOF

exit 1
