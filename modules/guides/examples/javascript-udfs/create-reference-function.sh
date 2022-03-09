curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=CREATE FUNCTION GetBusinessDays(startDate, endDate) LANGUAGE JAVASCRIPT AS "getBusinessDays" AT "my-library"'