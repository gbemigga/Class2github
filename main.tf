resource "aws_instance" "aws_ubuntu" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.ubuntu.id
  key_name               = var.key_name
  user_data              = <<EOF

  #!/bin/bash
  sudo apt update -y &&
  sudo apt install -y nginx
  echo "Hello World" > /var/www/html/index.html
  EOF
}  


# Default VPC
resource "aws_default_vpc" "default" {

}

# Security group
resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "allow ssh on 22 & http on port 80"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}