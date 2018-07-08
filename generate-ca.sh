
echo "Generate CA certificate"
mkdir output/ca -p
cfssl gencert -initca ca-csr.json | cfssljson -bare output/ca/ca

