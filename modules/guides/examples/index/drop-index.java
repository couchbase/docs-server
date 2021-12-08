private void setup_dropIndexes() {
  try {
// tag::manager[]
    QueryIndexManager indexManager = cluster.queryIndexes();
// end::manager[]
// tag::primary[]
    indexManager.dropPrimaryIndex(bucketName);
// end::primary[]
// tag::secondary[]
    indexManager.dropIndex(bucketName, "ix_name");
// end::secondary[]
    indexManager.dropIndex(bucketName, "ix_email");
  } catch (IndexNotFoundException e) {
    System.out.println("No index to drop, carrying on...");
  }
}

await bucketManager.BuildN1qlDeferredIndexesAsync();
await bucketManager.WatchN1qlIndexes(new List<string> { "ix_name", "ix_email", "#primary"}, TimeSpan.FromSeconds(2));