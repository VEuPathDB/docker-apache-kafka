#!/bin/sh

export KAFKA_SERVER_PROPERTIES_FILE="${KAFKA_SERVER_PROPERTIES_FILE:-/opt/kafka/server.properties}"

# If the properties file already exists
if [ -f "${KAFKA_SERVER_PROPERTIES_FILE}" ]; then
  echo "Mounted Kafka properties file found."
else
  echo "No mounted Kafka properties file found, generating one."

  mkdir -p "$(dirname "${KAFKA_SERVER_PROPERTIES_FILE}")"

  . configuration.defaults.sh
  . server.properties.sh

  build_properties

  if [ -z "${KAFKA_CLUSTER_ID}" ]; then
    KAFKA_CLUSTER_ID="$(kafka-storage.sh random-uuid)"
  fi

  kafka-storage.sh format -t "$KAFKA_CLUSTER_ID" -c "${KAFKA_SERVER_PROPERTIES_FILE}"
fi

kafka-server-start.sh "${KAFKA_SERVER_PROPERTIES_FILE}"