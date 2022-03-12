curl -v http://node1-neo-testing-ubuntu18.vagrants:8093/query/service \
  -u Administrator:password \
  -d 'statement=EXECUTE FUNCTION GetBusinessDays("02/14/2022", "04/16/2022")'