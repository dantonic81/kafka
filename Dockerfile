FROM bitnami/kafka:latest

# Set up the Kafka environment in Zookeeper mode
ENV KAFKA_LISTENER_SECURITY_PROTOCOL=PLAINTEXT
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_REST_LISTENERS=http://0.0.0.0:8082
ENV KAFKA_REST_LISTENER_SECURITY_PROTOCOL=PLAINTEXT
ENV KAFKA_REST_ADVERTISED_LISTENERS=http://kafka-rest:8082
ENV KAFKA_REST_KAFKA_CLUSTER_ID=my-cluster

# Set JVM options to limit memory usage
ENV KAFKA_HEAP_OPTS="-Xmx384M -Xms384M"

# Expose Kafka and REST Proxy ports
EXPOSE 9092
EXPOSE 8082

# Start Kafka and the REST Proxy
CMD ["/opt/bitnami/scripts/kafka/entrypoint.sh", "/opt/bitnami/kafka/bin/kafka-server-start.sh", "/opt/bitnami/kafka/config/server.properties"]
