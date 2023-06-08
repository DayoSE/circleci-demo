// resource "aws_network_interface" "spring4shell-ubuntu-host-lab" {
//   subnet_id = aws_subnet.spring4shell-dev-main-public-2.id
//   private_ips = ["10.0.2.162"]

//   # the security group
//   security_groups = [
//     aws_security_group.spring4shell-allow-ssh.id, 
//     aws_security_group.spring4shell-port_80.id
//   ]

//   tags = {
//     Name = "spring4shell-ubuntu-lab"
//   }
// }

// resource "aws_instance" "spring4shell-ubuntu-host-lab" {
//   ami = "ami-0e472ba40eb589f49"
//   instance_type = "t2.micro"

//   network_interface {
//     network_interface_id = aws_network_interface.spring4shell-ubuntu-host-lab.id
//     device_index = 0
//   }

//   root_block_device {
//     volume_size = 40
//     delete_on_termination = true
//   }

//   # the public SSH key
//   key_name = "server-key"

//   connection {
//     user = "ubuntu"
//     host = aws_instance.spring4shell-ubuntu-host-lab.public_ip
//     private_key = file("panw")
//   }

//   provisioner "file" {
//     source = "panw"
//     destination = "/tmp/panw"
//   }

//   provisioner "file" {
//     source = "scripts/host-install.sh"
//     destination = "/tmp/host-install.sh"
//   }

//   provisioner "file" {
//     source = "../vuln_app"
//     destination = "/tmp/vuln_app"
//   }

//   provisioner "remote-exec" {
//     inline = [
//       "chmod +x /tmp/host-install.sh",
//       "/tmp/host-install.sh",
//     ]
//   }

//   tags = {
//     Name = "spring4shell-ubuntu-host-lab"
//   }
// }

// output "vuln-spring4shellubuntu_host_server" {
//   value = aws_instance.spring4shell-ubuntu-host-lab.public_ip
// }