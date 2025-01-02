# Use the Bitnami Kafka image as base
FROM bitnami/kafka:latest

# Install the Kafka REST Proxy dependencies
RUN apt-get update && apt-get install -y wget unzip

# Install the Kafka REST Proxy
RUN wget https://github.com/confluentinc/kafka-rest/releases/download/v6.2.0/kafka-rest-6.2.0.tar.gz
RUN tar -xvzf kafka-rest-6.2.0.tar.gz -C /opt/
RUN rm kafka-rest-6.2.0.tar.gz

# Set environment variables for Kafka and Kafka REST Proxy
ENV KAFKA_CFG_PROCESS_ROLES=broker
ENV KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@0.0.0.0:9093
ENV KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV ALLOW_PLAINTEXT_LISTENER=yes

# Set environment variables for Kafka REST Proxy
ENV KAFKA_REST_HOST=0.0.0.0
ENV KAFKA_REST_PORT=8082
ENV KAFKA_REST_LISTENER_HTTP=http://0.0.0.0:8082
ENV KAFKA_BROKER=localhost:9092

# Expose ports
EXPOSE 9092 8082

# Start both Kafka and Kafka REST Proxy
CMD /opt/bitnami/kafka/bin/kafka-server-start.sh /opt/bitnami/kafka/config/kraft/server.properties & \
    /opt/kafka-rest-6.2.0/bin/kafka-rest-start /opt/kafka-rest-6.2.0/etc/kafka-rest/kafka-rest.properties
