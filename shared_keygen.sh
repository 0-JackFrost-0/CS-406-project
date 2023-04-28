#!/bin/bash

openssl pkeyutl -derive -inkey $1.priv -peerkey .repo/keys/$2.pub > shared.key
# echo $3 > plain.txt
skey="$(xxd -p shared.key)"
skey=$(echo $skey | sed 's/ //g')
rm shared.key
echo $skey
# openssl enc -aes-256-ctr -e -in plain.txt -out cipher.txt -K ${skey} -iv 0
# rm plain.txt