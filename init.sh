#!/bin/bash

# Write your init script here.
if [[ $# != 1 ]]
then
    echo "format error: './init.sh <dir_name>'"  
else
     if [ -d $1 ];
    then
        echo "Directory already exists"
    else
        mkdir $1
        if [ -d ".repo" ];
        then
            echo "Already initialised"
        else
            mkdir -p .repo/refs/tags
            mkdir -p .repo/snapshots
            mkdir -p .repo/commits
            mkdir -p .repo/signatures
            mkdir -p .repo/keys
            touch .repo/commits/prev_com.txt
        fi
    fi
fi

