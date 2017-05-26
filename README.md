# Elastic Search applied to Ruby on Rails

---

## Elastic Search concepts

## Retrieving data and performing CRUD operations via CURL

## Bulk API

## Gem Alternatives

- **Searchkick:** recommended for simpler solutions such as search inside a single entity.
- **Chewy:** Recommended for more advanced and combined with the right abstraction, make it a maintainable solution.

## Include API related best practices


- Open Source search server based on Apache Lucene
- Written in Java
- Cross-platform
- Big focus on scalability - distributed architecture from the ground up
- Designed to take data from any source, analyze it and search through it. make it searchable.

- Communication with the search server is done through a HTTP REST API
curl -X <REST VERB> <NODE>:<PORT>/<INDEX>/<TYPE>/<ID>

- Schema-less JSON documents (like NoSQL databases)
- Near real-time search. 1 or 2 seconds till is distributed to all clusters NRT
- Netflix, Stack Exchange, Foursquare, Mozilla, StumbleUpon

NRT: At the time one makes a change to an index, this change is propagated to the cluster taking like 1 or 2 seconds. It is due to its distributed architecture that makes the search engine scalable.

Cluster: is a collection of one or more nodes. Can contain as many nodes as you want. The cluster provides indexing and search capabilities across all the nodes.
Node: a single server that is part of a cluster. Stores searchable data. Contains a subset of a cluster's data. When search is performed, nodes collaborates on completing the search.
Index: a collection of documents (movie, product, user, review). The examples would be a type. Index is like a database within a Relational Database. Identified by lowercased name, used when performing CRUD operations within the index.
Type: represents a Class/Category of similar documents. e.g: "user". Consists of a name and a mapping.
