#!/bin/sh

export KAFKA_SERVER_PROPERTIES_FILE="${KAFKA_SERVER_PROPERTIES_FILE:-/opt/kafka/server.properties}"

# If the properties file already exists
if [ -f "${KAFKA_SERVER_PROPERTIES_FILE}" ]; then
  echo "Mounted Kafka properties file found."
  exit 0
else
  echo "No mounted Kafka properties file found, generating one."

  mkdir -p "$(dirname "${KAFKA_SERVER_PROPERTIES_FILE}")"

  . configuration.defaults.sh
  . server.properties.sh

  build_properties
fi

KAFKA_CLUSTER_ID="$(kafka-storage.sh random-uuid)"

kafka-storage.sh format -t "$KAFKA_CLUSTER_ID" -c "${KAFKA_SERVER_PROPERTIES_FILE}"

kafka-server-start.sh "${KAFKA_SERVER_PROPERTIES_FILE}"