# Linux From Scratch (LFS) Automated Build

This project is an automated setup for building a Linux From Scratch (LFS) system. The scripts provided streamline the process of setting up an LFS environment, preparing the necessary partitions, installing required packages, and downloading sources. This README will guide you through what each component does, making it easier to understand how the system is built.

## **Project Overview**

This project automates the following key tasks involved in building a Linux system from scratch:
- Setting up and mounting partitions.
- Checking and installing missing or outdated software dependencies.
- Preparing the sources for the LFS build by downloading or copying packages.
- Ensuring proper environment variables and configurations are in place.
- Interacting with the user via a GUI for inputting partition sizes, hostname, and other configuration settings.

## **Build Steps**

### 1. **Partition Setup and Mounting**
   The project ensures that the correct partitions for your LFS system are mounted. This includes mounting the root and boot partitions. It automatically handles existing directories, ensuring a clean mount by removing old data if necessary. The system will mount the root and boot partitions in the specified locations and create any required directories.

### 2. **Dependency Checks and Installation**
   Before building the LFS system, the project checks for required packages. The system compares installed package versions with those required for the LFS build. If any packages are missing or outdated, they are automatically installed. The process includes:
   - Running a check to identify which packages are missing or outdated.
   - Installing necessary packages using the system’s package manager.
   - Ensuring the `/bin/sh` symlink points to the Bash shell for compatibility.

### 3. **Preparing the Sources Directory**
   The build requires several packages and patches. The project prepares the sources directory where these packages are stored. It checks whether the sources directory is already available locally, and if not, downloads the required packages and patches. It also:
   - Creates the sources directory if it doesn't exist.
   - Ensures the directory is writable and secure by setting appropriate permissions.
   - Downloads the necessary packages using a pre-defined list, ensuring that all required files are available for the build.

### 4. **Ownership and Permission Configuration**
   After setting up the sources, the project ensures that all files have the correct ownership and permissions. This is crucial for maintaining system security and ensuring smooth execution during the LFS build. All files in the sources directory are set to be owned by the root user, which is a necessary step before proceeding with the build.

### 5. **User Input via GUI**
   A simple graphical user interface (GUI) is provided during the installation process to capture user input. The GUI will prompt the user to provide important configurations like partition sizes, the hostname for the system, and other essential settings. This simplifies the build process by allowing the user to interact with the setup through a friendly interface.

### 6. **Error Handling**
   Each stage of the build process includes robust error handling. If any command fails, the system provides an error message and stops the build. This prevents partial configurations and ensures that issues are addressed immediately.

## **Running the Build**

To start the LFS build process:
1. Ensure the scripts are executable by running:
   ```bash
   chmod +x *.sh

2. Execute the main installation script that handles the full process:
   ```bash
   sudo ./install.sh
   ```

This will launch the GUI to take user inputs and trigger the sequence of steps necessary for setting up the LFS environment.

## **Project Structure**
- **Partition Mounting**: Handles the mounting of required file systems and prepares the LFS environment.
- **Dependency Management**: Checks for required software and installs any missing dependencies.
- **Source Preparation**: Manages the download or copy of LFS source packages and ensures their integrity.
- **User Input**: Collects configuration information from the user via a simple GUI for ease of use.
- **Error Handling**: Provides checks and balances at each step to ensure smooth operation and prompt error reporting.

## **Prerequisites**
- A compatible Linux system with root privileges.
- Basic understanding of Linux From Scratch methodology.
- Internet connection for downloading required packages if they are not available locally.

## **Important Notes**
- The process is designed to be automated, but it assumes you are familiar with Linux system administration and basic shell scripting.
- Make sure to review the system’s requirements and package lists before starting the build, as missing software could interrupt the process.
- This project provides automation for many steps, but manual intervention may be required in specific cases, such as configuring certain packages or handling errors.

