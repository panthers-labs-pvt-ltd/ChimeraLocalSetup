# Progress Minds Developer tools

## OpenVSCode Server

OpenVSCodeServer helps run upstream VS Code on a remote machine with access through a modern web browser from any device, anywhere. It is an offering from [GitPod](https://www/gitpod.io). More to follow.

## Minikube

```shell
# initiate minikube. It would download all the images that it needs to initiate.
$ minikube start
# It enables addons storage-provisioner, default-storageclass
# You should note when it says " Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default"

# You need to enable dashboard and metrics-server to monitor what is going on.
$ minikube addons enable dashboard
$ minikube addons enable metrics-server
$ minikube dashboard # it is open a url where the dashboard is targeted. You may need to copy and paste in Windows browser.
```

### K8S Ecosystem

- Helm
- Apache Yunikorn

## Deno

Deno (/ˈdiːnoʊ/, pronounced dee-no) is an open source JavaScript, TypeScript, and WebAssembly runtime with secure defaults and a great developer experience. It's built on V8, Rust, and Tokio.

## MinIO

## Polars

[Polars](https://pola.rs/) is a blazingly fast DataFrame library for manipulating structured data, known for being one of the fastest data processing solutions on a single machine. It features a well-structured, typed API that is both expressive and easy to use. The core is written in Rust, and available for Python, R and NodeJS.

## Apache Kakfa

Apache Kafka® is an event streaming platform. Kafka has capability to:

1. To **publish** (write) and **subscribe** to (read) streams of events, including continuous import/export of your data from other systems.
2. To **store** streams of events durably and reliably for as long as you want.
3. To **process** streams of events as they occur or retrospectively.
And all this functionality is provided in a distributed, highly scalable, elastic, fault-tolerant, and secure manner. Kafka can be deployed on bare-metal hardware, virtual machines, and containers, and on-premises as well as in the cloud.

In **Chimera**, we will use KRaft mode since Zookeeper is being deprecated. This is new, so I recommend people to read through the [Kraft documentation](https://kafka.apache.org/documentation/#kraft)

## Ray

An open source framework to build and scale your ML and Python applications easily. Ray can used for batch inferencing, model training, hyperparameter tuning, model serving, reinforcement learning, and more.

## Apache Spark

## Apache Flink

## Apache Storm

Apache Storm is a free and open source distributed realtime computation system. Apache Storm makes it easy to reliably process unbounded streams of data, doing for realtime processing what Hadoop did for batch processing. Apache Storm is simple, can be used with any programming language, and is a lot of fun to use!

Apache Storm has many use cases: realtime analytics, online machine learning, continuous computation, distributed RPC, ETL, and more. Apache Storm is fast: a benchmark clocked it at over a million tuples processed per second per node. It is scalable, fault-tolerant, guarantees your data will be processed, and is easy to set up and operate.

Apache Storm integrates with the queueing and database technologies you already use. An Apache Storm topology consumes streams of data and processes those streams in arbitrarily complex ways, repartitioning the streams between each stage of the computation however needed.

## RocksDB

RocksDB is an embeddeable persistent key value store for fast storage. Keys and values are arbitrary byte arrays. The keys are ordered within the key value store according to a user-specified comparator function.

RocksDB is implemented in C++ and has APIs exposed in Java. Please see [here](https://github.com/facebook/rocksdb/tree/main/java/src/main/java/org/rocksdb)

[RocksDB Overview](https://github.com/facebook/rocksdb/wiki/RocksDB-Overview)

Please checkout on a simple implementation of RockDB [here](https://dev.to/thegroo/simple-rocksdb-with-java-crash-course-20o7).

## Redis

Redis is an in-memory data store used by millions of developers as a cache, vector database, document database, streaming engine, and message broker. Redis has built-in replication and different levels of on-disk persistence. It supports complex data types (for example, strings, hashes, lists, sets, sorted sets, and JSON), with atomic operations defined on those data types.

We would like to explore Redis Stack in future, but it is not available in Ubuntu currently.

Redis Stack is an extension of Redis that adds modern data models and processing engines to provide a complete developer experience. Redis Stack provides a simple and seamless way to access different data models such as full-text search, document store, graph, time series, and probabilistic data structures enabling developers to build any real-time data application.

Redis Stack is offered as Redis Source Available License (RSAL) 2.0, which restricts its usage for service third party. Detail of the license is present [here](https://redis.io/about/license/)

## DuckDB

SQLite is the world's most widely deployed DBMS. Simplicity in installation, and embedded in-process operation are central to its success. DuckDB adopts these ideas of simplicity and embedded operation.

DuckDB has no external dependencies, neither for compilation nor during run-time. For releases, the entire source tree of DuckDB is compiled into two files, a header and an implementation file, a so-called "amalgamation". This greatly simplifies deployment and integration in other build processes. For building, all that is required to build DuckDB is a working C++11 compiler.

For DuckDB, there is no DBMS server software to install, update and maintain. DuckDB does not run as a separate process, but completely embedded within a host process. For the analytical use cases that DuckDB targets, this has the additional advantage of high-speed data transfer to and from the database. In some cases, DuckDB can process foreign data without copying. For example, the DuckDB Python package can run queries directly on Pandas data without ever importing or copying any data.

DuckDB is extremely portable. It can be compiled for all major operating systems (Linux, macOS, Windows) and CPU architectures (x86, ARM). It can be deployed from small, resource-constrained edge devices to large multi-terabyte memory servers with 100+ CPU cores. Using DuckDB-Wasm, DuckDB can also run in web browsers and even on mobile phones.

DuckDB provides APIs for Java, C, C++, Go, Node.js and other languages. You can also read more on [MotherDuck](https://motherduck.com/docs/getting-started/)

## MongoDB

MongoDB is a powerful and flexible solution for handling modern data needs. As a leading NoSQL database, MongoDB offers a dynamic schema design, enabling developers to store and manage data in a way that aligns seamlessly with contemporary application requirements.

Unlike traditional relational databases, MongoDB’s document-oriented architecture allows for greater agility and scalability, making it a preferred choice for businesses and developers aiming to handle large volumes of unstructured or semi-structured data.

## ElasticSearch

## OpenSearch
