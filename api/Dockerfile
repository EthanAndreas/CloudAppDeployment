FROM python:3
WORKDIR /usr/src/worker

COPY . .

EXPOSE 8080

ENV CELERY_BROKER_URL=amqp://queue.internal.100do.se:5672/gare-centrale
ENV S3_ENDPOINT_URL=https://s3.100do.se/
ENV AWS_ACCESS_KEY_ID=Xr38d5bSE8tzDqjD
ENV AWS_SECRET_ACCESS_KEY=yzolz8jB4lNGMV94ueywL2u4esGScbHg

RUN pip install poetry
RUN pip install .
RUN poetry install

CMD ["/usr/local/bin/celery","--app","image_api.worker.app","worker"]
