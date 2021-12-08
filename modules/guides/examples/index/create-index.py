# tag::primary[]
var bucketManager = bucket.CreateManager();
await bucketManager.CreateN1qlPrimaryIndexAsync();
# end::primary[]
# tag::secondary[]
await bucketManager.CreateN1qlIndexAsync("index_name", new string[] { "name" });
await bucketManager.CreateN1qlIndexAsync("index_email", new string[] { "email" });
# end::secondary[]