function selectAirline(country) {

    var q = N1QL('SELECT * FROM `travel-sample`.`inventory`.`airline` WHERE country = $country');

    var res = [];

    for (const doc of q) {

        var airline = {}
        airline.name = doc.airline.name;
        airline.callsign = doc.airline.callsign
        res.push(airline);

    }

    return res;

}
