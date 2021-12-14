#!/usr/bin/env sh

# tag::cbc-kv-insert[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='hotel' \
	--mode insert hotel-123 <./tmp/hotel-123.json
# end::cbc-kv-insert[]

# tag::cbc-kv-insert-expiry[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='hotel' \
	--mode insert hotel-456 \
	--expiry 60 <./tmp/hotel-456.json
# end::cbc-kv-insert-expiry[]

# tag::cbc-kv-get[]
cbc cat hotel-123 -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='hotel'
# end::cbc-kv-get[]

# tag::cbc-kv-get-with-opts[]
cbc cat hotel-123 -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='hotel' \
	--expiry=60
# end::cbc-kv-get-with-opts[]

# tag::cbc-kv-upsert[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='hotel' \
	--mode upsert hotel-123 <./tmp/hotel-123.json
# end::cbc-kv-upsert[]

# tag::cbc-kv-replace[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='hotel' \
	--mode replace hotel-123 <./tmp/hotel-123.json
# end::cbc-kv-replace[]

# tag::cbc-kv-delete[]
cbc rm -u Administrator -P password -U couchbase://localhost/travel-sample airport_1254
# end::cbc-kv-delete[]

# tag::cbc-bulk-get[]
cbc cat -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='tenant_agent_00' \
	--collection='users' \
	0 1
# end::cbc-bulk-get[]
