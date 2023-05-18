import boto3
from botocore.client import Config

import config

s3 = boto3.resource("s3", **config.s3, config=Config(signature_version="s3v4"))

bucket = s3.Bucket(config.bucket_name)

__all__ = ["s3", "bucket"]
