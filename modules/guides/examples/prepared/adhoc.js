async function queryNamed() {
  const query = `
  SELECT airportname, city FROM \`travel-sample\`.inventory.airport
  WHERE city=$1
  `;
  var options = { adhoc: false, parameters: ['London'] }

  try {
    let result = await cluster.query(query, options)
    console.log("Result:", result)
    return result
  } catch (error) {
    console.error('Query failed: ', error)
  }
}