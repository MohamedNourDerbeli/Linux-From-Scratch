#!/bin/bash

# Export the LFS variable, which points to the LFS partition
export LFS="/mnt/lfs"

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    for script in $(ls -v chroot-build/*.sh); do \
    if [[ "$(basename "$script")" =~ ^[3-12]+- ]]; then \
        bash $script \
    fi \
    done \
    /bin/bash --login 
