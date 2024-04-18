#!/bin/bash

commit_sha=$1
shift  # Shift the arguments to access folders as $@

# This script counts changed files in specified folders
echo "::group::Counting Changes"
if [ "$(git rev-list --count $commit_sha)" -eq "1" ]; then
    # It's the first commit, count all files in specified folder
    for folder in "$@"
    do
        file_count=$(git ls-tree -r $commit_sha --name-only | grep -c "^$folder/")
        echo "::set-output name=${folder}_count::$file_count"
    done
else
    # Not the first commit, perform diff
    for folder in "$@"
    do
        file_count=$(git diff-tree --no-commit-id --name-only -r $commit_sha | grep -c "^$folder/")
        echo "::set-output name=${folder}_count::$file_count"
    done
fi
echo "::endgroup::"
