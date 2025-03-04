provider "aws" {
  region = "eu-central-1"
}

# Create a Key Pair using your existing SSH public key
resource "aws_key_pair" "my_key" {
  key_name   = "my-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
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

# Create an EC2 instance in eu-central-1
resource "aws_instance" "ubuntu" {
  ami                    = "ami-07eef52105e8a2059"  # Ubuntu 22.04 LTS for eu-central-1
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  root_block_device {
    volume_size = 8  # 8GB EBS volume
  }

  tags = {
    Name = "MyUbuntuServer"
  }
}

output "instance_public_ip" {
  value = aws_instance.ubuntu.public_ip
}

