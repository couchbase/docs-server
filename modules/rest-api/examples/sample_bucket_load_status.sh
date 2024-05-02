#!/bin/bash

echo -e "Executing command:\ncurl -s -X POST -u Administrator:password http://node1:8091/sampleBuckets/install -d '[\"travel-sample\", \"beer-sample\"]'"

taskIds=$(curl -s -X POST -u Administrator:password http://node1:8091/sampleBuckets/install -d '["travel-sample", "beer-sample"]' \
        | jq . | tee install_output.json | jq '.tasks[] | .taskId' | tr -d '"' )

cat install_output.json

echo -e "\ntaskIds: $taskIds\n\n"

sleep 2

echo -e\n\nFull task list:

curl -s -u  Administrator:password  -X GET  http://localhost:8091/pools/default/tasks | jq 

for id in ${taskIds}; do
    echo -e "\ntaskId: $id"
    echo "Running command: curl -s -u Administrator:password  -G http://localhost:8091/pools/default/tasks -d \"taskId=$id\" | jq '.' "
    curl -s -u Administrator:password  -G http://localhost:8091/pools/default/tasks -d "taskId=$id" | jq '.' 
done
