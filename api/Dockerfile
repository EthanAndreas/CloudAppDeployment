FROM python:3.9-slim-buster
WORKDIR /usr/src/worker

ENV CELERY_BROKER_URL=https://queue.100do.se/
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=gare-centrale
ENV AWS_SECRET_ACCESS_KEY=Ku71sUSsnEKcfB3lw7uA

COPY . .

RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN poetry install
RUN poetry run app

CMD ["poetry","run","celery","worker","--app","image_api.worker.app"]
