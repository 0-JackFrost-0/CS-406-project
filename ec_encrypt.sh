#!/bin/bash


openssl enc -aes-256-ctr -e -in $2 -out cipher.bin -K $1 -iv 01020304050607080910111213141516
echo "cipher.bin"
