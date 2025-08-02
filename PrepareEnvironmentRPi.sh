#!/bin/bash

TOOLCHAIN_URL="https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-aarch64-arm-none-eabi.tar.xz"
TOOLCHAIN_FILENAME=$(basename "$TOOLCHAIN_URL")
RELATIVE_INSTALL_PATH="../../tools"
FULL_INSTALL_DIR="" # Will be determined dynamically

# --- Functions ---

log_info() {
    echo -e "\e[32mINFO:\e[0m $1"
}

log_warn() {
    echo -e "\e[33mWARN:\e[0m $1"
}

log_error() {
    echo -e "\e[31mERROR:\e[0m $1"
    exit 1
}

# --- Main Logic ---

# Determine the absolute path of the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
log_info "Script is running from: $SCRIPT_DIR"

# Calculate the full installation directory path
FULL_INSTALL_DIR=$(realpath "$SCRIPT_DIR/$RELATIVE_INSTALL_PATH")

#Check if the toolchain web source is reachable
if ! curl --output /dev/null --silent --head --fail "$TOOLCHAIN_URL"; then
    log_error "Toolchain URL is not reachable: $TOOLCHAIN_URL"
fi

log_info "Toolchain will be installed to: $FULL_INSTALL_DIR"
DO_CLEAN=1
if [ -f "/tmp/$TOOLCHAIN_FILENAME" ]; then
  echo "/tmp/$TOOLCHAIN_FILENAME exists skipping download."
  DO_CLEAN=0
#else
# Download the toolchain
#log_info "Downloading toolchain from $TOOLCHAIN_URL..."
#wget "$TOOLCHAIN_URL" -O "/tmp/$TOOLCHAIN_FILENAME" || log_error "Failed to download toolchain."
fi

#SUB_FOLDER_NAME=$(tar -tf "/tmp/$TOOLCHAIN_FILENAME" | head -n 1 | sed 's#/$##' | cut -d'/' -f1)
#TOOLCHAIN_BIN_PATH="$FULL_INSTALL_DIR/$SUB_FOLDER_NAME/bin"
#log_info "Toolchain binaries will be in: $TOOLCHAIN_BIN_PATH"

# Check if toolchain is already installed
#if [ -d "$FULL_INSTALL_DIR" ] && [ -f "$TOOLCHAIN_BIN_PATH/arm-none-eabi-gcc" ]; then
#    log_warn "Toolchain appears to be already installed at $FULL_INSTALL_DIR/$SUB_FOLDER_NAME."
#    log_info "If you want to reinstall, please remove the directory first: rm -rf $FULL_INSTALL_DIR/$SUB_FOLDER_NAME"
#    log_info "Exiting as toolchain is already present."
#    exit 0
#fi

# Create the parent Tools directory if it doesn't exist
#log_info "Creating parent directory: $(dirname "$FULL_INSTALL_DIR")"
#mkdir -p "$(dirname "$FULL_INSTALL_DIR")" || log_error "Failed to create directory: $(dirname "$FULL_INSTALL_DIR")"

# Extract the toolchain
#log_info "Extracting toolchain to $FULL_INSTALL_DIR..."
# Create the specific toolchain directory before extracting
#mkdir -p "$FULL_INSTALL_DIR" || log_error "Failed to create toolchain directory: $FULL_INSTALL_DIR"

# --strip-components=1 removes the top-level directory inside the tarball
#tar xf "/tmp/$TOOLCHAIN_FILENAME" -C "$FULL_INSTALL_DIR" || log_error "Failed to extract toolchain."

#if [ "$DO_CLEAN" -eq 1 ]; then
  # Clean up the downloaded archive
#  log_info "Cleaning up temporary download file."
#  rm "/tmp/$TOOLCHAIN_FILENAME" || log_warn "Failed to remove temporary file: /tmp/$TOOLCHAIN_FILENAME"
#fi


# Verify installation (optional, but good for confirmation)
#log_info "Verifying toolchain installation..."
#if [ -f "$TOOLCHAIN_BIN_PATH/arm-none-eabi-gcc" ]; then
#    log_info "arm-none-eabi-gcc binary found at $TOOLCHAIN_BIN_PATH/arm-none-eabi-gcc"
#else
#    log_error "arm-none-eabi-gcc binary not found after extraction. Check installation."
#fi


#wget https://github.com/Kitware/CMake/releases/download/v3.31.7/cmake-3.31.7-linux-aarch64.sh
#bash cmake-3.31.7-linux-aarch64.sh --prefix=./tools/cmake --skip-license
