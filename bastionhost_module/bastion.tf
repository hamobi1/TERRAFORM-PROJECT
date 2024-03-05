resource "aws_security_group" "bastion_sg" {
  name        = "bastion-security-group"
  description = "Security group allowing SSH inbound and HTTP outbound traffic"
   vpc_id      = var.vpc_id

  # Inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule for HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "bastion_key"
  public_key = var.ssh_public_key 
}


# Create bastion host
resource "aws_instance" "bastion" {
  ami                    = var.ami  
  instance_type          = var.instance_type      
  subnet_id              = var.public_subnet_id
  associate_public_ip_address = true
  key_name               = aws_key_pair.ssh_key.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  
  user_data = <<-EOT
    #!/bin/bash
    echo "${aws_key_pair.ssh_key.public_key}" >> /home/ec2-user/.ssh/authorized_keys
  EOT

  tags = {
    Name = "bastion-host"
  }
}

# Create private instance with Nginx
resource "aws_instance" "private_instance" {
  ami                    = var.ami   
  instance_type          = var.instance_type     
  subnet_id              = var.private_subnet_id
  associate_public_ip_address = false
  key_name               = aws_key_pair.ssh_key.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  user_data = <<-EOT
    #!/bin/bash
    echo "${aws_key_pair.ssh_key.public_key}" >> /home/ec2-user/.ssh/authorized_keys
    cp /Users/muratnesiren14/TERRAFORM-PROJECT/index (1).html /usr/share/nginx/html/index.html
    systemctl restart nginx
  EOT

  tags = {
    Name = "private-instance"
  }
}

