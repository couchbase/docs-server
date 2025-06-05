from couchbase.cluster import Cluster
from couchbase.options import ClusterOptions 
from couchbase.auth import PasswordAuthenticator
from couchbase.management.collections import CollectionManager, CollectionSpec
from couchbase.exceptions import ScopeAlreadyExistsException, CollectionAlreadyExistsException

# Connect to source and target clusters
# Here, the target and source are the the same.
src_cluster = Cluster('couchbase://127.0.0.1', ClusterOptions(PasswordAuthenticator('Administrator', 'password')))
tgt_cluster = Cluster('couchbase://127.0.0.1', ClusterOptions(PasswordAuthenticator('Administrator', 'password')))
src_bucket = src_cluster.bucket('travel-sample')
tgt_bucket = tgt_cluster.bucket('travel-sample-1024')

src_coll_mgr = src_bucket.collections()
tgt_coll_mgr = tgt_bucket.collections()

# Get all scopes and their collections from source
scopes = src_coll_mgr.get_all_scopes()

for scope in scopes:
    scope_name = scope.name
    if scope_name.startswith('_'):
        continue # Skip system scopes
    # Create scope in target
    try:
        print(f"Creating scope: {scope_name}")
        tgt_coll_mgr.create_scope(scope_name)
    except ScopeAlreadyExistsException:
        pass
    except Exception as e:
        print(f"Error creating scope {scope_name}: {e}")
        exit(1)
    # Create collections in target
    for collection in scope.collections:
        try:
            print(f"Creating collection: {collection.name} in scope: {scope_name}")
            # tgt_coll_mgr.create_collection(CollectionSpec(collection.name, scope_name=scope_name))
            tgt_coll_mgr.create_collection(scope_name, collection.name)
        except CollectionAlreadyExistsException:
            pass
        except Exception as e:
            print(f"Error creating collection {collection.name} in scope {scope_name}: {e}")
            exit(1)
