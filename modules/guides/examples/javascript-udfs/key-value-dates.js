var a = [] 

a.push("London")  
a.push(100)
a.push("Los Angeles")
a.push("Tokyo")
a.push(200)

var kv = {}     

kv.airline = "COUCH AIR"    
kv.coverage = a                 
kv.home_airport = "Heathrow"   

kv.date_established = new Date().toJSON()    // <.>

console.log(JSON.stringify(kv)) 

console.log(JSON.stringify(kv.coverage))  
console.log(JSON.stringify(kv["home_airport"])) 