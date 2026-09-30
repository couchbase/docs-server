# Enable for travel-sample
# tag::enable-travel-sample[]
curl -X POST node1.example.com:8091/pools/default/buckets/travel-sample \
     -u $USERNAME:$PASSWORD \
     -d continuousBackupEnabled=true \
     -d continuousBackupLocation="/shared/continuous-backup" \
     -d continuousBackupInterval=10
# end::enable-travel-sample[]

# Get information about the continuous backup location
# tag::get-backup-info[]
cbcontbk info -l /shared/continuous-backup/
# end::get-backup-info[]

# Restore the bucket
# tag::restore-bucket[]
cbcontbk restore --target 2026-06-08T19:54:10Z \
         -u $USERNAME -p $PASSWORD \
         --tmp-dir /scratch \
         -l /shared/continuous-backup/ \
         -a /shared/backups \
         -r 1c48c43c-45b8-4155-8352-7d21523b2603 \
         -c couchbase://node3.example.com
# end::restore-bucket[]

