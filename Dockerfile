# Use the Bitnami Kafka image
FROM bitnami/kafka:latest

# Enable Kafka in KRaft mode (no Zookeeper)
ENV KAFKA_CFG_PROCESS_ROLES=broker
ENV KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@0.0.0.0:9093
ENV KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV ALLOW_PLAINTEXT_LISTENER=yes

# Expose the internal Kafka port for communication within the network (not exposed to the outside world)
EXPOSE 9092 9093

# Start Kafka in KRaft mode
CMD ["kafka-server-start.sh", "/opt/bitnami/kafka/config/kraft/server.properties"]
