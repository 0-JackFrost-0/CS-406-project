#!/bin/bash

if [[ $# < 3 || $# > 3 ]]
then
    echo "format error ./commit.sh <repo-name> -m <message>"
else
    python3 commit.py $1 $3

#    if [[ -d ".repo" ]]
#    then
#        if [[ -d $1 ]]
#        then
#            backup_dir=$(date +'%m_%d_%Y')
#            # mkdir .repo/snapshots/$backup_dir
#            # rsync -r --exclude='.repo' ./$1 .repo/snapshots/$backup_dir
#            cd $1
#            for FILE in *; do
#                checksum="$(sha1sum $FILE)"
#                IFS=' ' read -ra hash <<< "$checksum"
#                mkdir ../.repo/snapshots/${hash:0:2}
#                touch ../.repo/snapshots/${hash:0:2}/${hash:2}
#                cp $FILE ../.repo/snapshots/${hash:0:2}/${hash:2}
#            done
#        else
#            echo "Repository Does Not exist"
#        fi
#
#    fi
fi  
