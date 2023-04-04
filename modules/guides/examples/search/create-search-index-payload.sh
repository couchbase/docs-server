curl -s -XPUT -H "Content-Type: application/json" \
-u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/index/landmark-content-index 
-d \
'{
    "type": "fulltext-index",
    "name": "landmark-content-index",
    "sourceType": "gocbcore",
    "sourceName": "travel-sample",
    "planParams": {
      "maxPartitionsPerPIndex": 1024,
      "indexPartitions": 1
    },
    "params": {
      "doc_config": {
        "docid_prefix_delim": "",
        "docid_regexp": "",
        "mode": "scope.collection.type_field",
        "type_field": "type"
      },
      "mapping": {
        "analysis": {},
        "default_analyzer": "standard",
        "default_datetime_parser": "dateTimeOptional",
        "default_field": "_all",
        "default_mapping": {
          "dynamic": true,
          "enabled": false
        },
        "default_type": "_default",
        "docvalues_dynamic": false,
        "index_dynamic": true,
        "store_dynamic": false,
        "type_field": "_type",
        "types": {
          "inventory.landmark": {
            "dynamic": false,
            "enabled": true,
            "properties": {
              "content": {
                "dynamic": false,
                "enabled": true,
                "fields": [
                  {
                    "docvalues": true,
                    "include_in_all": true,
                    "include_term_vectors": true,
                    "index": true,
                    "name": "content",
                    "store": true,
                    "type": "text"
                  }
                ]
              }
            }
          }
        }
      },
      "store": {
        "indexType": "scorch",
        "segmentVersion": 15
      }
    },
    "sourceParams": {}
  }'