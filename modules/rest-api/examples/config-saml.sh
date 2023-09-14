# tag::get-saml[]
curl -s -u Administrator:password \
     http://localhost:8091/settings/saml | jq -S
# end::get-saml[]

curl -s -u Administrator:password http://localhost:8091/settings/saml | jq