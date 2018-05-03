/bin/sh -c bitcoind daemon

address=`bitcoin-cli getnewaddress`
sed -i.bak "s/<issuing-address>/$address/g" /cert-issuer/conf.ini
bitcoin-cli dumpprivkey $address > /cert-issuer/pk_issuer.txt
bitcoin-cli generate 101
bitcoin-cli getbalance
bitcoin-cli sendtoaddress $address 5

cd /cert-issuer

aws s3 cp s3://issuer-data/$issuer/$batchId/unissued-certs/ /cert-issuer/data/unsigned_certificates/ --recursive

cert-issuer -c conf.ini

aws s3 cp /cert-issuer/data/blockchain_certificates/ s3://issuer-data/$issuer/$batchId/blockchain-certs/ --recursive
aws s3 cp s3://issuer-data/$issuer/$batchId/unissued-certs/mapping.csv s3://issuer-data/$issuer/$batchId/blockchain-certs/mapping.csv

