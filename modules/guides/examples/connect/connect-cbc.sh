#!/usr/bin/env sh

# tag::cbc-connect[]
cbc ping -u Administrator -P password -U couchbase://localhost/travel-sample \
	--count=1 \
	--table
# end::cbc-connect[]

# tag::cbc-connect-cert[]
cbc ping -v -U "couchbases://127.0.0.1/travel-sample?certpath=ca.pem" \
	--count=1 \
	--table
# end::cbc-connect-cert[]

# tag::cbc-connect-capella[]
cbc ping -v -U "cb.<your endpoint address>.dp.cloud.couchbase.com/travel-sample?certpath=ca.pem" \
	--count=1 \
	--table
# end::cbc-connect-capella[]
