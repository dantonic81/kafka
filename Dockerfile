FROM confluentinc/cp-kafka:latest

# Set up the Kafka environment in KRaft mode (no Zookeeper)
ENV KAFKA_CFG_PROCESS_ROLES=broker
ENV KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@0.0.0.0:9093
ENV KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV KAFKA_CFG_LISTENER_SECURITY_PROTOCOL=PLAINTEXT
ENV ALLOW_PLAINTEXT_LISTENER=yes

# Set up the REST Proxy environment variables
ENV KAFKA_REST_LISTENERS=http://0.0.0.0:8082
ENV KAFKA_REST_LISTENER_SECURITY_PROTOCOL=PLAINTEXT
ENV KAFKA_REST_ADVERTISED_LISTENERS=http://kafka-rest:8082
ENV KAFKA_REST_KAFKA_CLUSTER_ID=my-cluster

# Expose Kafka and REST API ports
EXPOSE 9092
EXPOSE 8082

# Start Kafka in KRaft mode and REST Proxy
CMD ["sh", "-c", "kafka-server-start.sh /etc/kafka/kraft/server.properties & start /etc/confluent/docker/config/kafka-rest.properties"]
