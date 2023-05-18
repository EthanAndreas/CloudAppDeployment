FROM python:3.9-slim-buster
WORKDIR /worker
COPY worker.py .
CMD ["pip","install","celery","pillow"]
CMD ["python","worker.py"]