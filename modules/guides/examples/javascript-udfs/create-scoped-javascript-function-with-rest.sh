curl -v -X POST  'http://node1-neo-testing-ubuntu18.vagrants:8093/evaluator/v1/libraries/my-library?bucket=travel-sample&scope=inventory' \  #<.>
 -u Administrator:password \
 -d 'function getBusinessDays(startDate, endDate) {
          let count = 0;
          const curDate = new Date(new Date(startDate).getTime());
          while (curDate <= new Date(endDate)) {
              const dayOfWeek = curDate.getDay();
              if(dayOfWeek !== 0 && dayOfWeek !== 6)
                  count++;
              curDate.setDate(curDate.getDate() + 1);
          }
          return count;
      }' 
  