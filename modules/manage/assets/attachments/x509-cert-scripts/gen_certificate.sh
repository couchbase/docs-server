#!/usr/bin/env bash

set -e

CHAIN=chain
INTERMEDIATE=int
NODE=pkey
ROOT_CA=ca
USERNAME=${1:-travel-sample}

echo Generate ROOT CA
# Generate ROOT CA
openssl genrsa -out ${ROOT_CA}.key 2048 2>/dev/null
openssl req -new -x509  -days 3650 -sha256 -key ${ROOT_CA}.key -out ${ROOT_CA}.pem \
-subj '/C=UA/O=My Company/CN=My Company Root CA' 2>/dev/null

echo Generate Intermediate
# Generate intemediate key and sign with ROOT CA
openssl genrsa -out ${INTERMEDIATE}.key 2048 2>/dev/null
openssl req -new -key ${INTERMEDIATE}.key -out ${INTERMEDIATE}.csr -subj '/C=UA/O=My Company/CN=My Company Intermediate CA' 2>/dev/null
openssl x509 -req -in ${INTERMEDIATE}.csr -CA ${ROOT_CA}.pem -CAkey ${ROOT_CA}.key -CAcreateserial \
-CAserial rootCA.srl -extfile v3_ca.ext -out ${INTERMEDIATE}.pem -days 365 2>/dev/null

# Generate client key and sign with ROOT CA and INTERMEDIATE KEY
echo Generate RSA
openssl genrsa -out ${NODE}.key 2048 2>/dev/null
openssl req -new -key ${NODE}.key -out ${NODE}.csr -subj "/C=UA/O=My Company/CN=${USERNAME}" 2>/dev/null
openssl x509 -req -in ${NODE}.csr -CA ${INTERMEDIATE}.pem -CAkey ${INTERMEDIATE}.key -CAcreateserial \
-CAserial intermediateCA.srl -out ${NODE}.pem -days 365 -extfile openssl-san.cnf -extensions 'v3_req'

# Generate certificate chain file
cat ${NODE}.pem ${INTERMEDIATE}.pem ${ROOT_CA}.pem > ${CHAIN}.pem