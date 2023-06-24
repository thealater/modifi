#!/bin/bash

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing Node.js..."
brew install node

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")
LAUNCHER_DIR=$(dirname "$SCRIPT_DIR")/launcher

# Switch to the launcher directory
cd "$LAUNCHER_DIR" || exit

# Run npm install
echo "Installing Node dependencies..."
npm i
