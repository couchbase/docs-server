// tag::primary[]
QueryIndexManager indexManager = cluster.queryIndexes();

indexManager.createPrimaryIndex(bucketName);
// end::primary[]
// tag::secondary[]
indexManager.createIndex(bucketName, "ix_name", Collections.singletonList("name"));
indexManager.createIndex(bucketName, "ix_email", Collections.singletonList("preferred_email"));
// end::secondary[]