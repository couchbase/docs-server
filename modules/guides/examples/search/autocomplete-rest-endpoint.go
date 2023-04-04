package main
 
import (
 "encoding/json"
 "net/http"
 
 "github.com/gorilla/handlers"
 "github.com/gorilla/mux"
 gocb "gopkg.in/couchbase/gocb.v1"
 "gopkg.in/couchbase/gocb.v1/cbft"
)
 
type Song struct {
 Id     string  `json:"id"`
 Score  float64 `json:"score"`
 Artist string  `json:"artist"`
 Title  string  `json:"title"`
}
 
var bucket *gocb.Bucket
 
func SearchEndpoint(response http.ResponseWriter, request *http.Request) { }
 
func main() {
 cluster, _ := gocb.Connect("${CB_HOSTNAME}")
 cluster.Authenticate(gocb.PasswordAuthenticator{Username: "${CB_USERNAME}", Password: "${CB_PASSWORD}"})
 bucket, _ = cluster.OpenBucket("example", "")
 router := mux.NewRouter()
 router.HandleFunc("/search", SearchEndpoint).Methods("GET")
 http.ListenAndServe(":12345", handlers.CORS(handlers.AllowedHeaders([]string{"X-Requested-With", "Content-Type", "Authorization"}), handlers.AllowedMethods([]string{"GET", "POST", "PUT", "HEAD", "OPTIONS"}), handlers.AllowedOrigins([]string{"*"}))(router))
}

response.Header().Set("content-type", "application/json")
 params := request.URL.Query()
 query := gocb.NewSearchQuery("idx-music", cbft.NewMatchQuery(params.Get("query")))
 query.Fields("artist", "title")
 result, _ := bucket.ExecuteSearchQuery(query)
 var hits []Song
 for _, hit := range result.Hits() {
 hits = append(hits, Song{
 Id:     hit.Id,
 Score:  hit.Score,
 Artist: hit.Fields["artist"],
 Title:  hit.Fields["title"],
 })
 }
 json.NewEncoder(response).Encode(hits)
}