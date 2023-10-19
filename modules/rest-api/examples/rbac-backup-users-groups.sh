#!/bin/sh
# Examples for the user and group backup endpoint at settings/rbac/backup


# Backup everything
# tag::backup-everything[]
curl -s -X GET -G -u Administrator:password \
    http://localhost:8091/settings/rbac/backup  | jq 
# end::backup-everything[]

# Ouput of the previous command
:'
# tag::backup-everything-output[]
{
  "version": "1",
  "admin": {
    "id": "Administrator",
    "auth": {
      "hash": {
        "hashes": [
          "u7FIfDrVhL7njSjpy/1+4T++81upA5WeTNqJkRnX4M8="
        ],
        "algorithm": "argon2id",
        "salt": "8wU/tRiYOYek8OCCmJsLYQ==",
        "time": 3,
        "memory": 8388608,
        "parallelism": 1
      },
      "scram-sha-512": {
        "salt": "9okpyrR+gX+CpA/I/NJT/05cpm7VSQoPJWi3/pgbyIudvRvzo2gYj4yUv8LtKLpw32ukrN+ShNN93gluB2bLtQ==",
        "iterations": 15000,
        "hashes": [
          {
            "stored_key": "UT0BBeGMZna1f0uk71qmjbB3bovZe/mnyB8YabxpayipNWiIYpfGlafipIpxCymgL5iitQBjXqvvzzCa84fZoQ==",
            "server_key": "6CYP4PiSvXdDGvydL1pzDaQBYbOZMtsJxZZ6DBHxsYB3bJGO6HSNXhhuWBDl5jv69aYDcd0SKcTAxuZRt1xNNQ=="
          }
        ]
      },
      "scram-sha-256": {
        "salt": "fX4KsSzoUHdhgoMbXNSnJNoHknaOfsjIexEahaBZsC8=",
        "iterations": 15000,
        "hashes": [
          {
            "stored_key": "DCMcirejatA95zvhn3T86N2OhzbuW1HDC+J39DpcBoA=",
            "server_key": "80iVSGpxlTfGYXNs6Qwyy3AHDvB4Dn2au7EXNi7guFw="
          }
        ]
      },
      "scram-sha-1": {
        "salt": "oXyt7opZ9PV8C3YQkCo0VIlbF6U=",
        "iterations": 15000,
        "hashes": [
          {
            "stored_key": "Rlmzrh8tD1OdC8Rfptx0YiSukoo=",
            "server_key": "W4z7Gx0lZrUprVyqvP5JBAdwWJc="
          }
        ]
      }
    }
  },
  "users": [
    {
      "id": "user1",
      "domain": "local",
      "groups": [
        "stats_group"
      ],
      "roles": [
        "ro_admin"
      ],
      "name": "User #1",
      "auth": {
        "hash": {
          "hashes": [
            "A6snHCrYGnaTn4fqxnneQgsOiGz5PC7UrVOmwNbKMxU="
          ],
          "algorithm": "argon2id",
          "salt": "lHGvPDKhmNxldH3TSMxLOw==",
          "time": 3,
          "memory": 8388608,
          "parallelism": 1
        },
        "scram-sha-512": {
          "salt": "6kR/BdHVQSNha7XLFbZKWL5jxlA6l+ixbR7/RR0CtJm02hoLqxFs2CrRX7JHzMyT3/B3XnqS+HruS30NPMqZug==",
          "iterations": 15000,
          "hashes": [
            {
              "stored_key": "WOojqnBVqnoCRrFGw5PHTUhDNGymg2IzJA375DT6BOmv2TbQiDb6xejXHCfxnM9cghRn26rlSQ/obMjproXIQw==",
              "server_key": "3bKgHVC5j/XR2bLd86nHxvxPkpsIbQXoym8skIcWCYA7QnfS9qn/rcrSeUsjrxMh+Ejz7AFmdJ8zwtBIwfyjyA=="
            }
          ]
        },
        "scram-sha-256": {
          "salt": "Xf3HYjbdtNDiUr1uY1blG90few+CgnPBvp1PnsUAVOk=",
          "iterations": 15000,
          "hashes": [
            {
              "stored_key": "AzzNJ5I1OJHEP07r83hPYT9CwYi+On6/HZz/7eZzQnM=",
              "server_key": "kD9GAirLYZpL+58v78PoifgJef2WlopOIEH2WVx6MZY="
            }
          ]
        },
        "scram-sha-1": {
          "salt": "cuK0x8diKxtYt38X+w9pjB4zJmU=",
          "iterations": 15000,
          "hashes": [
            {
              "stored_key": "DpLY9SReoJ0hCBHCRpO7Sg/BSf0=",
              "server_key": "Lke5RXuCHKwt6fxZ6U2xxsnB3q0="
            }
          ]
        }
      }
    },
    {
      "id": "exteruserA",
      "domain": "external",
      "groups": [
        "stats_group"
      ],
      "roles": [],
      "name": "External User A"
    }
  ],
  "groups": [
    {
      "name": "stats_group",
      "description": "",
      "roles": [
        "views_admin[travel-sample]",
        "data_writer[*]",
        "data_reader[travel-sample]",
        "eventing_admin",
        "backup_admin"
      ]
    }
  ]
}
# end::backup-everything-output[]
'

# Backup all local users and  groups
# tag::backup-local-users-groups[]
 curl -s -X GET -G -u Administrator:password \
      http://localhost:8091/settings/rbac/backup \
      --data-urlencode 'include=group:*' \
      --data-urlencode 'include=user:local:*' | jq 
# end::backup-local-users-groups[]

# Output of the above command
# Note: the :'....' is a multi-line comment in shell scripts.
:'
# tag::backup-local-users-groups-output[]
{
  "version": "1",
  "users": [
    {
      "id": "user1",
      "domain": "local",
      "groups": [
        "stats_group"
      ],
      "roles": [
        "ro_admin"
      ],
      "name": "Mr./Ms. User 1",
      "auth": {
        "hash": {
          "hashes": [
            "A6snHCrYGnaTn4fqxnneQgsOiGz5PC7UrVOmwNbKMxU="
          ],
          "algorithm": "argon2id",
          "salt": "lHGvPDKhmNxldH3TSMxLOw==",
          "time": 3,
          "memory": 8388608,
          "parallelism": 1
        },
        "scram-sha-512": {
          "salt": "6kR/BdHVQSNha7XLFbZKWL5jxlA6l+ixbR7/RR0CtJm02hoLqxFs2CrRX7JHzMyT3/B3XnqS+HruS30NPMqZug==",
          "iterations": 15000,
          "hashes": [
            {
              "stored_key": "WOojqnBVqnoCRrFGw5PHTUhDNGymg2IzJA375DT6BOmv2TbQiDb6xejXHCfxnM9cghRn26rlSQ/obMjproXIQw==",
              "server_key": "3bKgHVC5j/XR2bLd86nHxvxPkpsIbQXoym8skIcWCYA7QnfS9qn/rcrSeUsjrxMh+Ejz7AFmdJ8zwtBIwfyjyA=="
            }
          ]
        },
        "scram-sha-256": {
          "salt": "Xf3HYjbdtNDiUr1uY1blG90few+CgnPBvp1PnsUAVOk=",
          "iterations": 15000,
          "hashes": [
            {
              "stored_key": "AzzNJ5I1OJHEP07r83hPYT9CwYi+On6/HZz/7eZzQnM=",
              "server_key": "kD9GAirLYZpL+58v78PoifgJef2WlopOIEH2WVx6MZY="
            }
          ]
        },
        "scram-sha-1": {
          "salt": "cuK0x8diKxtYt38X+w9pjB4zJmU=",
          "iterations": 15000,
          "hashes": [
            {
              "stored_key": "DpLY9SReoJ0hCBHCRpO7Sg/BSf0=",
              "server_key": "Lke5RXuCHKwt6fxZ6U2xxsnB3q0="
            }
          ]
        }
      }
    }
  ],
  "groups": [
    {
      "name": "stats_group",
      "description": "",
      "roles": [
        "views_admin[travel-sample]",
        "data_writer[*]",
        "data_reader[travel-sample]",
        "eventing_admin",
        "backup_admin"
      ]
    }
  ]
}
# end::backup-local-users-groups-output[]
'


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