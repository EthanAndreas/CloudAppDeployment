FROM python
WORKDIR /usr/src/worker

COPY . .

EXPOSE 8080

ENV CELERY_BROKER_URL=amqp://gare-centrale:6ot4WBtqNFdbfYBzBO6O@queue.internal.100do.se:5672/gare-centrale
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=gare-centrale
ENV AWS_SECRET_ACCESS_KEY=Ku71sUSsnEKcfB3lw7uA

RUN pip install .
RUN pip install celery

CMD ["/usr/local/bin/celery","--app","image_api.worker.app","worker"]
