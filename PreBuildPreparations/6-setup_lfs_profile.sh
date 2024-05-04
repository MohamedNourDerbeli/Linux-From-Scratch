#!/bin/bash
# This script will Set up the Environment

echo "Setting up lfs user's environment..."
# Create .bash_profile for the lfs user
./config/.bash_profile

# Create .bashrc for the lfs user
./config/.bashrc

# Switch to the LFS user

echo "All scripts have been executed successfully."

sleep 3

echo "Switching to lfs user..."

sleep 1

su - lfs
