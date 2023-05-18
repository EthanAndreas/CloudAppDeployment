FROM python:3.9-slim-buster
WORKDIR /usr/src/worker
COPY . .
CMD ["pip","install","celery","pillow"]
CMD ["python","worker.py"]