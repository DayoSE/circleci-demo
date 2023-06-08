#! /bin/bash
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
sudo apt update -y
sudo apt install docker.io -y
sudo apt install curl -y
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker 
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
cd /tmp/vuln_app && sudo docker-compose up -d 

