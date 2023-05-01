#!/bin/bash
if [[ -f .repo/top ]]
then
    checksum="$(sha1sum ./.repo/top)"
    IFS=' ' read -ra hash <<< "$checksum"
    if [[ -d .repo/snapshots/${hash:0:2} && -f .repo/snapshots/${hash:0:2}/${hash:2} ]]; then
        echo "Nothing to commit, Repository is up to date."
    else
        mkdir -p .repo/snapshots/${hash:0:2}
        touch .repo/snapshots/${hash:0:2}/${hash:2}
        cat .repo/top #>> .repo/snapshots/${hash:0:2}/${hash:2}
        IFS=' ' read -ra hash <<< "$checksum"
        echo "Committed with commit ID: "$hash
        touch .repo/commits/${hash}
        prev_com="$(cat .repo/commits/prev_com.txt)"
        echo "Previous commit ID: " $prev_com > .repo/commits/${hash}
        echo "Signed by: " $1 >> .repo/commits/${hash}
        cat .repo/top >> .repo/commits/${hash}
        echo ${hash} > .repo/commits/prev_com.txt

        # create a digital signature for the commit file
        openssl dgst -sha256 -sign priv_keys/$1.priv .repo/commits/$hash > .repo/signatures/$hash.sign
    fi 
fi