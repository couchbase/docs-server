function addAirlineWithPositionalParameters(name, callsign, country) {
    var q = N1QL("insert into `travel-sample`.`inventory`.`airport` values(\"1600\", " +
        "{\"id\": $1, " +
        "\"type\": $2, " +
        "\"name\": $3, " +
        "\"ca1\": $4, " +
        "\"icao\": $5, " +
        "\"callsign\": $6, " +
        "\"country\": $7})", 
        [1600, "airline", name, "Q5", "MLA", callsign, country])
}