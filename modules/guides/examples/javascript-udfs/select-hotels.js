function selectHotels() {
    
    var q = SELECT * FROM `travel-sample`.`inventory`.`hotel` LIMIT 1;    // <.>
    var res = [];

    for (const doc of q) {   // <.>
        
        res.push(doc);      // <.>
        
    }
    
    return res;    // <.>
    
}