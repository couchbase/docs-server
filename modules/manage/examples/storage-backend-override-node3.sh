curl -s GET -u Administrator:password \
    http://localhost:8091/pools/default/buckets/travel-sample \
    jq '.nodes[] | .hostname,.storageBackend'  

"node3.:8091"
null
"node2.:8091"
"couchstore"
"node1.:8091"
"couchstore"
