docker run -d   --name myregsitry   -v `pwd`/output/myregsitry-server:/certs   -e REGISTRY_HTTP_ADDR=0.0.0.0:443   -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/myregsitry-server.pem   -e REGISTRY_HTTP_TLS_KEY=/certs/myregsitry-server-key.pem   -p 443:443   registry:2

