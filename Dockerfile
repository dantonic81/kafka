# Use the Bitnami Kafka image as the base
FROM bitnami/kafka:latest

# Install Python and dependencies
USER root
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv nano git netcat-openbsd && \
    python3 -m venv /app/venv && \
    /app/venv/bin/pip install kafka-python

# Set environment variables for the Python app
ENV PATH="/app/venv/bin:$PATH"

# Create a directory for the app
WORKDIR /app

# Copy the requirements.txt file
COPY requirements.txt /app/requirements.txt

# Install dependencies from requirements.txt
RUN /app/venv/bin/pip install -r /app/requirements.txt

# Copy your Python application files
COPY utils /app/utils
COPY consumer.py /app/consumer.py

# Expose Kafka and app ports
EXPOSE 9092

# Entrypoint script to run both Kafka and the Python consumer
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh && ls -l /app/entrypoint.sh

# Use the custom entrypoint
CMD ["/app/entrypoint.sh"]
