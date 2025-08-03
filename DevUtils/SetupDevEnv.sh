#!/bin/bash

set -e

THIS_PATH="$0"
THIS_FOLDER="$(cd "$(dirname "$0")" && pwd)"

print_usage() {
    echo "> Usage: $THIS_PATH [SOURCE_PYTHON]"
    echo "> Example: $THIS_PATH python3"
}

SRC_PYTHON="/usr/bin/python"
VENV_PATH="$(realpath --canonicalize-missing "$THIS_FOLDER/../../../tools/bmcpptPyVenv")"

# If argument is passed, use it as Python path
if [ -n "$1" ]; then
    SRC_PYTHON="$1"
else
    echo "Source Python not provided"
    print_usage
    echo "Using default: $SRC_PYTHON"
fi

# Check if the Python executable exists
if [ ! -x "$SRC_PYTHON" ]; then
    echo "Source Python executable not found: $SRC_PYTHON"
    print_usage
    exit 1
fi

echo "Using Python executable: $SRC_PYTHON"
echo "Creating Python virtual environment in: $VENV_PATH"

"$SRC_PYTHON" -m venv "$VENV_PATH"

# Activate the virtual environment
# shellcheck source=/dev/null
source "$VENV_PATH/bin/activate"

echo "Installing Python requirements"
pip install -r "$THIS_FOLDER/PythonRequirements.txt"

echo "Running setup actions"
penvstp \
    --dry-mode=default \
    --temp-folder="$THIS_FOLDER/../../../temp" \
    --tools-folder="$THIS_FOLDER/../../../tools" \
    --externals-folder="$THIS_FOLDER/../../../externals" \
    "$THIS_FOLDER/env_setup_actions.json"
