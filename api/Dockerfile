FROM python:3
WORKDIR /usr/src/worker

ENV CELERY_BROKER_URL=https://queue.100do.se/
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=gare-centrale
ENV AWS_SECRET_ACCESS_KEY=Ku71sUSsnEKcfB3lw7uA

COPY . .

RUN pip install poetry
RUN poetry install

CMD ["poetry", "run", "app"]
