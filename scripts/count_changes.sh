#!/bin/bash

# Arguments
commit_sha=$1
shift  # This shifts the positional parameters to the left, so $2 becomes $1, $3 becomes $2, etc.

# This script counts changed files in specified folders

# Check if it's the first commit
if [ "$(git rev-list --count $commit_sha)" -eq "1" ]; then
    # It's the first commit, count all files in specified folder
    for folder in "$@"
    do
        file_count=$(git ls-tree -r $commit_sha --name-only | grep -c "^$folder/")
        echo "$folder count=$file_count"
    done
else
    # Not the first commit, perform diff
    for folder in "$@"
    do
        file_count=$(git diff-tree --no-commit-id --name-only -r $commit_sha | grep -c "^$folder/")
        echo "$folder count=$file_count"
    done
fi
