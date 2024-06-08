#!/bin/bash

# must be super user (use 'sudo su')
if [ "$(id -u)" -ne 0 ]; then
   echo "This script must be run as root" >&2
   exit 1
fi

# Remove the info, man, and doc directories along with their contents under /usr/share
rm -rf /usr/share/{info,man,doc}/*

# Find and delete all files with.la extension under /usr/lib and /usr/libexec
find /usr/{lib,libexec} -name \*.la -delete

# Remove the /tools directory and its contents
rm -rf /tools
