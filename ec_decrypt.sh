#!/bin/bash

openssl enc -aes-256-ctr -d -in $2 -out decrypt.txt -K $1 -iv 01020304050607080910111213141516
echo "decrypt.txt"

