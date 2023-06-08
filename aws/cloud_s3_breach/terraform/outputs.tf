
#Required: Always output the AWS Account ID
output "panw_output_aws_account_id" {
  value = "${data.aws_caller_identity.aws-account-id.account_id}"
}
output "panw_output_target_ec2_server_ip" {
  value = "${aws_instance.ec2-vulnerable-proxy-server.public_ip}"
}