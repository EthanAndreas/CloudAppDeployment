FROM python:3
WORKDIR /usr/src/worker

COPY . .

EXPOSE 8080

ENV CELERY_BROKER_URL=amqp://queue.internal.100do.se:5672/gare-centrale
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=gare-centrale
ENV AWS_SECRET_ACCESS_KEY=Ku71sUSsnEKcfB3lw7uA

RUN pip install poetry
RUN pip install .
RUN pip install celery
RUN poetry install

CMD ["/usr/local/bin/celery","--app","image_api.worker.app","worker"]
