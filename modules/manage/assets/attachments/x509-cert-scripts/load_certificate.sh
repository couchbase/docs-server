#!/usr/bin/env bash

set -e

ADMINCRED=Administrator:password
CLUSTER=${1:-192.168.33.10}
HOSTS=`curl -su ${ADMINCRED} http://${CLUSTER}:8091/pools/nodes | python -m json.tool | grep hostname | awk '{print substr($2, 2, length($2)-3)}'`
arr_hosts=( $HOSTS )
echo Hosts in the cluster: "${arr_hosts[*]}"
ROOT_CA=ca

echo Loop through nodes
for host in "${arr_hosts[@]}"
do
	ip=`echo $host|sed 's/\"\([^:]*\):.*/\1/'`
	echo "Setup Certificate for ${ip}"
	# Upload ROOT CA and activate it
	curl -s -o /dev/null --data-binary "@./${ROOT_CA}.pem" \
    	http://${ADMINCRED}@${ip}/controller/uploadClusterCA
	curl -sX POST http://${ADMINCRED}@${ip}/node/controller/reloadCertificate
	# Enable client cert
	POST_DATA='{"state": "enable","prefixes": [{"path": "subject.cn","prefix": "","delimiter": ""}]}'
	curl -sX POST -H "Content-Type: application/json" -d "${POST_DATA}" http://${ADMINCRED}@${ip}/settings/clientCertAuth
done