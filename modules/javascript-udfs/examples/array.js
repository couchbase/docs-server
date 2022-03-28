
var a = []    // <.>

a.push("London")  // <.>
a.push(100)    // <.>
a.push("Los Angeles")
a.push("Tokyo")
a.push(200)
    
console.log(JSON.stringify(a))   // <.>

console.log(JSON.stringify(a[2]))   // <.>