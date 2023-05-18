## Description

This is the backend of the app.
It has two components:

 - The Celery worker, which runs image resizing tasks
 - The Flask server, which serves the API to upload new images

## Configuration

Configuration is loaded from the [`config.py`](./config.py) file.
By default, this file reads environment variables to configure the application:

 - `CELERY_BROKER_URL`: URL of the message broker
 - `S3_ENDPOINT_URL`: Endpoint of the S3 service
 - `AWS_ACCESS_KEY_ID`: Access key used for authenticating S3 operations
 - `AWS_SECRET_ACCESS_KEY`: Secret key used for authenticating S3 operations
 - `S3_BUCKET_NAME`: Bucket to use for storing images

## Try out the API

The easiest way to try the API locally is to use [Poetry](https://python-poetry.org) to install dependencies, Redis as message broker and Minio for S3-compatible storage.

```sh
# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Install dependencies
poetry install

# Run a Redis server via Docker
docker run -d -p 6379:6379 --rm --name redis redis:6.2

# Run a Minio instance via Docker
docker run -d -p 9000:9000 -p 9001:9001 --rm --name minio quay.io/minio/minio server /data --console-address ":9001"

# Set a bunch of environment variables
export CELERY_BROKER_URL=redis://localhost:6379/0
export S3_ENDPOINT_URL=http://localhost:9000
export AWS_ACCESS_KEY_ID=minioadmin
export AWS_SECRET_ACCESS_KEY=minioadmin
export S3_BUCKET_NAME=images

# Run the dev. web server
poetry run app

# Run the celery worker
poetry run celery worker --app image_api.worker.app

# Upload an image
curl -X POST \
  http://localhost:8080/image \
  --form file=@/path/to/an/image.png
```

## Run in production

### Installation (both web and worker)

Requires Python `>=3.9`.

```sh
pip install .
```

### Run the web server

The application exposes a WSGI-compatible API under the `image_api.web:app` module.
Any WSGI-compatible server can be used, like [`gunicorn`](https://gunicorn.org) or [`waitress`](https://docs.pylonsproject.org/projects/waitress/en/stable/usage.html).

Example with `gunicorn`:

```sh
# Install gunicorn
pip install gunicorn

# Run gunicorn with 4 threads on port 8080
gunicorn --workers 4 --bind 0.0.0.0:8080 image_api.web:app
```

See <https://flask.palletsprojects.com/en/2.1.x/deploying/wsgi-standalone/>

### Run the worker

```sh
celery worker --app image_api.worker.app
```

See <https://docs.celeryq.dev/en/stable/userguide/workers.html>
