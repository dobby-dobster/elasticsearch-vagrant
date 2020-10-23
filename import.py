#!/usr/local/bin/python
# 
# Small script to create an ES index called company and populate that index with some dummy data based on CSV.
#

from elasticsearch import helpers, Elasticsearch
import csv

es = Elasticsearch(
    ["192.168.100.11:9200", "192.168.100.12:9200"]
)

with open('/tmp/users.csv') as f:
    reader = csv.DictReader(f)
    helpers.bulk(es, reader, index='company', doc_type='users')
