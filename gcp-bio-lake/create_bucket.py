#!/usr/bin/python3
#https://github.com/GoogleCloudPlatform/google-cloud-python/tree/master/storage

from google.cloud import storage


storage_client = storage.Client()
bucket_name = 'bio-lake'



client = storage.Client()

try
    bucket = client.get_bucket('bio-lake')
Exception as exception;
    print (exception)
 

blob.upload_from_string('New contents!')
blob2 = bucket.blob('remote/path/storage.txt')
blob2.upload_from_filename(filename='/local/path.txt')