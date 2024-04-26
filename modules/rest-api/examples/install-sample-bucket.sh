curl -X POST -u Administrator:password \
     http://localhost:8091/sampleBuckets/install \
     -d '["travel-sample", "beer-sample"]' | jq .