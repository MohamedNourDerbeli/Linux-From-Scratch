#!/bin/bash
# This script will Set up the Environment

echo "Setting up lfs user's environment..."

sudo chmod +x config/.bash_profile
sudo chmod +x config/.bashrc

sudo -E -u lfs /bin/bash -c 'source config/.bash_profile'
sudo -E -u lfs /bin/bash -c 'source config/.bashrc'
