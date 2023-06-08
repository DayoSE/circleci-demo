resource "aws_key_pair" "server-key" {
  key_name   = "server-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
