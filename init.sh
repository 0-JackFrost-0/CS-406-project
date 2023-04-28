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
            mkdir .repo/snapshots
            mkdir .repo/commits
            mkdir .repo/signatures
            mkdir .repo/keys
            touch .repo/commits/prev_com.txt
        fi
    fi
fi

