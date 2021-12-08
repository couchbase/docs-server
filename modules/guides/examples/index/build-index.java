// tag::defer[]
QueryIndexManager indexManager = cluster.queryIndexes();

indexManager.createPrimaryIndex(bucketName,
    CreatePrimaryQueryIndexOptions.createPrimaryQueryIndexOptions().deferred(true));
indexManager.createIndex(bucketName, "ix_name", Collections.singletonList("name"),
    CreateQueryIndexOptions.createQueryIndexOptions().deferred(true));
indexManager.createIndex(bucketName, "ix_email", Collections.singletonList("preferred_email"),
    CreateQueryIndexOptions.createQueryIndexOptions().deferred(true));
// end::defer[]

// tag::build[]
indexManager.buildDeferredIndexes(bucketName);
indexManager.watchIndexes(bucketName, Arrays.asList("ix_name", "ix_email"), Duration.ofMinutes(5));
// end::build[]