#!/bin/bash

# give path relative to .repo

pth=$1
# root_pth=$(pwd)
root_pth=$2
#echo $pth
if [[ -d ".repo" ]]
then
    if [[ -d $1 ]]
    then
        fu=$(basename -- "$1")
        # echo $f
        touch "${root_pth}/.repo/$fu.txt"
        cd $1
        for FILE in *; do
            # echo $FILE
            if [[ -f $FILE ]]; then
                cd "$root_pth"
                output=$(bash "${root_pth}/blob.sh" $1/$FILE)
                cd "$root_pth/$1"
                # echo $root_pth
                # cd $1
                # echo $output
                echo "$output" >> "${root_pth}/.repo/$fu.txt"
                # echo $"\n" >> "${root_pth}/.repo/$fu.txt"
            elif [[ -d $FILE ]]; then
                # echo "YAYY" $FILE
                cd "$root_pth"
                # echo $(pwd)
                output=$(bash "${root_pth}/tree.sh" $1/$FILE "$root_pth")
                cd "$root_pth/$1"
                # touch waat.txt
                # echo $output >> waat.txt
                # IFS='\n' read -ra dir_hash <<< "$output"
                echo "$output" >> "${root_pth}/.repo/$fu.txt"
                # echo $"\n" >> "${root_pth}/.repo/$fu.txt"
                # :
            fi
        done
        cd "${root_pth}/.repo"
        tmp="$fu.txt"
        tchalla=$(sha1sum $tmp)
        IFS='    ' read -ra thsh <<< "$tchalla"
        # sha1sum $tmp
        # echo $thsh
        cd snapshots
        if [[ -d ${thsh:0:2} && -f ${thsh:0:2}/${thsh:2} ]]; then
#            echo "-1"
            echo "-t" $thsh $fu
            # echo "Directory already committed"
        else
            mkdir ${thsh:0:2}
            touch ${thsh:0:2}/${thsh:2}
            stuff=$(cat "$root_pth/.repo/$fu.txt")
            # echo $stuff >> "${thsh:0:2}/${thsh:2}"
            cat "$root_pth/.repo/$fu.txt" >> ${thsh:0:2}/${thsh:2}
            # cat "$root_pth/.repo/$fu.txt" >> wtf.txt
            # touch wtf.txt
            # echo $stuff $fu >> wtf.txt
            # cat $pth/../.repo/$1 >> ${thsh:0:2}/${thsh:2}
            echo "-t" $thsh $fu
            # echo "Directory new/updated"
        fi
        rm "${root_pth}/.repo/$fu.txt" 
    fi
fi
