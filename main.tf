provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "LB" {
  ami           = "ami-08eebff62e61110b7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.assignment_sg_22.id, aws_security_group.assignment_sg_80.id]

  associate_public_ip_address = true
  private_ip = "192.168.0.11"
  subnet_id     = "subnet-0307d1cd5048f1c64"
  key_name = "${aws_key_pair.ssh_key.key_name}"

  tags = {
    Name = "LB server"
  }
}

resource "aws_instance" "WEB" {
  ami           = "ami-08eebff62e61110b7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.assignment_sg_22.id]
  associate_public_ip_address = true
  private_ip = "192.168.0.12"
  subnet_id     = "subnet-0307d1cd5048f1c64"
  key_name = "${aws_key_pair.ssh_key.key_name}"

  tags = {
    Name = "WEB server"
  }
}

resource "aws_instance" "DB" {
  ami           = "ami-08eebff62e61110b7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.assignment_sg_22.id]
  associate_public_ip_address = true
  private_ip = "192.168.0.13"
  subnet_id     = "subnet-0307d1cd5048f1c64"
  key_name = "${aws_key_pair.ssh_key.key_name}"


  tags = {
    Name = "DB server"
  }
}



variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

resource "aws_security_group" "assignment_sg_80" {
  name = "assignment_sg_80"
  vpc_id = "vpc-02fb7f12a3c909001"

}

resource "aws_security_group" "assignment_sg_22" {
  name = "assignment_sg_22"
  vpc_id = "vpc-02fb7f12a3c909001"

}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCC1NtnYbrwGTEGDOtBNnfiVnWpry46gIMI8uasF82p+QKEkya7B8fM93fu7VsveLQbyVM/fZNsxs7J+WLaj+XkvEQDQyIdvcZSwQNi4GNi8+aBrbeO5z62v0SP7ZcPqL100xfRykyUHssqFjXLJMaP673fZk993sYoQailpJI1mrmIrWrl6p9fsNKxXSk8DJ9cgD+WxUnHyqvT0MWHTjPMbZePDZmQJAfItqpQubLseMbGLsv1frLppUdcAzEg+KrTN4kOZHxSp+eO6ZixPdsfOed61pAhhvUmU06+wNX2xeIviYIMXNa5GoLKI/ZBvXWM9AOJYoN7XkSZWFmPiBb1 imported-openssh-key"
}



output "public_ip" {
  value       = aws_instance.LB.public_ip
  description = "The public IP of the web server"
}

