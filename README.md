# LocalStack S3 Demo

Automated setup of AWS S3 bucket with versioning and lifecycle rules using LocalStack.

## 🚀 Features
- Create S3 bucket (`bansi-test`) locally with LocalStack
- Enable bucket versioning
- Apply lifecycle rules (move objects to STANDARD_IA after 30 days)
- Upload and list objects with AWS CLI

## 🛠 Setup Instructions
1. **Start LocalStack**
   ```bash
   localstack start -d
2.Create bucket
aws --endpoint-url=http://localhost:4566 s3 mb s3://bansi-test

3.Upload file
echo "Hello LocalStack" > test.txt
aws --endpoint-url=http://localhost:4566 s3 cp test.txt s3://bansi-test/

4.List files
aws --endpoint-url=http://localhost:4566 s3 ls s3://bansi-test/

5.Enable versioning
aws --endpoint-url=http://localhost:4566 s3api put-bucket-versioning \
--bucket bansi-test \
--versioning-configuration Status=Enabled

6.Apply lifecycle rules
aws --endpoint-url=http://localhost:4566 s3api put-bucket-lifecycle-configuration \
--bucket bansi-test \
--lifecycle-configuration file://lifecycle.json

Outcome
This project demonstrates how to simulate AWS S3 locally for testing and learning.
It’s useful for practicing AWS CLI commands, automating bucket setup, and showcasing cloud skills without incurring AWS costs.

How to Use
1.Clone the repo:
git clone git@github.com:BansiNeeraj/localstack-s3-demo.git
cd localstack-s3-demo

2.Run the automation script:
bash setup_localstack_s3.sh

