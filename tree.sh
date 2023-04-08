#!/bin/bash

# give path relative to .repo

pth=$(pwd)/$1
root_pth=$(pwd)
#echo $pth
if [[ -d ".repo" ]]
then
    if [[ -d $1 ]]
    then
        touch .repo/$1.txt
        cd $1
        for FILE in *; do
            if [[ -f $FILE ]]; then
                # checksum="$(sha1sum $FILE)"
                # IFS=' ' read -ra hash <<< "$checksum"
                # cd ../.repo/snapshots/
                # if [[ -d ${hash:0:2} && -f ${hash:0:2}/${hash:2} ]]; then
                #     # echo "File already committed" $FILE
                #     continue
                # else
                #     # echo "File updated/new" $FILE
                #     ./blob.sh $pth/FILE
                # fi
                # echo "-b" $hash $FILE >> "${root_pth}/.repo/$1.txt"
                sh ./blob.sh $1/$FILE
                # output=$(./blob.sh $1/$FILE)
                # IFS='\n' read -ra dir_hash <<< "$output"
                echo "-b" $output $FILE >> "${root_pth}/.repo/$1.txt"
            elif [[ -d $FILE ]]; then
                output=$(./tree.sh $1/$FILE)
                # IFS='\n' read -ra dir_hash <<< "$output"
                echo "-t" $output $FILE >> "${root_pth}/.repo/$1.txt"
            fi
        done
        cd "${root_pth}/.repo"
        tmp="$1.txt"
        tchalla=$(sha1sum $tmp)
        IFS='    ' read -ra thsh <<< "$tchalla"
        # sha1sum $tmp
        # echo $thsh
        cd snapshots
        if [[ -d ${thsh:0:2} && -f ${thsh:0:2}/${thsh:2} ]]; then
#            echo "-1"
            echo "-t" $thsh $1
            # echo "Directory already committed"
        else
            mkdir ${thsh:0:2}
            touch ${thsh:0:2}/${thsh:2}
            stuff=$(cat "$pth/../.repo/$1.txt")
            echo $stuff >> "${thsh:0:2}/${thsh:2}"
            # cat $pth/../.repo/$1 >> ${thsh:0:2}/${thsh:2}
            echo "-t" $thsh $1
            # echo "Directory new/updated"
        fi
        rm "$pth/../.repo/$1.txt"
    fi
fi
