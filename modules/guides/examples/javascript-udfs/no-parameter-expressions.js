const d = new Date()

var q = insert into `travel-sample`.`inventory`.`airline` values(
    $full_id,
    {"id": $id,
        "type": "airline",
        "name": $name,
        "ca1": "Q5",
        "icao": "MLA",
        "callsign": $callsign,
        "country": $country,
        "opdate": $d.toJSON()});    // <.>