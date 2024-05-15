#!/bin/bash

# Change ownership of the specified directories to root:root
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}

# Check the architecture and change ownership of lib64 if necessary
case $(uname -m) in
  x86_64)
    chown -R root:root $LFS/lib64
    ;;
esac

echo "Ownership of $LFS directories has been changed to root:root."
