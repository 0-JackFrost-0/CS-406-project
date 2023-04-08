#!/bin/bash
# command to use ./blob.sh <path_of_file_from_.repo>

if [[ -d ".repo" ]]
then
    if [[ -f $1 ]]
    then
            FILE=$1
            checksum="$(sha1sum $FILE)"
            IFS=' ' read -ra hash <<< "$checksum"
            if [[ -d .repo/snapshots/${hash:0:2} && -f .repo/snapshots/${hash:0:2}/${hash:2} ]]; then
                # echo "File already committed" $FILE
                :
            else
                mkdir .repo/snapshots/${hash:0:2}
                touch .repo/snapshots/${hash:0:2}/${hash:2}
                stuff=$(cat $FILE)
                echo $stuff  >> .repo/snapshots/${hash:0:2}/${hash:2}
            fi
            # IFS='/' read -ra path <<< "$FILE"
            f=$(basename -- "$FILE")
            echo "-b" $hash $f
            # cat $FILE >> ../.repo/snapshots/${hash:0:2}/${hash:2}
        
#        done
    else
        echo "File Does Not exist"
    fi
else
    echo "Not initialised yet."
    
fi
