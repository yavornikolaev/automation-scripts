provider "aws" {
  region = var.region
}

# Create a Key Pair using your existing SSH public key
resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Generate a random ID for uniqueness
resource "random_id" "sg_random" {
  byte_length = 4
}

# Create a uniquely named Security Group to allow SSH access
resource "aws_security_group" "ssh_sg" {
  name        = "allow_ssh_${random_id.sg_random.hex}"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider restricting this for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "ubuntu" {
  ami                    = var.ami_id  # Use a variable for the AMI ID
  instance_type           = var.instance_type
  key_name                = aws_key_pair.my_key.key_name
  vpc_security_group_ids  = [aws_security_group.ssh_sg.id]

  root_block_device {
    volume_size = var.volume_size  # Use a variable for volume size
  }

  tags = {
    Name = var.instance_name
  }
}