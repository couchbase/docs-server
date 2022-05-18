function addAirlineWithNamedParameters(name, callsign, country) {
    var q = insert into `travel-sample`.`inventory`.`airport` values("1700", 
        {"id": 1700, 
            "type": "airline", 
            "name": $name, 
            "ca1": "Q5", 
            "icao": "MLA", 
            "callsign": $callsign, 
            "country": $country});
}