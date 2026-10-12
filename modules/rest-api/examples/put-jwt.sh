curl -X PUT -u Administrator:password \
     -H "Content-Type: application/json" \
     -d '{
           "enabled": true,
           "jwksUriRefreshIntervalS": 3600,
           "issuers": [
             {
               "name": "https://idp.example.com/realms/couchbase",
               "signingAlgorithm": "RS256",
               "publicKeySource": "jwks_uri",
               "jwksUri": "https://idp.example.com/realms/couchbase/protocol/openid-connect/certs",
               "jwksUriTlsVerifyPeer": false,
               "subClaim": "preferred_username",
               "audClaim": "aud",
               "audienceHandling": "any",
               "audiences": ["couchbase"]
             }
           ]
         }' \
     http://localhost:8091/settings/jwt
