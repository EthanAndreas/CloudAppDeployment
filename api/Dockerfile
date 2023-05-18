FROM python:3.9-slim-buster
WORKDIR /usr/src/worker
COPY . .
RUN pip install celery pillow
CMD ["python","worker.py"]