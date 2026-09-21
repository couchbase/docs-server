curl -X PUT -u Administrator:password \
     -H "Content-Type: application/json" \
     -d '{
           "enabled": true,
           "issuers": [
             {
               "name": "https://idp.example.com/realms/couchbase",
               "displayName": "Example Sign-In",
               "signingAlgorithm": "RS256",
               "publicKeySource": "jwks_uri",
               "subClaim": "preferred_username",
               "audClaim": "aud",
               "audienceHandling": "any",
               "audiences": ["couchbase"],
               "oidcSettings": {
                 "clientId": "couchbase-console",
                 "clientSecret": "REPLACE_WITH_YOUR_CLIENT_SECRET",
                 "endpointSource": "discovery",
                 "oidcDiscoveryUri": "https://idp.example.com/realms/couchbase/.well-known/openid-configuration",
                 "baseRedirectUris": ["https://console.example.com:18091"],
                 "scopes": ["openid", "profile", "email"]
               }
             }
           ]
         }' \
     http://localhost:8091/settings/jwt
