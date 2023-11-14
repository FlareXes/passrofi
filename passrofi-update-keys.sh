#!/bin/bash

# Author: FlareXes
# Twitter: @flarexes
# Link: https://github.com/flarexes/passrofi
#
# Script Purpose:
# This Bash script is designed to automate the process of updating existing password store (pass-otp) with new GPG keys.
# It provides functions to generate a GPG key, initialize a password store, export OTP secrets to a CSV file, 
# and import OTP secrets from a CSV file into the password store.
# Existing ~/.password-store and ~/.gnupg will be backed up as  ~/.password-store-bak, ~/.gnupg-bak respectively.


# Exit out of script if any error occurs
set -e

# Functions to display colored messages
green_echo() {
  echo -e "\e[32m$1\e[0m"
}

yellow_echo() {
  echo -e "\e[33m$1\e[0m"
}

red_echo() {
  echo -e "\e[31m$1\e[0m"
}

# Function to generate GPG key
generate_gpg_key() {
  if [[ -d ~/.gnupg/ ]]; then
    yellow_echo "Backing up existing GPG directory to ~/.gnupg-bak/"
    cp -r ~/.gnupg/ ~/.gnupg-bak/
  fi
  
  yellow_echo "Generating a new GPG key..."
  gpg2 --full-generate-key
}

# Function to initialize password store with email
init_password_store() {
  if [[ -d ~/.password-store/ ]]; then
    yellow_echo "Backing up existing Password-Store directory to ~/.password-store-bak/"
    mv ~/.password-store/ ~/.password-store-bak/
  fi

  green_echo "Listing present GPG keys:"

  # List GPG keys
  gpg --list-secret-keys

  # Prompt user to choose a key
  read -p "E-Mail address of keypair you want to use for the password store: " email
  pass init "$email"

  if [[ -d ~/.password-store-bak/.git ]]; then
    green_echo "Copying existing .git Password-Store directory to ~/.password-store:"
    cp -r ~/.password-store-bak/.git/ ~/.password-store/
  fi
}

# Function to export OTP secrets to CSV
export_to_csv() {
  csv_file="passwords.csv"
  green_echo "Exporting OTP secrets to $csv_file..."
  for gpg_key in $(ls ~/.password-store/); do
    pass_show=$(pass "${gpg_key%%.*}")
    echo "${gpg_key%%.*},$pass_show" >> "$csv_file"
  done
}

# Function to import OTP secrets from CSV into password store
import_to_password_store() {
  csv_file="passwords.csv"
  yellow_echo "Importing OTP secrets from $csv_file to password store..."

  while IFS=',' read -r name secret; do
    echo "$secret" | pass otp insert "$name"
  done < "$csv_file"
}

# Export OTP secrets to CSV
export_to_csv

# Ask user if they want to create a new GPG keypair or use an existing one
read -p "Do you want to create a new GPG keypair? (y/n): " create_new_keypair

if [[ $create_new_keypair == "y" ]]; then
  generate_gpg_key
fi

# Initialize password store with email
init_password_store

# Import OTP secrets from CSV into password store
import_to_password_store

red_echo "NOTE: Please safely remove `passwords.csv` in persent working directory..."
green_echo "Script execution completed successfully!"
