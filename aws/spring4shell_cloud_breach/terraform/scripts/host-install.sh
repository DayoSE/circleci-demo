#! /bin/bash
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install maven -y 
sudo apt-get install default-jdk -y
sudo apt-get install unzip -y
