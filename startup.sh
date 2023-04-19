#!/bin/sh

export KAFKA_SERVER_PROPERTIES_FILE="${KAFKA_SERVER_PROPERTIES_FILE:-/opt/kafka/server.properties}"

REAL_PROPERTIES_PATH="/opt/kafka/real-server.properties"
FORMAT_FLAG="/formatted"

# If the properties file already exists
if [ -f "${KAFKA_SERVER_PROPERTIES_FILE}" ]; then
  echo "Mounted Kafka properties file found."
  REAL_PROPERTIES_PATH=${KAFKA_SERVER_PROPERTIES_FILE}
else
  echo "No mounted Kafka properties file found, generating one."

  mkdir -p "$(dirname "${REAL_PROPERTIES_PATH}")"

  . configuration.defaults.sh
  . server.properties.sh

  build_properties
fi

if [ ! -f "${FORMAT_FLAG}" ]; then
  if [ -z "${KAFKA_CLUSTER_ID}" ]; then
    KAFKA_CLUSTER_ID="$(kafka-storage.sh random-uuid)"
  fi

  kafka-storage.sh format -t "$KAFKA_CLUSTER_ID" -c "${REAL_PROPERTIES_PATH}"
  touch "${FORMAT_FLAG}"
fi

kafka-server-start.sh "${REAL_PROPERTIES_PATH}"