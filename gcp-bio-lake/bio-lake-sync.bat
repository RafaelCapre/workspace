setx GOOGLE_APPLICATION_CREDENTIALS "bio-lake.json"
setx CLOUD_STORAGE_BUCKET "gs://bio-lake"
gcloud auth activate-service-account --key-file bio-lake.json
gsutil cp -r * gs://bio-lake 