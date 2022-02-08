#!/bin/sh

# tag::index[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "CREATE PRIMARY INDEX ON bookings;",
  "query_context": "`travel-sample`.tenant_agent_00",
}'
# end::index[]

# tag::transaction[]
# tag::begin[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "BEGIN WORK",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txtimeout": "2m",
  "scan_consistency": "request_plus",
  "durability_level": "none"
}'
# end::begin[]

# tag::set[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::set[]

# tag::upsert[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "UPSERT INTO bookings VALUES(\"bf7ad6fa-bdb9-4099-a840-196e47179f03\", {
    \"date\": \"07/24/2021\",
    \"flight\": \"WN533\",
    \"flighttime\": 7713,
    \"price\": 964.13,
    \"route\": \"63986\"
});",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::upsert[]

# tag::savepoint-1[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "SAVEPOINT s1;",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::savepoint-1[]

# tag::update-1[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "UPDATE bookings AS b
    SET b.`user` = \"0\"
    WHERE META(b).id = \"bf7ad6fa-bdb9-4099-a840-196e47179f03\";",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::update-1[]

# tag::check-1[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "SELECT b.*, u.name
                FROM bookings b JOIN users u ON b.`user` = META(u).id
                WHERE META(b).id = \"bf7ad6fa-bdb9-4099-a840-196e47179f03\";",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::check-1[]

# tag::savepoint-2[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "SAVEPOINT s2;",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::savepoint-2[]

# tag::update-2[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "UPDATE bookings AS b
    SET b.`user` = \"1\"
    WHERE META(b).id = \"bf7ad6fa-bdb9-4099-a840-196e47179f03\";",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::update-2[]

# tag::check-2[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "SELECT b.*, u.name
                FROM bookings b JOIN users u ON b.`user` = META(u).id
                WHERE META(b).id = \"bf7ad6fa-bdb9-4099-a840-196e47179f03\";",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::check-2[]

# tag::rollback[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "ROLLBACK TRAN TO SAVEPOINT s2;",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::rollback[]

# tag::check-3[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "SELECT b.*, u.name
                FROM bookings b JOIN users u ON b.`user` = META(u).id
                WHERE META(b).id = \"bf7ad6fa-bdb9-4099-a840-196e47179f03\";",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::check-3[]

# tag::commit[]
curl http://localhost:8093/query/service \
-u Administrator:password \
-H 'Content-Type: application/json' \
-d '{
  "statement": "COMMIT TRANSACTION",
  "query_context": "`travel-sample`.tenant_agent_00",
  "txid": "d81d9b4a-b758-4f98-b007-87ba262d3a51"
}' # <1>
# end::commit[]
# end::transaction[]