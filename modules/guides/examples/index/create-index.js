// tag::primary[]
const indexMgr = cluster.queryIndexes();
await indexMgr.createPrimaryIndex('bucket_name')
// end::primary[]
// tag::secondary[]
await indexMgr.createIndex('bucket_name', 'ix_name', ['name'])
await indexMgr.createIndex('bucket_name', 'ix_email', ['email'])
// end::secondary[]