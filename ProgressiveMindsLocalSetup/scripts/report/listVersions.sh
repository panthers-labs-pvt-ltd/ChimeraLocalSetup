#!/bin/bash

. ~/.local/bin/env/configureJvmEnv.sh
. ~/.local/bin/env/configureN.sh
. ~/.cargo/env
. ~/.local/bin/env/configureDeno.sh
. ~/.local/bin/env/configureSpark.sh
. ~/.local/bin/env/configureFlink.sh

echo -e "\n\nListing software versions:"

echo -e "\nOpenVSCode Server: "
grep version ~/.local/openvscode-server/latest/package.json

echo -e "\ndocker:"
docker --version
docker --help | grep compose

echo -e "\njava:"
echo "Java Version- $(java --version | grep "openjdk")"
echo "Javac Version- $(javac --version)"
echo "Maven Version- $(mvn --version | grep "Apache Maven")"
echo "Gradle Version- $(gradle --version | grep Gradle)"

echo -e "\nnode:"
echo "n $(n --version)"
echo "node $(node --version)"
echo "npm $(npm --version)"
echo "tsc $(tsc --version)"

echo -e "\nrust:"
rustup --version
rustc --version
cargo --version

echo -e "\ndeno:"
deno --version

echo -e "\ngit version:"
git --version

echo -e "\nApache Spark version:"
cat /opt/spark/RELEASE | grep Spark

echo -e "\nApache Flink version:"
flink --version

echo -e "\nMiniConda version:"
conda --version

echo -e "\nPolars version:"
pip show polars | grep "Version"

echo -e "\nKafka version:"
echo "To be done"

echo -e "\nRay version:"
ray --version

echo -e "\nMinio version:"
~/minio --version | grep version

echo -e "\nRedis version:"
redis-server --version | grep "Redis server"

echo -e "\nDuckDB version:"
# ~/./duckdb
# PRAGMA version;
echo "v1.1.3 - Hardcoded"

echo -e "\nMongoDB version:"
mongod -version | grep "db version"

echo -e "\nTerraform version:"
terraform -version | grep "Terraform"

echo -e "\nMinikube version:"
minikube version

echo -e "\Helm version:"
helm version

echo -e "\nIntelliJ version:"
cat /opt/intellij-idea-community/product-info.json | grep -sw "version"

echo -e "\nFlink version:"
flink --version

echo -e "\nNeo4J version:"
neo4j version

echo -e "\nOpenSearch version:"
#mongod -version | grep "db version"

# echo "virt-manager $(virt-manager --version)"
# firefox --version
# google-chrome --version

# postgres=16=
# nodejs=v10.0.0=
# deno=2.0.6=
# openvscodeServer=v1.94.2=
# apachekafka=3.9.0=
# apachepulsar=4.0.0=
# apachedruid=31.0.0=
# apachepinot=1.2.0=
# apachenifi=1.28.1=
# alluxio=2.9.5=
# yunikorn=latest=
# minio=2024-11-07=
# duckDB=1.1.3=
# opensearch=2.18.0=
# cassandra=5.0.2=
# grafana=11.3=
# prometheus=3.0.0=
# node_exporter=1.8.2=
# alertmanager=0.27.0=
# debezium=2.7.3=DO NOT UPGRADE TO 3.0.x - it required Java 21 for debezium server. It may be okay to be used as connector in Java 17
# glaredb=0.9.4=
# airflow=2.10.3=
# mage-ai=0.9.74=
# datahubproject=0.14.1.12=
