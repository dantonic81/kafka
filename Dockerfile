FROM bitnami/kafka:latest

# Switch to root user to allow installing dependencies
USER root

# Enable Kafka in KRaft mode (no Zookeeper)
ENV KAFKA_CFG_PROCESS_ROLES=broker
ENV KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@0.0.0.0:9093
ENV KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV ALLOW_PLAINTEXT_LISTENER=yes

# Install dependencies
RUN apt-get update && apt-get install -y wget unzip

# Install Kafka REST Proxy version 7.8.0 from Confluent
RUN wget https://github.com/confluentinc/kafka-rest-images/releases/download/v7.9.0-26/kafka-rest-images-7.9.0-26.tar.gz \
    && tar -xzf kafka-rest-images-7.9.0-26.tar.gz \
    && mv kafka-rest-images-7.9.0-26 /opt/kafka-rest

# Expose HTTP ports (Kafka REST Proxy)
EXPOSE 8082

# Switch back to non-root user (if necessary)
USER 1001

# Start Kafka and Kafka REST Proxy
CMD ["bash", "-c", "/opt/bitnami/kafka/bin/kafka-server-start.sh /opt/bitnami/kafka/config/kraft/server.properties & /opt/kafka-rest/bin/kafka-rest-start /opt/kafka-rest/config/kafka-rest.properties"]
