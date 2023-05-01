#!/bin/bash

# generate ecdsa public and private keys, and store them in files

# generate private key
if [[ -d priv_keys ]]; then
:
else
    mkdir priv_keys
fi
# mkdir priv_keys
openssl ecparam -name secp256k1 -genkey -noout -out priv_keys/$1.priv
# adding a comment
# generate public key, without printing the anything on the screen
openssl ec -in priv_keys/$1.priv -pubout -out .repo/keys/$1.pub