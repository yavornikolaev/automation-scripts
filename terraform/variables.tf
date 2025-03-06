# Define AWS region
variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "eu-central-1"  # You can set your preferred region here
}

# Define the SSH key name
variable "key_name" {
  description = "The name of the SSH key pair."
  type        = string
  default     = "my-ssh-key"  # Default key name if not provided
}

# Define the path to the public key file
variable "public_key_path" {
  description = "Path to the public SSH key file."
  type        = string
  default     = "~/.ssh/id_rsa.pub"  # Default public key path
}

# Define the AMI ID for the EC2 instance
variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ami-07eef52105e8a2059"  # Default Ubuntu 22.04 LTS AMI for eu-central-1
}

# Define the EC2 instance type
variable "instance_type" {
  description = "The type of EC2 instance."
  type        = string
  default     = "t2.micro"  # Default instance type
}

# Define the size of the EBS volume
variable "volume_size" {
  description = "The size of the root EBS volume in GB."
  type        = number
  default     = 8  # Default volume size (8GB)
}

# Define the name of the EC2 instance
variable "instance_name" {
  description = "The name to assign to the EC2 instance."
  type        = string
  default     = "MyUbuntuServer"  # Default instance name
}
