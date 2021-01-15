# Copyright (c) 2021 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

import http.client
import json
import os


def getEnv(env):
    res = os.environ.get(env)
    if res is None:
        raise Exception("not found " + env + " variable")
    else:
        return res


elasticsearch = getEnv("ES_HOST")
s3_bucket_name = getEnv("S3_BUCKET_NAME")
aws_access_key = getEnv("AWS_ACCESS_KEY_ID")
aws_secret_key = getEnv("AWS_SECRET_ACCESS_KEY")
aws_region = getEnv("AWS_REGION")
task_name = getEnv("SNAPSHOT_S3_TASK")
headers = {"Content-type": "application/json"}
task = {
    "type": "s3",
    "settings": {
        "bucket": s3_bucket_name,
        "region": aws_region,
        "access_key": aws_access_key,
        "secret_key": aws_secret_key,
        "compress": True,
    },
}
json_task = json.dumps(task)

path = "/_snapshot/" + task_name
es_uri = elasticsearch + ":9200"
connection = http.client.HTTPConnection(es_uri)
connection.request("POST", path, json_task, headers)
response = connection.getresponse()
print(response.read().decode())

# {"acknowledged":true}
