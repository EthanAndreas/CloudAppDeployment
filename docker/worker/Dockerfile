FROM python:3.9-slim-buster
WORKDIR /worker
COPY ../../api/images_api/worker.py .
CMD ["pip","install","celery","pillow"]
CMD ["python","worker.py"]