#!/bin/bash

# Set endpoint and bucket name
ENDPOINT="http://localhost:4566"
BUCKET="bansi-test"

echo "=== Creating bucket ==="
aws --endpoint-url=$ENDPOINT s3 mb s3://$BUCKET || echo "Bucket may already exist"

echo "=== Creating test file ==="
echo "Hello LocalStack" > test.txt

echo "=== Uploading file ==="
aws --endpoint-url=$ENDPOINT s3 cp test.txt s3://$BUCKET/

echo "=== Listing files in bucket ==="
aws --endpoint-url=$ENDPOINT s3 ls s3://$BUCKET/

echo "=== Enabling versioning ==="
aws --endpoint-url=$ENDPOINT s3api put-bucket-versioning \
    --bucket $BUCKET \
    --versioning-configuration Status=Enabled

echo "=== Creating lifecycle.json ==="
cat > lifecycle.json <<EOF
{
  "Rules": [
    {
      "ID": "MoveOldFiles",
      "Filter": { "Prefix": "" },
      "Status": "Enabled",
      "Transitions": [
        {
          "Days": 30,
          "StorageClass": "STANDARD_IA"
        }
      ]
    }
  ]
}
EOF

echo "=== Applying lifecycle rules ==="
aws --endpoint-url=$ENDPOINT s3api put-bucket-lifecycle-configuration \
    --bucket $BUCKET \
    --lifecycle-configuration file://lifecycle.json

echo "=== Verifying lifecycle rules ==="
aws --endpoint-url=$ENDPOINT s3api get-bucket-lifecycle-configuration \
    --bucket $BUCKET

echo "=== Setup complete! ==="

