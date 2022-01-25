#!/bin/sh

# tag::query[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "UPDATE `travel-sample`.inventory.hotel
                SET price = \"from £89\"
                WHERE name = \"Glasgow Grand Central\";",
  "tximplicit": true
}'
# end::query[]