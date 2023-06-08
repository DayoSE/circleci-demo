#Required: AWS Region
variable "region" {
  default = "us-east-1"
}
#Required: CGID Variable for unique naming
variable "cgid" {

}
#Required: User's Public IP Address(es)
variable "cg_whitelist" {
  default = "whitelist.txt"
}
#SSH Public Key
variable "ssh-public-key-for-ec2" {
  default = "panw.pub"
}
#SSH Private Key
variable "ssh-private-key-for-ec2" {
  default = "panw"
}
#Stack Name
variable "stack-name" {
  default = "panw"
}
#Scenario Name
variable "scenario-name" {
  default = "cloud-s3-breach"
}