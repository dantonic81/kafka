from kafka import KafkaConsumer
import json
from utils.logger import logger

# Configure the consumer
consumer = KafkaConsumer(
    'portfolio-topic',  # The topic name
    bootstrap_servers=['lovely-candice-acmetest-e2699be0.koyeb.app:9092'],  # Replace with your Kafka broker address
    group_id='portfolio-consumer-group',
    value_deserializer=lambda x: x.decode('utf-8') if x else None  # Avoid decoding empty messages
)

logger.info("Consumer is listening to the topic 'portfolio-topic'...")

# Poll for messages from the Kafka topic
for message in consumer:
    try:
        # Attempt to deserialize the message
        if message.value:
            deserialized_message = json.loads(message.value)  # Deserialize the JSON string
            logger.info(f"Deserialized message: {deserialized_message}")
        else:
            logger.info("Received an empty message. Skipping...")

    except json.JSONDecodeError as e:
        # Handle JSON decode errors gracefully
        logger.error(f"Error decoding message: {e}. Skipping the message.")
        continue  # Skip this message and continue consuming

    except Exception as e:
        # Handle any other exceptions that might occur
        logger.error(f"Unexpected error: {e}. Skipping the message.")
        continue  # Skip this message and continue consuming
