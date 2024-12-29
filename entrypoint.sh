#!/bin/bash
# Initialize Kafka data directory if needed
if [ ! -f /opt/bitnami/kafka/data/meta.properties ]; then
    echo "Initializing Kafka data directory..."
    CLUSTER_ID=$(cat /proc/sys/kernel/random/uuid)
    kafka-storage.sh format --config /opt/bitnami/kafka/config/kraft/server.properties --cluster-id "$CLUSTER_ID"
fi

echo "Starting Kafka..."
kafka-server-start.sh /opt/bitnami/kafka/config/kraft/server.properties &

echo "Waiting for Kafka to start..."
sleep 10

echo "Starting Python consumer..."
python3 /app/consumer.py