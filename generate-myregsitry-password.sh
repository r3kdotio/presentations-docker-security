mkdir -p auth
docker run --entrypoint htpasswd registry:2 -Bbn user1 password1 > auth/htpasswd

