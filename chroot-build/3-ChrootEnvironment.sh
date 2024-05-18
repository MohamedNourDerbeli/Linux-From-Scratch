#!/bin/bash

# Export the LFS variable, which points to the LFS partition
export LFS="/mnt/lfs"

# Use chroot to change the root directory to the LFS partition
chroot "$LFS" /usr/bin/env -i   \

# Set the HOME environment variable to /root
HOME=/root                  \

# Set the TERM environment variable to the current terminal type
TERM="$TERM"                \

# Set the PS1 prompt to display (lfs chroot) followed by the user and working directory
PS1='(lfs chroot) \u:\w\$ ' \

# Set the PATH environment variable to include /usr/bin and /usr/sbin
PATH=/usr/bin:/usr/sbin     \

# Set the MAKEFLAGS variable to enable parallel builds with the number of processors available
MAKEFLAGS="-j$(nproc)"      \

# Set the TESTSUITEFLAGS variable to enable parallel tests with the number of processors available
TESTSUITEFLAGS="-j$(nproc)" \

# Start a new bash shell with the --login option, which reads and executes the system-wide and user-specific login scripts
/bin/bash --login
