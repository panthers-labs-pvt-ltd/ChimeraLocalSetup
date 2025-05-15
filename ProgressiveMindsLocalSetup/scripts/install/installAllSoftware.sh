#!/bin/bash

set -euo pipefail

DIR_ME=$(realpath $(dirname $0))
. ${DIR_ME}/.installUtils.sh
setUserName "$(whoami)"

# Start - Need to understand the value of it
# bash ${DIR_ME}/../config/system/prepareXServer.sh ${USERNAME}
# echo -e "\n\nInstalling Google Chrome..."
# bash ${DIR_ME}/installChrome.sh

# echo -e "\n\nInstalling KVM & QEMU..."
# bash ${DIR_ME}/installKvm.sh
# End

echo -e "\n\nInstalling OpenVSCode Server"
bash ${DIR_ME}/installOpenVSCodeServer.sh

echo -e "\n\nInstalling docker & docker-compose apt"
bash ${DIR_ME}/installDocker.sh

echo -e "\n\nInstalling minikube"
bash ${DIR_ME}/installMinikube.sh

echo -e "\n\nInstalling OpenJDK via apt..."
bash ${DIR_ME}/installOpenjdk.sh

echo -e "\n\nInstalling Apache Maven manually..."
bash ${DIR_ME}/installMaven.sh

echo -e "\n\nInstalling Gradle manually..."
bash ${DIR_ME}/installGradle.sh

echo -e "\n\nInstalling node.js via n..."
bash ${DIR_ME}/installNodejs.sh

echo -e "\n\nInstalling rust..."
bash ${DIR_ME}/installRust.sh

echo -e "\n\nInstalling postgres..."
bash ${DIR_ME}/installPostgres.sh

echo -e "\n\nInstalling Intellij Idea..."
bash ${DIR_ME}/installIntellij.sh

echo -e "\n\nInstalling deno..."
bash ${DIR_ME}/installDeno.sh

echo -e "\n\nInstalling Apache spark..."
bash ${DIR_ME}/installApacheSpark.sh

echo -e "\n\nInstalling Apache Flink..."
bash ${DIR_ME}/installApacheFlink.sh

echo -e "\n\nInstalling MiniConda for Python Development..."
bash ${DIR_ME}/installMiniConda.sh

echo -e "\n\nInstalling Ray..."
bash ${DIR_ME}/installRay.sh

echo -e "\n\nInstalling Polars..."
bash ${DIR_ME}/installPolars.sh

echo -e "\n\nInstalling MinIO..."
bash ${DIR_ME}/installMinIO.sh

echo -e "\n\nInstalling Redis Stack..."
bash ${DIR_ME}/installRedis.sh

echo -e "\n\nRocksDB installation - Not required. You can use RocksDB as embedded key-value. Please let me know if you need a compiled build for your use case."
sleep 5

echo -e "\n\nInstalling DuckDB..."
bash ${DIR_ME}/installDuckDB.sh

echo -e "\n\nInstalling Kafka..."
bash ${DIR_ME}/installApacheKafka.sh

echo -e "\n\nInstalling Pulsar..."
bash ${DIR_ME}/installApachePulsar.sh

echo -e "\n\nInstalling MongoDB..."
bash ${DIR_ME}/installMongoDB.sh

echo -e "\n\nInstalling Apache Nifi..."
bash ${DIR_ME}/installApacheNifi.sh

echo -e "\n\nInstalling Debezuim..."
bash ${DIR_ME}/installDebezuim.sh

echo -e "\n\nInstalling Prometheus..."
bash ${DIR_ME}/installPrometheus.sh

echo -e "\n\nInstalling Grafana..."
bash ${DIR_ME}/installGrafana.sh

echo -e "\n\nInstalling Apache Pinot..."
bash ${DIR_ME}/installApachePinot.sh

echo -e "\n\nInstalling Apache Druid..."
bash ${DIR_ME}/installApacheDruid.sh

echo -e "\n\nInstalling GlareDB..."
bash ${DIR_ME}/installGlareDB.sh

echo -e "\n\nInstalling Apache Airflow..."
bash ${DIR_ME}/installApacheAirflow.sh

echo -e "\n\nInstalling Mage AI..."
bash ${DIR_ME}/installMageAI.sh

echo -e "\n\nInstalling Cassandra..."
bash ${DIR_ME}/installApacheCassandra.sh

echo -e "\n\nInstalling Open Search..."
bash ${DIR_ME}/installOpenSearch.sh

echo -e "\n\nInstalling Yunikorn..."
bash ${DIR_ME}/installApacheYunikorn.sh

echo -e "\n\nInstalling Terraform..."
bash ${DIR_ME}/installTerraform.sh

echo -e "\n\nInstalling Neo4j... Has issues with UI opening. cypher-shell is fine."
bash ${DIR_ME}/installNeo4j.sh

echo -e "\n\nInstalling Alluxio... Does not support Java 17. It supports Java 8 and 11"
bash ${DIR_ME}/installAlluxio.sh

echo -e "\n\nInstalling DatahubProject..."
bash ${DIR_ME}/installDatahubProject.sh

echo -e "\n\nSkipping Riak KV installation for now..."
# echo -e "\n\nInstalling Riak KV..."
# bash ${DIR_ME}/installMinIO.sh

echo -e "\n\nSkipping Cockroach DB installation for now..."
# echo -e "\n\nInstalling CockroachDB..."
# bash ${DIR_ME}/installMinIO.sh

echo -e "\n\nSkipping Apache Storm installation for now..."
# echo -e "\n\nInstalling Apache Storm..."
# bash ${DIR_ME}/installMinIO.sh

echo -e "\n\nSkipping Dagster installation for now..."
# echo -e "\n\nInstalling Dagster..."
# bash ${DIR_ME}/installMinIO.sh

echo -e "\n\nSkipping Apache Toree installation for now..."
# echo -e "\n\nInstalling Apache Toree..."
# bash ${DIR_ME}/installMinIO.sh

echo -e "\n\nSkipping Elastic Search installation for now..."
# echo -e "\n\nInstalling Elastic Search..."
# bash ${DIR_ME}/installElasticSearch.sh

# clean-up
echo -e "\n\nStarting autoremove"
sudo apt autoremove

bash ${DIR_ME}/../report/listVersions.sh
