#!/bin/bash

# This script counts changed files in specified folders

# Check if it's the first commit
if [ "$(git rev-list --count HEAD)" -eq "1" ]; then
    # It's the first commit, count all files in specified folder
    for folder in "$@"
    do
        file_count=$(git ls-tree -r HEAD --name-only | grep -c "^$folder/")
        echo "$folder count=$file_count"
    done
else
    # Not the first commit, perform diff
    for folder in "$@"
    do
        file_count=$(git diff-tree --no-commit-id --name-only -r ${{ github.sha }} | grep -c "^$folder/")
        echo "$folder count=$file_count"
    done
fi
