from kafka import KafkaConsumer
import json

# Configure the consumer
consumer = KafkaConsumer(
    'portfolio-topic',  # The topic name
    bootstrap_servers=['localhost:9092'],  # Replace with your Kafka broker address
    group_id='portfolio-consumer-group',
    value_deserializer=lambda x: x.decode('utf-8') if x else None  # Avoid decoding empty messages
)

print("Consumer is listening to the topic 'portfolio-topic'... v2")

# Poll for messages from the Kafka topic
for message in consumer:
    try:
        # Attempt to deserialize the message
        if message.value:
            deserialized_message = json.loads(message.value)  # Deserialize the JSON string
            print(f"Deserialized message: {deserialized_message}")
        else:
            print("Received an empty message. Skipping...")

    except json.JSONDecodeError as e:
        # Handle JSON decode errors gracefully
        print(f"Error decoding message: {e}. Skipping the message.")
        continue  # Skip this message and continue consuming

    except Exception as e:
        # Handle any other exceptions that might occur
        print(f"Unexpected error: {e}. Skipping the message.")
        continue  # Skip this message and continue consuming
