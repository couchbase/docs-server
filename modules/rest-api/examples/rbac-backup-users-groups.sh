#!/bin/sh
# Examples for the user and group backup endpoint at settings/rbac/backup


# Backup everything
# tag::backup-everything[]
curl -s -X GET -G -u Administrator:password \
    http://localhost:8091/settings/rbac/backup  > full.backup 
# end::backup-everything[]

# Backup all local users and  groups
# tag::backup-local-users-groups[]
 curl -s -X GET -G -u Administrator:password \
      http://localhost:8091/settings/rbac/backup \
      --data-urlencode 'include=group:*' \
      --data-urlencode 'include=user:local:*' > local-users-and-groups.backup 
# end::backup-local-users-groups[]

# Backup everything but admin (exclude=admin)
# tag::backup-all-but-admin[]
 curl -s -X GET -G -u Administrator:password \
      http://localhost:8091/settings/rbac/backup \
      --data-urlencode 'exclude=admin' > all-execept-admin.backup 
# end::backup-all-but-admin[]


# Backup only groups (include=group:*)
# tag::backup-only-groups[]
 curl -s -X GET -G -u Administrator:password \
      http://localhost:8091/settings/rbac/backup \
      --data-urlencode 'include=group:*' > only-groups.backup 
# end::backup-only-groups[]

# Backup all local users and admin (include=user:local:*&include=admin)
# tag::backup-local-user-and-admin[]
 curl -s -X GET -G -u Administrator:password \
      http://localhost:8091/settings/rbac/backup \
      --data-urlencode 'include=user:local:*' \
      --data-urlencode 'include=admin' > only-groups.backup 
# end::backup-local-user-and-admin[]



rm -f full_backup
# Save a backup to a file, then delete a user, then
# do a restore.
# tag::backup-delete-restore-user[]
curl -s -X GET -G -u Administrator:password \
     http://localhost:8091/settings/rbac/backup  > full_backup 

curl -X DELETE -u Administrator:password \
     http://localhost:8091/settings/rbac/users/local/user2

curl -X PUT  -u Administrator:password  \
     http://localhost:8091/settings/rbac/backup \
     --data-urlencode backup@full_backup | jq
# end::backup-delete-restore-user[]

# Result of running commands in previous example
:'
# tag::backup-delete-restore-user-output[]
{
  "stats": {
    "usersCreated": 1,
    "usersOverwritten": 0,
    "usersSkipped": 4,
    "groupsCreated": 0,
    "groupsOverwritten": 0,
    "groupsSkipped": 1
  },
  "usersSkipped": [
    {
      "name": "Administrator",
      "domain": "admin"
    },
    {
      "name": "user1",
      "domain": "local"
    },
    {
      "name": "user3",
      "domain": "local"
    },
    {
      "name": "exteruserA",
      "domain": "external"
    }
  ],
  "usersOverwritten": [],
  "groupsSkipped": [
    "stats_group"
  ],
  "groupsOverwritten": []
}
# end::backup-delete-restore-user-output[]
'

# Restore with overwrite
# tag::restore-overwrite[]
curl -s -X PUT -u Administrator:password \
     http://localhost:8091/settings/rbac/backup \
     --data-urlencode backup@full_backup \
     -d canOverwrite=true | jq
# end::restore-overwrite[]

:'
# tag::restore-overwrite-output[]
{
  "stats": {
    "usersCreated": 0,
    "usersOverwritten": 5,
    "usersSkipped": 0,
    "groupsCreated": 0,
    "groupsOverwritten": 1,
    "groupsSkipped": 0
  },
  "usersSkipped": [],
  "usersOverwritten": [
    {
      "name": "Administrator",
      "domain": "admin"
    },
    {
      "name": "user1",
      "domain": "local"
    },
    {
      "name": "user3",
      "domain": "local"
    },
    {
      "name": "user2",
      "domain": "local"
    },
    {
      "name": "exteruserA",
      "domain": "external"
    }
  ],
  "groupsSkipped": [],
  "groupsOverwritten": [
    "stats_group"
  ]
}
# end::restore-overwrite-output[]
'