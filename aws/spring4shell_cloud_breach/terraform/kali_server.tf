resource "aws_network_interface" "kali-ubuntu-lab" {
  subnet_id = aws_subnet.spring4shell-dev-main-public-2.id
  private_ips = ["10.0.2.160"]

  # the security group
  security_groups = [
    aws_security_group.spring4shell-allow-ssh.id, 
    aws_security_group.spring4shell-port_80.id
  ]

  tags = {
    Name = "kali-ubuntu-lab"
  }
}

resource "aws_instance" "kali-ubuntu-lab" {
  # subscribe kali https://aws.amazon.com/marketplace/pp/prodview-fznsw3f7mq7to
  ami = "ami-01691107cfcbce68c"
  instance_type = "t2.medium"

  network_interface {
    network_interface_id = aws_network_interface.kali-ubuntu-lab.id
    device_index = 0
  }

  root_block_device {
    volume_size = 40
    delete_on_termination = true
  }

  # the public SSH key
  key_name = "server-key"

  connection {
    user = "kali"
    host = aws_instance.kali-ubuntu-lab.public_ip
    private_key = file("panw")
  }

  provisioner "file" {
    source = "panw"
    destination = "/tmp/panw"
  }

  provisioner "file" {
    source = "scripts/kali-install.sh"
    destination = "/tmp/kali-install.sh"
  }

  provisioner "file" {
    source = "../vuln_app/exploit"
    destination = "/tmp/exploit.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/kali-install.sh",
      "/tmp/kali-install.sh",
    ]
  }

  tags = {
    Name = "kali-ubuntu-lab"
  }
}

output "vuln-kaliubuntu_server" {
  value = aws_instance.kali-ubuntu-lab.public_ip
}