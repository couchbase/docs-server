curl -X POST -u Administrator:password \
http://localhost:8091/settings/saml \
-d enabled=true \
-d idpMetadataTLSVerifyPeer=false \
-d idpMetadataURL=https://myidp.com/sso/saml/metadata \
-d spBaseURLScheme=http  \
-d spBaseURLType=node \
--data-urlencode spCertificate@mycertificate.crt 
--data-urlencode spKey@mykey.pem 
-d idpSignsMetadata=false

{
    "authnNameIDFormat": "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent",
    "enabled": true,
    "groupsAttribute": "",
    "groupsAttributeSep": " ,",
    "groupsFilterRE": ".*",
    "idpAuthnBinding": "post",
    "idpLogoutBinding": "post",
    "idpMetadataConnectAddressFamily": "undefined",
    "idpMetadataHttpTimeoutMs": 5000,
    "idpMetadataOrigin": "http",
    "idpMetadataRefreshIntervalS": 3600,
    "idpMetadataTLSCAs": "",
    "idpMetadataTLSExtraOpts": "[]",
    "idpMetadataTLSSNI": "",
    "idpMetadataTLSVerifyPeer": false,
    "idpMetadataURL": "https://myidp.com/sso/saml/metadata",
    "idpSignsMetadata": false,
    "rolesAttribute": "",
    "rolesAttributeSep": " ,",
    "rolesFilterRE": ".*",
    "singleLogoutEnabled": true,
    "spAssertionDupeCheck": "global",
    "spBaseURLScheme": "http",
    "spBaseURLType": "node",
    "spCertificate": "-----BEGIN CERTIFICATE-----\n
    ...
    \n-----END CERTIFICATE-----\n",
    "spChain": "",
    "spConsumeURL": "http://nodename.example.com:8091/saml/consume",
    "spContactEmail": "",
    "spContactName": "",
    "spEntityId": "",
    "spKey": "**********",
    "spLogoutURL": "http://nodename.example.com:8091/saml/logout",
    "spMetadataCacheDuration": "P1M",
    "spMetadataURL": "http://nodename.example.com:8091/saml/metadata",
    "spOrgDisplayName": "",
    "spOrgName": "",
    "spOrgURL": "",
    "spSessionExpire": "SessionNotOnOrAfter",
    "spSignMetadata": true,
    "spSignRequests": true,
    "spTrustedFingerprints": [],
    "spTrustedFingerprintsUsage": "metadataInitialOnly",
    "spVerifyAssertionEnvelopSig": true,
    "spVerifyAssertionSig": true,
    "spVerifyLogoutReqSig": true,
    "spVerifyRecipient": "consumeURL",
    "usernameAttribute": ""
}