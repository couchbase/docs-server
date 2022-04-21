function addAirlineWithCheck(id, name, callsign, country) {

    const full_id = "airline_" + id
    const d = new Date().toJSON();

    try {

        var q = insert into `travel-sample`.`inventory`.`airline` values(
            $full_id,
            {"id": $id,
                "type": "airline",
                "name": $name,
                "ca1": "Q5",
                "icao": "MLA",
                "callsign": $callsign,
                "country": $country,
                "opdate": $d});

        return "success"
    }
    catch (error) {
        const message = JSON.parse(error.message)    // <.>
        return message
    }

}