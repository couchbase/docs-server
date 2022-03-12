curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=CREATE FUNCTION default:`travel-sample`.inventory.GetBusinessDays(...) #<.>
  LANGUAGE JAVASCRIPT as "getBusinessDays" AT "travel-sample/inventory/my-library"' #<.>