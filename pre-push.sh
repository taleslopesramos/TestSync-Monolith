#!/bin/sh

# Get the local branch name
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Check if the current branch is main
if [ "$current_branch" != "main" ]; then
    echo "Skipping pre-push hook as you are not on the main branch."
    exit 0
fi

# Path to the source repository
SOURCE_REPO="https://github.com/taleslopesramos/TestSync-Service.git"

# Temporary directory to clone the source repo
TEMP_DIR="$(mktemp -d)"

# Target directory within your current repository
TARGET_DIR="/Service"

# Clone the source repository temporarily
git clone $SOURCE_REPO $TEMP_DIR

# Copy the contents to the target directory
# Note: This example overwrites files without merging. See the note below for actual merging.
cp -r $TEMP_DIR/* $TARGET_DIR

# Add changes to git
git add $TARGET_DIR

# Clean up the temporary directory
rm -rf $TEMP_DIR

# Note: This script assumes it's safe to overwrite files in TARGET_DIR.
# For actual merging, consider using 'git merge', 'rsync', or other tools
# that better handle file conflicts and merging.

# Exit successfully
exit 0