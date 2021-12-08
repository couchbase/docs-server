# tag::defer[]
var bucketManager = bucket.CreateManager();
await bucketManager.CreateN1qlPrimaryIndexAsync(defer = true);
await bucketManager.CreateN1qlIndexAsync("ix_name", defer = true, new string[] { "name" });
await bucketManager.CreateN1qlIndexAsync("ix_email", defer = true, new string[] { "email" });
# end::defer[]

# tag::build[]
await bucketManager.BuildN1qlDeferredIndexesAsync();
await bucketManager.WatchN1qlIndexes(new List<string> { "ix_name", "ix_email", "#primary"}, TimeSpan.FromSeconds(2));
# end::build[]