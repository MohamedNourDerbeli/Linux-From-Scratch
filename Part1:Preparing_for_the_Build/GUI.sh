#!/bin/bash

set -euo pipefail
export Info="../info.txt"
# Function to prompt for input with a default value and save to a file
input_with_default() {
  local prompt=$1
  local default=$2
  local variable_name=$3
  local value=$(dialog --title "Partition Size" --inputbox "$prompt" 8 50 "$default" 3>&1 1>&2 2>&3)
  if [ -z "$value" ]; then
    value="$default"
  fi
  echo "$variable_name=$value" >> $Info
  echo "$value"
}


# List all disks and store them in a variable
disks=$(lsblk -d -o NAME,SIZE | grep -E '^sd|^nvme')

# Use dialog to select a disk
DISK=$(echo "$disks" | awk '{print $1 " " $2}' | xargs dialog --title "Disk Selection" --menu "Select the disk to partition:" 20 60 10 3>&1 1>&2 2>&3)

# Check if a disk was selected
if [ -z "$DISK" ]; then
  dialog --msgbox "No disk selected. Exiting." 5 40
  exit 1
fi

DISK="/dev/$DISK"

# Check if the disk exists
if [ ! -b "$DISK" ]; then
  dialog --msgbox "Error: Disk $DISK does not exist." 5 50
  exit 1
fi

# Confirm the disk name
dialog --title "Warning" --yesno "You selected $DISK. This will destroy all data on $DISK. Do you want to proceed?" 7 50
response=$?
if [ $response -ne 0 ]; then
  echo "Aborting."
  exit 1
fi

# Remove the file if it already exists
rm -f $Info
echo "DISK_NAME=$DISK" >> $Info
# Default partition sizes
PART1_DEFAULT="200M"
PART2_DEFAULT="200M"
PART3_DEFAULT="2G"
PART4_DEFAULT=""

# Get input from user and save to file
PART1_SIZE=$(input_with_default "Enter size for /boot partition (e.g., 500M):" "$PART1_DEFAULT" "PART1_SIZE")
PART2_SIZE=$(input_with_default "Enter size for /boot/efi partition (e.g., 1G):" "$PART2_DEFAULT" "PART2_SIZE")
PART3_SIZE=$(input_with_default "Enter size for swap partition (e.g., 2G):" "$PART3_DEFAULT" "PART3_SIZE")
PART4_SIZE=$(input_with_default "Enter size for root partition (use the rest of the disk):" "$PART4_DEFAULT" "PART4_SIZE")


continents=$(cat <<EOF
Africa
America
Antarctica
Asia
Atlantic
Australia
Europe
Indian
Pacific
EOF
)

# Ask user for their continent
continent=$(echo "$continents" | zenity --list --title="Select Your Continent" --column="Continents") 

# If the user cancels the dialog, exit the script
if [ -z "$continent" ]; then
    echo "No continent selected. Exiting."
    exit 1
fi

# List of time zones for the selected continent
timezones=$(find /usr/share/zoneinfo/$continent -type f | sed "s|/usr/share/zoneinfo/||")

# Ask user for their local time zone
timezone=$(echo "$timezones" | zenity --list --title="Select Your Time Zone" --column="Time Zones") > /dev/null 2>&1

# If the user cancels the dialog, exit the script
if [ -z "$timezone" ]; then
    echo "No time zone selected. Exiting."
    exit 1
fi

# Use the selected time zone
echo timezone=$timezone >> $Info

# Ask for the username
USERNAME=$(dialog --stdout --inputbox "Enter the username:" 10 40)
if [ $? -ne 0 ]; then
    echo "Aborting."
    exit 1
fi

# Ask for the password
PASSWORD=$(dialog --stdout --passwordbox "Enter the password:" 10 40)
if [ $? -ne 0 ]; then
    echo "Aborting."
    exit 1
fi

# Confirm the password
CONFIRM_PASSWORD=$(dialog --stdout --passwordbox "Confirm the password:" 10 40)
if [ $? -ne 0 ]; then
    echo "Aborting."
    exit 1
fi

# Check if passwords match
if [ "$PASSWORD" != "$CONFIRM_PASSWORD" ]; then
    dialog --msgbox "Passwords do not match. Please try again." 10 40
    exit 1
fi

echo USERNAME=$USERNAME >> $Info
echo PASSWORD=$PASSWORD >> $Info


