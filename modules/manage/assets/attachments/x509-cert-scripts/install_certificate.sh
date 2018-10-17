#!/usr/bin/env bash

set -e

ADMINCRED=Administrator:password
CHAIN=chain
CLUSTER=${1:-192.168.33.10}
HOSTS=`curl -su ${ADMINCRED} http://${CLUSTER}:8091/pools/nodes | python -m json.tool | grep hostname | awk '{print substr($2, 2, length($2)-3)}'`
arr_hosts=( $HOSTS )
echo Hosts in the cluster: "${arr_hosts[*]}"
INBOX=/opt/couchbase/var/lib/couchbase/inbox/
NODE=pkey
ROOT_CA=ca
SSH="ssh -o StrictHostKeyChecking=no"
SSH_USER=${2:-vagrant}
SCP="scp -o StrictHostKeyChecking=no"

# loop through nodes
echo Get node IPs
hosts=`curl -su Administrator:password http://${CLUSTER}:8091/pools/nodes|jq '.nodes[].hostname'`
arr_hosts=( $hosts )
echo Loop through nodes
for host in "${arr_hosts[@]}"
do
	ip=`echo $host|sed 's/\"\([^:]*\):.*/\1/'`
	# Copy private key and chain file to a node:/opt/couchbase/var/lib/couchbase/inbox
	echo "Setup Certificate for ${ip}"
	${SSH} ${SSH_USER}@${ip} "sudo mkdir ${INBOX}" 2>/dev/null || true
	${SCP} chain.pem ${SSH_USER}@${ip}:chain.pem
	${SCP} pkey.key ${SSH_USER}@${ip}:pkey.key
	${SSH} ${SSH_USER}@${ip} "sudo mv chain.pem ${INBOX}${CHAIN}.pem"
	${SSH} ${SSH_USER}@${ip} "sudo mv pkey.key ${INBOX}${NODE}.key"
	${SSH} ${SSH_USER}@${ip} "sudo chmod a+x ${INBOX}${CHAIN}.pem"
	${SSH} ${SSH_USER}@${ip} "sudo chmod a+x ${INBOX}${NODE}.key"
done