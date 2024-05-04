# Linux From Scratch (LFS) Project

## Preparing for the Build

This folder for  setting up the host environment and partition for the Linux From Scratch (LFS) build. It covers the installation of necessary tools and the preparation of a dedicated partition for the LFS system.

## Table of Contents

1. [Version Check](#version-check)
2. [Creating Partitions](#creating-partitions)
3. [Checking and Installing Dependencies](#checking-and-installing)
4. [Downloading and Verifying Sources](#downloading-and-verifying)
5. [Setting Up LFS Directories](#setting-up-lfs-directories)
6. [Adding the LFS User](#adding-the-lfs-user)
7. [Setting Up LFS Profile](#setting-up-lfs-profile)
8. [Main Setup Script](#main-setup-script)
9. [Wget List for Systemd](#wget-list-for-systemd)

## Scripts

### 0. Version Check (`1-version-check.sh`)

- **Purpose**: Checks the version of the host system to ensure compatibility with the LFS build process.
- **Usage**: Run `./1-version-check.sh` to check the version.

### 1. Create Partitions (`0-create_partitions.sh`)

- **Purpose**: This script is responsible for creating the necessary partitions for the LFS build.
- **Usage**: Run `./0-create_partitions.sh` to execute the script.

### 2. Check and Install Dependencies (`2-check_and_install.sh`)

- **Purpose**: Verifies the presence of required packages and installs them if necessary.
- **Usage**: Run `./2-check_and_install.sh` to check and install dependencies.

### 3. Download and Verify Sources (`3-download_and_verify.sh`)

- **Purpose**: Downloads the necessary sources for the LFS build and verifies their integrity.
- **Usage**: Run `./3-download_and_verify.sh` to download and verify sources.

### 4. Set Up LFS Directories (`4-setup_lfs_directories.sh`)

- **Purpose**: Creates the directory structure required for the LFS build.
- **Usage**: Run `./4-setup_lfs_directories.sh` to set up the directories.

### 5. Add LFS User (`5-add_lfs_user.sh`)

- **Purpose**: Creates a new user account for the LFS build process.
- **Usage**: Run `./5-add_lfs_user.sh` to add the LFS user.

### 6. Set Up LFS Profile (`6-setup_lfs_profile.sh`)

- **Purpose**: Configures the LFS user's environment for the build process.
- **Usage**: Run `./6-setup_lfs_profile.sh` to set up the LFS profile.

### 7. Wget List for Systemd (`wget-list-systemd`)

- **Purpose**: Provides a list of packages to be downloaded for the LFS build, optimized for use with systemd.
- **Usage**: Run `./wget-list-systemd` to generate the list.

## Getting Started

1. Ensure your system meets the requirements for the LFS build process.
2. Run the scripts in the order listed above.
3. Follow any additional instructions provided within the scripts.
