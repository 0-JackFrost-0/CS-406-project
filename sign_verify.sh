#!/bin/bash

# verify the signature of a commit file, given the commit ID as $1, and the pubkey stored in .repo/keys 
# cd .repo/keys
out=""
for file in .repo/keys/*;
do
    if [[ -f $file && -f .repo/signatures/$1.sign ]]
    then
        # echo $file
        out="$(openssl dgst -sha256 -verify $file -signature .repo/signatures/$1.sign .repo/commits/$1)"
        if [[ $out == "Verified OK" ]]
        then
            echo "Signature verified"
            break
        fi
    fi
done
if [[ $out != "Verified OK" ]]
then
    echo "Signature not verified"
fi