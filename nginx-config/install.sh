#!/bin/bash

BLUE='\e[34m'

echo -e "${BLUE}##########################################################################"
echo -e "${BLUE}[INFO] NODE MANAGER - INITIALIZING SCRIPT"
echo -e "${BLUE}##########################################################################"

sudo apt-get clean && sudo apt-get update

sudo apt install nginx -y

# Remove Default Confs
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-enabled/default
rm -f /etc/nginx/nginx.conf

echo -e "${BLUE}[INFO] ADDING OPENSSL CERTIFICATES "
# Configure OpenSSL 1.1.1
# https://docs.oracle.com/cd/E24191_01/common/tutorials/authz_cert_attributes.html
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout server.key -out server.crt -subj '/C=BR/L=Foz do Iguacu/O=Uniamerica/OU=Eng/CN=example' \
  -addext 'subjectAltName=DNS:example.com,DNS:www.example.com,IP:192.168.10.10,IP:127.0.0.1'

openssl x509 -noout -text -in server.crt

mkdir -p /etc/nginx/ssl
mv server.* /etc/nginx/ssl/

# Default Conf
mv /tmp/nginx/nginx.conf /etc/nginx/nginx.conf

# General Configs
mv /tmp/nginx/conf.d/*.conf /etc/nginx/conf.d/

# Load Balancer
mv /tmp/nginx/sites-available/load_balancer.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/load_balancer.conf /etc/nginx/sites-enabled/load_balancer.conf

sudo service nginx restart
