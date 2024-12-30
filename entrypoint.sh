#!/bin/bash

# Set lower memory limits for Kafka
export KAFKA_HEAP_OPTS="-Xmx256m -Xms128m"  # Adjust this based on available memory

# Initialize Kafka data directory if needed
if [ ! -f /opt/bitnami/kafka/data/meta.properties ]; then
    echo "Initializing Kafka data directory..."
    CLUSTER_ID=$(cat /proc/sys/kernel/random/uuid)
    kafka-storage.sh format --config /opt/bitnami/kafka/config/kraft/server.properties --cluster-id "$CLUSTER_ID"
fi

echo "Starting Kafka..."
kafka-server-start.sh /opt/bitnami/kafka/config/kraft/server.properties &

# Wait until Kafka is fully ready to accept connections
echo "Waiting for Kafka to start..."
until nc -z localhost 9092; do
  echo "Waiting for Kafka to become available..."
  sleep 5
done

echo "Kafka is up and running!"

echo "Starting Python consumer..."
python3 /app/consumer.py
