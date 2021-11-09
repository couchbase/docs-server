#!/usr/bin/env sh

# tag::cbc-simple-insert[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--mode insert airport-123 <./tmp/airport-123.json
# end::cbc-simple-insert[]

# tag::cbc-simple-get[]
cbc cat -u Administrator -P password -U couchbase://localhost/travel-sample airport-123
# end::cbc-simple-get[]

# tag::cbc-simple-update[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--mode replace airport-123 <./tmp/airport-123.json
# end::cbc-simple-update[]

# tag::cbc-simple-delete[]
cbc rm -u Administrator -P password -U couchbase://localhost/travel-sample airport-123
# end::cbc-simple-delete[]

# tag::cbc-kv-insert[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='airport' \
	--mode insert airport-123 <./tmp/airport-123.json
# end::cbc-kv-insert[]

# tag::cbc-kv-insert-expiry[]
cbc create -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='airport' \
	--mode insert airport-456 \
	--expiry 60 <./tmp/airport-456.json
# end::cbc-kv-insert-expiry[]

# tag::cbc-kv-get[]
cbc cat airport-123 -u Administrator -P password -U couchbase://localhost/travel-sample \
	--scope='inventory' \
	--collection='airport'
# end::cbc-kv-get[]

# tag::cbc-subdoc-get[]
echo "get airport_1254 --path geo" |
	cbc-subdoc -u Administrator -P password -U couchbase://localhost/travel-sample
# end::cbc-subdoc-get[]
