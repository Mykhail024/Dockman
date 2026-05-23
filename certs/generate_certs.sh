#!/usr/bin/env bash
set -euo pipefail

DAYS_CA="${DAYS_CA:-3650}"
DAYS_CERT="${DAYS_CERT:-825}"
SERVER_CN="${SERVER_CN:-127.0.0.1}"
CLIENT_CN="${CLIENT_CN:-dockman-client}"
GENERATE_CLIENT="${GENERATE_CLIENT:-0}"

cat > server-san.cnf <<'EOF'
[req]
prompt = no
distinguished_name = dn
req_extensions = req_ext

[dn]
CN = 127.0.0.1

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1
EOF

cat > server-ext.cnf <<'EOF'
[server_cert]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1
EOF

openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days "$DAYS_CA" -out ca.crt -subj "/CN=Dockman Local CA"

openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -config server-san.cnf
openssl x509 -req \
  -in server.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -out server.crt \
  -days "$DAYS_CERT" \
  -sha256 \
  -extfile server-ext.cnf \
  -extensions server_cert

if [[ "$GENERATE_CLIENT" == "1" ]]; then
  openssl genrsa -out client.key 2048
  openssl req -new -key client.key -out client.csr -subj "/CN=$CLIENT_CN"
  openssl x509 -req \
    -in client.csr \
    -CA ca.crt \
    -CAkey ca.key \
    -CAcreateserial \
    -out client.crt \
    -days "$DAYS_CERT" \
    -sha256
fi

rm -f server-san.cnf server-ext.cnf server.csr client.csr ca.srl
echo "Done"
