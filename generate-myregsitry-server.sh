
echo "Generate Certificate from CA for Registry"
mkdir output/myregsitry-server -p

cfssl gencert -ca=output/ca/ca.pem -ca-key=output/ca/ca-key.pem -config=ca-config.json -profile=server myregsitry-server-csr.json | cfssljson -bare output/myregsitry-server/myregsitry-server
