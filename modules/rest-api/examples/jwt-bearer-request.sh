# Fetch a token from the identity provider, then use it to call Couchbase Server.
TOKEN=$(curl -s -X POST \
             -d "client_id=couchbase" \
             -d "username=test_user" \
             -d "password=password" \
             -d "grant_type=password" \
             https://idp.example.com/realms/couchbase/protocol/openid-connect/token \
        | jq -r .access_token)

curl -s -H "Authorization: Bearer $TOKEN" \
     https://localhost:18091/pools/default | jq -S
