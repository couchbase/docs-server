#!/bin/bash

# Preliminary: need to change the RAM quota to at least 1GB for
# travel-sample bucket. First, make sure cluster has available RAM.
curl -X POST -u Administrator:password \
  http://localhost:8091/pools/default \
  -d 'memoryQuota=1248'

curl -X POST -u Administrator:password \
  http://localhost:8091/pools/default/buckets/travel-sample \
  -d 'ramQuota=1048'

# tag::change-backend[]
curl -X POST -u Administrator:password \
  http://localhost:8091/pools/default/buckets/travel-sample \
  -d 'storageBackend=magma'
# end::change-backend[]

# tag::get-backend[]
curl -s GET -u Administrator:password \
      http://localhost:8091/pools/default/buckets/travel-sample  \
      | jq '.storageBackend' 
# end::get-backend[]

# tag::get-node-overrides[]
curl GET -u Administrator:password \
    http://localhost:8091/pools/default/buckets/travel-sample \
    jq '.nodes[] | .hostname,.storageBackend'  
# end::get-node-overrides[]


# Graceful failover of node 3
# tag::failover-node[]
curl -X POST -u Administrator:password \
     http://localhost:8091/controller/startGracefulFailover \
     -d 'otpNode=ns_1@node3.'
# end::failover-node[]

# Full recovery of node 3
# tag::recover-node[]
curl -X POST -u Administrator:password \
    http://localhost:8091/controller/setRecoveryType \
    -d 'otpNode=ns_1@node3.' \
    -d 'recoveryType=full'
# end::recover-node[]

# Rebalance
# tag::rebalance-cluster[]
curl -X POST -u Administrator:password  \
    http://localhost:8091/controller/rebalance \
    -d 'knownNodes=ns_1@node1.,ns_1@node2.,ns_1@node3.'
# end::rebalance-cluster[]
