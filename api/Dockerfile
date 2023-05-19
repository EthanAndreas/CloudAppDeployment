# Use official Python runtime as a parent image
FROM python

# Set the working directory to /usr/src/worker
WORKDIR /usr/src/worker

# Copy the current directory contents into the container at /usr/src/worker
COPY . .

# Expose port 8080 for the API
EXPOSE 8080

# Set environment variables (NOTE: These are not secret, they are public, may use .env file in future)
ENV CELERY_BROKER_URL=amqp://gare-centrale:6ot4WBtqNFdbfYBzBO6O@queue.internal.100do.se:5672/gare-centrale
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=gare-centrale
ENV AWS_SECRET_ACCESS_KEY=Ku71sUSsnEKcfB3lw7uA

# Install any needed packages specified
RUN pip install .
RUN pip install celery

# Run the API when the container launches
CMD ["/usr/local/bin/celery","--app","image_api.worker.app","worker"]
