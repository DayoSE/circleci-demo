resource "aws_security_group" "spring4shell-allow-ssh" {
  vpc_id      = aws_vpc.spring4shell-dev-vpc-main.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port = 0
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.cg_whitelist]
  }

  tags = {
    Name = "spring4shell-allow-ssh"
  }
}


resource "aws_security_group" "spring4shell-port_80" {
  vpc_id      = aws_vpc.spring4shell-dev-vpc-main.id
  name        = "spring4shell-port_80"
  description = "Enable HTTP access on port 80 "

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.cg_whitelist]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [
      "${aws_security_group.spring4shell-allow-ssh.id}",
    ]
  }

  tags = {
    Name = "Port 80"
  }
}