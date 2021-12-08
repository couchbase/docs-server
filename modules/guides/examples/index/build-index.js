// tag::defer[]
const indexMgr = cluster.queryIndexes();
await indexMgr.createPrimaryIndex('bucket_name', {deferred: true})
await indexMgr.createIndex('bucket_name', 'ix_name', ['name'], {deferred: true})
await indexMgr.createIndex('bucket_name', 'ix_email', ['email'], {deferred: true})
// end::defer[]

// tag::build[]
await indexMgr.buildDeferredIndexes('bucket_name')
await indexMgr.watchIndexes('bucket_name', ['ix_name', 'ix_email', '#primary'], 2000)
// end::build[]