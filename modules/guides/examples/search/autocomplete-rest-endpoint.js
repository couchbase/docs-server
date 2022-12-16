const Couchbase = require("couchbase");
const Express = require("express");
const Cors = require("cors");
 
var app = Express();
var cluster = new Couchbase.Cluster("${CB_HOSTNAME}");
cluster.authenticate("${CB_USERNAME", "${CB_PASSWORD}");
var bucket = cluster.openBucket("${CB_BUCKET}");
 
app.use(Cors());
 
app.get("/search", (request, response) => { });
 
app.listen(3000, () => {
    console.log("Listening at :3000...");
});

app.get("/search", (request, response) => {
    var SearchQuery = Couchbase.SearchQuery;
    var query = SearchQuery.new("idx-music", SearchQuery.match(request.query.query).fuzziness(1));
    query.fields(["title", "artist"]);
    bucket.query(query, function(error, result, meta) {
        if(error) {
            return response.status(500).send({ message: error.message });
        }
        result = result.map(item => {
            return {
                id: item.id,
                score: item.score,
                title: item.fields.title,
                artist: item.fields.artist
            };
        });
        response.send(result);
    });
});