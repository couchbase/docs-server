# tag::primary[]
# TODO: Python example
mgr.create_primary_index('bucket_name', CreatePrimaryQueryIndexOptions(ignore_if_exists=True))
# tag::secondary[]
mgr.create_index('bucket_name', 'idx_foo', fields=['foo'])
# end::secondary[]