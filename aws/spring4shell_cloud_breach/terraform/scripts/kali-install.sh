#! /bin/bash
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
sudo DEBIAN_FRONTEND=noninteractive apt update -y
sudo sudo DEBIAN_FRONTEND=noninteractive apt-get install tor torbrowser-launcher -y
sudo msfdb init