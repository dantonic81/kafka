FROM bitnami/kafka:latest

# Enable Kafka in KRaft mode (no Zookeeper)
ENV KAFKA_CFG_PROCESS_ROLES=broker
ENV KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@0.0.0.0:9093
ENV KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV ALLOW_PLAINTEXT_LISTENER=yes

# Install dependencies
RUN mkdir -p /var/lib/apt/lists/partial && apt-get update && apt-get install -y wget unzip

# Install Kafka REST Proxy
RUN wget https://github.com/confluentinc/kafka-rest/releases/download/v2.8.0/kafka-rest-2.8.0.tar.gz \
    && tar -xzf kafka-rest-2.8.0.tar.gz \
    && mv kafka-rest-2.8.0 /opt/kafka-rest

# Expose HTTP ports (Kafka REST Proxy)
EXPOSE 8082

# Start Kafka and Kafka REST Proxy
CMD ["bash", "-c", "/opt/bitnami/kafka/bin/kafka-server-start.sh /opt/bitnami/kafka/config/kraft/server.properties & /opt/kafka-rest/bin/kafka-rest-start /opt/kafka-rest/config/kafka-rest.properties"]
