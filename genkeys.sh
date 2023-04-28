#!/bin/bash

# generate ecdsa public and private keys, and store them in files

# generate private key
openssl ecparam -name secp256k1 -genkey -noout -out $1.priv
# adding a comment
# generate public key, without printing the anything on the screen
openssl ec -in $1.priv -pubout -out .repo/keys/$1.pub