
# tag::change-ejection-no-restart[]
curl -v -X POST http://localhost:8091/pools/default/buckets/travel-sample \
     -u Administrator:password \
     -d evictionPolicy="fullEviction" \
     -d noRestart=true
# end::change-ejection-no-restart[]

# tag::show-policy-overrides[]
curl -s GET -u Administrator:password \
    http://localhost:8091/pools/default/buckets/travel-sample \
    | jq '[ .nodes[] | { (.hostname): .evictionPolicy }] + [{ (.name): .evictionPolicy }]'
# end::show-policy-overrides[]
 
# Get the current ejection policy
# tag::get-ejection-policy[]
curl -s GET -u Administrator:password \
      http://localhost:8091/pools/default/buckets/travel-sample  \
      | jq '.evictionPolicy' 
# end::get-ejection-policy[]

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

