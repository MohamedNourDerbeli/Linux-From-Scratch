#!/bin/bash
# This script will Set up the Environment

echo "Setting up lfs user's environment..."
# Create .bash_profile for the lfs user
# cp config/* /mnt/lfs
sudo -E -u lfs config/.bash_profile

# Create .bashrc for the lfs user
sudo -E -u lfs config/.bashrc
