function addAirline() {
    var q = N1QL("insert into airport values({\"id\": 1200, \"type\": \"airline\", \"name\": \"Couch Air\", \"ca1\": \"Q5\", \"icao\": \"MLA\", \"callsign\": \"COUCH-AIR\", \"country\": \"United States\"})")
}