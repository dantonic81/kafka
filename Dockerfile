FROM confluentinc/cp-kafka:latest

# Set up the Kafka environment in Zookeeper mode
ENV KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092
ENV KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092
ENV KAFKA_CFG_LISTENER_SECURITY_PROTOCOL=PLAINTEXT
ENV KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_REST_LISTENERS=http://0.0.0.0:8082
ENV KAFKA_REST_LISTENER_SECURITY_PROTOCOL=PLAINTEXT
ENV KAFKA_REST_ADVERTISED_LISTENERS=http://kafka-rest:8082
ENV KAFKA_REST_KAFKA_CLUSTER_ID=my-cluster

# Expose Kafka and REST Proxy ports
EXPOSE 9092
EXPOSE 8082

# Start Kafka in Zookeeper mode and the REST Proxy
CMD /bin/bash -c "kafka-server-start.sh /etc/kafka/server.properties & /etc/confluent/docker/run"
