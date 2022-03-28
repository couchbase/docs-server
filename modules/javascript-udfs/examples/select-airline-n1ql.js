function selectAirline(country) {

    var q = N1QL('SELECT name as airline_name, ' +
        'callsign as airline_callsign FROM `travel-sample`.`inventory`.`airline` ' +
        'WHERE country = $country_param', {country_param: country}); // <1>

    var res = [];

    for (const doc of q) {

        var airline = {}
        airline.name = doc.airline_name; // <2>
        airline.callsign = doc.airline_callsign // <2>
        res.push(airline);

    }

    return res;

}
