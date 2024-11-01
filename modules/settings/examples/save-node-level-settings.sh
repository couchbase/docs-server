#!/bin/sh

# tag::curl[]
curl http://localhost:8093/admin/settings -u user:pword -o ./query_settings.json
# end::curl[]