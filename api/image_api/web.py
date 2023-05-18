from celery.canvas import group
from flask import Flask, request, url_for
from flask_cors import CORS
from email.utils import formatdate
from botocore.exceptions import ClientError
from urllib.parse import unquote

from .storage import s3, bucket
from .utils import random_id, valid_id
from .worker import Sizes, resize_image


# Create the bucket if it does not exist
if bucket.creation_date is None:
    bucket.create()

app = Flask(__name__)
CORS(app)


@app.route("/")
def index():
    return {
        "upload_url": unquote(url_for("upload")),
        "original_image_url": unquote(url_for("original", id="{id}")),
        "big_image_url": unquote(url_for("big", id="{id}")),
        "medium_image_url": unquote(url_for("medium", id="{id}")),
        "small_image_url": unquote(url_for("small", id="{id}")),
        "tiny_image_url": unquote(url_for("tiny", id="{id}")),
    }


@app.route("/image", methods=["POST"])
def upload():
    """Upload the image to the S3 bucket"""
    if "file" not in request.files:
        return {"error": "missing file"}, 400

    file = request.files["file"]
    # Generate a random ID. It should be random enough to not have colisions
    id = random_id()

    bucket.Object(f"{Sizes.Original.segment}/{id}").upload_fileobj(
        file.stream,
        ExtraArgs={"ContentType": file.content_type},
    )

    group(
        [
            resize_image.s(key=id, size=Sizes.Big),
            resize_image.s(key=id, size=Sizes.Medium),
            resize_image.s(key=id, size=Sizes.Small),
            resize_image.s(key=id, size=Sizes.Tiny),
        ]
    ).delay()

    return {
        "id": id,
        "original": url_for("original", id=id),
        "big": url_for("big", id=id),
        "medium": url_for("medium", id=id),
        "small": url_for("small", id=id),
        "tiny": url_for("tiny", id=id),
    }, 201


def stream_image(id: str, size: Sizes):
    # Fail fast if the ID does not have the right shape
    if not valid_id(id):
        return "invalid id", 400

    # Forward the If-None-Match and If-Modified-Since headers
    args = {}
    if_none_match = request.headers.get("If-None-Match")
    if if_none_match is not None:
        args["IfNoneMatch"] = if_none_match
    if_modified_since = request.headers.get("If-Modified-Since")
    if if_modified_since is not None:
        args["IfModifiedSince"] = if_modified_since

    try:
        obj = bucket.Object(f"{size.segment}/{id}").get(**args)
    except s3.meta.client.exceptions.NoSuchKey:
        # If the key was not found, return a 404
        return "not found", 404
    except ClientError as ex:
        # If the request returned a 304, forward it
        err = ex.response.get("Error")
        if err is not None and err.get("Code") == "304":
            return "", 304
        # Else, for other errors, re-raise
        raise

    res = app.response_class(obj["Body"], mimetype=obj["ContentType"])
    # Forward a few headers from the GetObject response
    res.headers["Content-Length"] = obj["ContentLength"]
    res.headers["ETag"] = obj["ETag"]
    res.headers["Last-Modified"] = formatdate(
        obj["LastModified"].timestamp(), usegmt=True
    )
    res.headers["Cache-Control"] = "public"

    return res


@app.route("/image/<id>", methods=["GET"])
def original(id: str):
    """Serve the original image from the S3 bucket"""
    return stream_image(id, Sizes.Original)


@app.route("/image/<id>/big", methods=["GET"])
def big(id: str):
    """Serve the big thumbnail image from the S3 bucket"""
    return stream_image(id, Sizes.Big)


@app.route("/image/<id>/medium", methods=["GET"])
def medium(id: str):
    """Serve the medium thumbnail image from the S3 bucket"""
    return stream_image(id, Sizes.Medium)


@app.route("/image/<id>/small", methods=["GET"])
def small(id: str):
    """Serve the small thumbnail image from the S3 bucket"""
    return stream_image(id, Sizes.Small)


@app.route("/image/<id>/tiny", methods=["GET"])
def tiny(id: str):
    """Serve the tiny thumbnail image from the S3 bucket"""
    return stream_image(id, Sizes.Tiny)


@app.route("/health", methods=["GET"])
def health():
    """Simple healtcheck route to check the service is running properly"""
    return "ok"

def dev():
    app.run(host="0.0.0.0", port=8080, debug=True, use_reloader=False)

if __name__ == "__main__":
    # When the script is being run standalone, start the Flask debug server
    dev()
