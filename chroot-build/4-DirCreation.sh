#!/bin/bash

# Create essential system directories with -p option to avoid errors if they already exist
mkdir -pv /{boot,home,mnt,opt,srv}

# Create etc directory and its subdirectories
mkdir -pv /etc/{opt,sysconfig}

# Create lib/firmware directory
mkdir -pv /lib/firmware

# Create media directory and its subdirectories
mkdir -pv /media/{floppy,cdrom}

# Create usr directory and its subdirectories
mkdir -pv /usr/{,local/}{include,src}

# Create usr/local directory and its subdirectories
mkdir -pv /usr/local/{bin,lib,sbin}

# Create usr/share directory and its subdirectories
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}

# Create usr/share/man directory and its subdirectories
mkdir -pv /usr/{,local/}share/man/man{1..8}

# Create var directory and its subdirectories
mkdir -pv /var/{cache,local,log,mail,opt,spool}

# Create var/lib directory and its subdirectories
mkdir -pv /var/lib/{color,misc,locate}

# Create symbolic links for run and lock directories
ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

# Create root directory with permissions 0750
install -dv -m 0750 /root

# Create tmp and var/tmp directories with permissions 1777
install -dv -m 1777 /tmp /var/tmp
