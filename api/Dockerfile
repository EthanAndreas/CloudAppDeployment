FROM python:3
WORKDIR /usr/src/worker

EXPOSE 8080

ENV CELERY_BROKER_URL=amqp://queue.internal.100do.se:5672/gare-centrale
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=1ReFDENvIHI2Kuxb
ENV AWS_SECRET_ACCESS_KEY=Zf6afK5F37TM3rYQ7uMqNspg2o93o78N

COPY . .

RUN pip install poetry
RUN pip install .
RUN pip install boto3
RUN poetry install

CMD ["poetry", "run", "app"]
