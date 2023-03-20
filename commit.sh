#!/bin/bash

if [[ $# != 1 ]]
then
    echo "format error ./commit.sh <repo_name>"
else 
    if [[ -d ".repo" ]]
    then
        if [[ -d $1 ]]
        then
            backup_dir=$(date +'%m_%d_%Y')
            mkdir .repo/snapshots/$backup_dir
            rsync -r --exclude='.repo' ./$1 .repo/snapshots/$backup_dir
        else 
            echo "Repository Does Not exist"
        fi

    fi
fi  