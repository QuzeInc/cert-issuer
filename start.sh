
cd /cert-issuer

aws s3 cp s3://issuer-data/$issuer/$batchId/unissued-certs/ /cert-issuer/data/unsigned_certificates/ --recursive

cert-issuer -c conf.ini

aws s3 cp /cert-issuer/data/blockchain_certificates/ s3://issuer-data/$issuer/$batchId/blockchain-certs/ --recursive
aws s3 cp s3://issuer-data/$issuer/$batchId/unissued-certs/mapping.csv s3://issuer-data/$issuer/$batchId/blockchain-certs/mapping.csv

