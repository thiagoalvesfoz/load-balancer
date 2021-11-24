#!/bin/bash

BLUE='\e[34m'

echo -e "${BLUE}######################################################################################################"
echo -e "${BLUE} INSTALL DOCKER - DOC: https://docs.docker.com/engine/install/ubuntu/"
echo -e "${BLUE}######################################################################################################"

sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y

usermod -aG docker vagrant

echo -e "${BLUE}DOCKER INSTALLED"

docker run -d --name app_1 -p 8081:80 thiagoalvesfoz/hello-world:latest
docker run -d --name app_2 -p 8082:80 thiagoalvesfoz/hello-world:latest