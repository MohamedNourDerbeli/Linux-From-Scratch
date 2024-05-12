#!/bin/bash

# Run the binutils setup script
$LFS/usr/1-binutils_setup.sh

# Run the GCC setup script
$LFS/usr/2-GCC_setup.sh

# Run the Linux API headers setup script
$LFS/usr/3-Linux_API_Headers.sh

# Run the Glibc setup script
$LFS/usr/4-Glibc_setup.sh

# Run the Libstdc++ setup script
$LFS/usr/5-Libstdc++.sh

# Run the M4 setup script
$LFS/usr/6-M4.sh

# Run the Ncurses setup script
$LFS/usr/7-Ncurses.sh

# Remove the setup scripts
rm -f $LFS/usr/*.sh
