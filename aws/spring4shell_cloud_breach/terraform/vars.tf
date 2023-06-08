variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "server"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "panw.pub"
}

#SSH Public Key
variable "ssh-public-key-for-ec2" {
  default = "panw.pub"
}
#SSH Private Key
variable "ssh-private-key-for-ec2" {
  default = "panw"
}

variable "ssh_user" {
  description = "SSH user name to connect to your instance."
  default     = "ubuntu"
}

variable "instance_count" {
  default = "2"
}

variable "cg_whitelist" {
  default = "0.0.0.0/0"
}

variable "cgid" {

}