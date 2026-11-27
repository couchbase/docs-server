curl -s -u Administrator:password \
     http://localhost:8091/settings/jwt | jq -S

{
  "configEncryptionOverride": false,
  "enabled": true,
  "issuers": [
    {
      "audClaim": "aud",
      "audienceHandling": "any",
      "audiences": [
        "couchbase"
      ],
      "expiryLeewayS": 15,
      "groupsMapsStopFirstMatch": true,
      "jitProvisioning": false,
      "jwksUri": "https://idp.example.com/realms/couchbase/protocol/openid-connect/certs",
      "jwksUriHttpTimeoutMs": 5000,
      "jwksUriTlsCa": "",
      "jwksUriTlsVerifyPeer": false,
      "name": "https://idp.example.com/realms/couchbase",
      "publicKeySource": "jwks_uri",
      "rolesMapsStopFirstMatch": true,
      "signingAlgorithm": "RS256",
      "subClaim": "preferred_username"
    }
  ],
  "jwksUriRefreshIntervalS": 3600,
  "n2nEncryptionOverride": false
}
