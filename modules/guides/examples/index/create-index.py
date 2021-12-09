# tag::primary[]
mgr.create_primary_index('bucket_name')
# end::primary[]
# tag::secondary[]
mgr.create_index('bucket_name', 'idx_foo', fields=['foo'])
# end::secondary[]