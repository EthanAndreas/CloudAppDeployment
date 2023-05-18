FROM python
WORKDIR /usr/src/worker

COPY . .

EXPOSE 8080

RUN pip install .
RUN pip install celery

CMD ["/usr/local/bin/celery","--app","image_api.worker.app","worker"]
