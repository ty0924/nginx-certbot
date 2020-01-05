#!/bin/bash

read -p "Enter domain: " -e -i 'example.org' domain || domain=example.org
read -p "Enter proxy: " -e -i 'localhost:8080' proxy || proxy=localhost:8080
read -p "Enter email: " -e -i 'email@email.com' email || email=email@email.com

printf "\n${domain}"
printf "\n${proxy}"
printf "\n${email}\n"

cp -rf __init-letsencrypt.sh init-letsencrypt.sh
cp -rf data/nginx/__app.conf.base data/nginx/app.conf

sed -i "s/email@email.com/${email}/g" init-letsencrypt.sh
sed -i "s/example.org/${domain}/g" init-letsencrypt.sh

sed -i "s/example.org/${domain}/g" data/nginx/app.conf
sed -i "s/localhost:8080/${proxy}/g" data/nginx/app.conf

./init-letsencrypt.sh
docker-compose up
