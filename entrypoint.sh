#!/bin/bash

# Default to Koyeb's URL if not set
export KAFKA_ADVERTISED_LISTENERS="${KAFKA_ADVERTISED_LISTENERS:-PLAINTEXT://lovely-candice-acmetest-e2699be0.koyeb.app:9092}"
export KAFKA_LISTENERS="${KAFKA_LISTENERS:-PLAINTEXT://0.0.0.0:9092}"

# Set lower memory limits for Kafka
export KAFKA_HEAP_OPTS="-Xmx256m -Xms128m"  # Adjust this based on available memory

# Initialize Kafka data directory if needed
if [ ! -f /opt/bitnami/kafka/data/meta.properties ]; then
    echo "Initializing Kafka data directory..."
    CLUSTER_ID=$(cat /proc/sys/kernel/random/uuid)
    kafka-storage.sh format --config /opt/bitnami/kafka/config/kraft/server.properties --cluster-id "$CLUSTER_ID"
fi

# Set Kafka configuration dynamically
echo "Configuring Kafka listeners..."
echo "listeners=$KAFKA_LISTENERS" >> /opt/bitnami/kafka/config/server.properties
echo "advertised.listeners=$KAFKA_ADVERTISED_LISTENERS" >> /opt/bitnami/kafka/config/server.properties

echo "Starting Kafka..."
exec kafka-server-start.sh /opt/bitnami/kafka/config/kraft/server.properties
