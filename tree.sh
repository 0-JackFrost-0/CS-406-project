#!/bin/bash

# give path relative to .repo

pth=$(pwd)/$1
#echo $pth
if [[ -d ".repo" ]]
then
    if [[ -d $1 ]]
    then
        touch .repo/$1.txt
        cd $1
        for FILE in *; do
            if [[ -f $FILE ]]; then
                checksum="$(sha1sum $FILE)"
                IFS=' ' read -ra hash <<< "$checksum"
                cd ../.repo/snapshots/
                if [[ -d ${hash:0:2} && -f ${hash:0:2}/${hash:2}]]; then
                    echo "File already committed"
                else
                    echo "File updated/new"
                    ./blob.sh $pth/FILE
                fi
                echo $hash >> $pth/../.repo/$1.txt
            elif [[ -d $FILE]]; then
                output=$(./tree.sh $1/$FILE)
                IFS='\n' read -ra dir_hash <<< "$output"
                echo $dir_hash >> $pth/../.repo/$1.txt
            fi
        done
        cd $pth/../.repo
        tchksm="$(sha1sum $1.txt)"
        IFS=' ' read -ra thsh <<< "$tchcksm"
        cd snapshots
        if [[ -d ${thsh:0:2} && -f ${thsh:0:2}/${thsh:2}]]; then
#            echo "-1"
            echo $thsh
            echo "Directory already committed"
        else
            mkdir ${thsh:0:2}
            touch ${hash:0:2}/${hash:2}
            echo "-b" >> ${hash:0:2}/${hash:2}
            cat $pth/../.repo/$1 >> ${hash:0:2}/${hash:2}
            echo $thsh
            echo "Directory new/updated"
        fi
    fi
fi
