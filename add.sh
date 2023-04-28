#!/bin/bash

if [[ $# < 1 ]]
then
    echo 'Usage: ./add.sh <file/dir_name> ..'
else
    touch .repo/index.i
    for var in "$@"
    do
        echo $var >> .repo/index.i
#        echo '' >> .repo/index.i
    done
fi
# cat .repo/index.i
