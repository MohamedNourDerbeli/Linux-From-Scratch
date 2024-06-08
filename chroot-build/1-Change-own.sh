#!/bin/bash

export LFS="/mnt/lfs"

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Change ownership of the specified directories to root:root
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}

# Check the architecture and change ownership of lib64 if necessary
case $(uname -m) in
  x86_64)
    chown -R root:root $LFS/lib64
    ;;
esac
