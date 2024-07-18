#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

# Setting the LFS variable
echo "Setting the LFS variable..."
export LFS=/mnt/lfs

# Create the required directory layout
echo "Creating the required directory layout..."
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
    ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/tools

# add the LFS user if it doesn't already exist
if id "lfs" &>/dev/null; then
    echo "User 'lfs' already exists. Skipping user creation." | tee -a "$LOGFILE"
else
    echo "Adding the LFS user..." | tee -a "$LOGFILE"
    groupadd lfs | tee -a "$LOGFILE"
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs | tee -a "$LOGFILE"
    echo "Please set a password for the 'lfs' user:" | tee -a "$LOGFILE"
    passwd lfs | tee -a "$LOGFILE"
fi

# Grant lfs full access to all directories under $LFS
echo "Granting lfs full access to all directories under $LFS..."
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
    x86_64) chown -v lfs $LFS/lib64 ;;
esac

# Set up the working environment for user lfs
su - lfs << "EOF"
cat > ~/.bash_profile << "PROFILE_EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
PROFILE_EOF

cat > ~/.bashrc << "RC_EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
export MAKEFLAGS=-j$(nproc)
RC_EOF
EOF
exit 0
