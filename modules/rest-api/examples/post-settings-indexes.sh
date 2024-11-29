# tag::gsi-settings[]
curl -v -X POST http://127.0.0.1:8091/settings/indexes \
-u Administrator:password \
-d indexerThreads=4 \
-d logLevel=verbose \
-d maxRollbackPoints=2 \
-d storageMode=plasma \
-d redistributeIndexes=false \
-d numReplica=0 \
-d enablePageBloomFilter=false
# end::gsi-settings[]

# tag::disable-ftb-rebalance[]
curl -X POST http://<host>:8091/settings/indexes -d enableShardAffinity=false -u Administrator:<password>
# end::disable-ftb-rebalance[]