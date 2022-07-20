result = cluster.query(
    """SELECT airportname, city
    FROM \`travel-sample\`.inventory.airport
    WHERE city=$1;""",
    'London', QueryOptions(adhoc=false))