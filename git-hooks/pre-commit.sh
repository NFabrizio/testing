#!/bin/bash

# This hook will run when anyone runs git commit. It can be bypassed using
# git commit --no-verify, but this is not recommended.
#
# Installation
#
# Once the file has been pulled down is in the correct directory
# (e.g., git-hooks/pre-commit.sh), navigate to the root directory of the project
# and create a symlink for the file with the command:
# ln -s ../../git-hooks/pre-commit.sh .git/hooks/pre-commit

PROTECTED_FILES=( 'test2.txt' 'test.txt' )
PROTECTED_FILES_LENGTH=${#PROTECTED_FILES[@]}

for (( i=0;i<PROTECTED_FILES_LENGTH;i++ )); do
    # Check the output for files that have been added to the working tree to see
    # if it contains any of the protected files
    changed_files_result=$(git diff --cached --name-only | grep ${PROTECTED_FILES[${i}]})
    if [[ $changed_files_result ]]; then
        echo
        echo "********************************************************************************"
        echo "You are trying to commit a change to ${PROTECTED_FILES[${i}]}, and this is not allowed."
        echo "********************************************************************************"
        echo

        exit 1
    fi
done
