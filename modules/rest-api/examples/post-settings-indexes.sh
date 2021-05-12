curl -v -X POST -u Administrator:password \
http://localhost:8091/settings/indexes \
-d indexerThreads=4 \
-d logLevel=verbose \
-d maxRollbackPoints=10 \
-d storageMode=plasma \
-d memorySnapshotInterval=150 \
-d stableSnapshotInterval=40000