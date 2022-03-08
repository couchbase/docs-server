curl -v http://node1-neo-testing-ubuntu18.vagrants:8093/query/service \
  -u Administrator:password \
  -d 'CREATE FUNCTION GetBusinessDays(startDate, endDate) LANGUAGE JAVASCRIPT AS "getBusinessDays" AT "my-library"'