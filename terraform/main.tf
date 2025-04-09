# Main Terraform configuration file

# Configure AWS provider
provider "aws" {
  region = var.aws_region
}

# Configure IBM Cloud provider
provider "ibm" {
  region = var.ibm_region
}

# AWS Infrastructure Module
module "aws_infrastructure" {
  source = "./aws"
  
  aws_region = var.aws_region
  instance_type = var.aws_instance_type
  key_name = var.aws_key_name
  app_name = var.app_name
  environment = var.environment
}

# IBM Cloud Infrastructure Module
module "ibm_infrastructure" {
  source = "./ibm"
  
  ibm_region = var.ibm_region
  instance_profile = var.ibm_instance_profile
  ssh_key_name = var.ibm_ssh_key_name
  app_name = var.app_name
  environment = var.environment
}

# Output the public IPs of the instances for Ansible inventory
output "aws_instance_ip" {
  value = module.aws_infrastructure.instance_public_ip
  description = "The public IP of the AWS instance"
}

output "ibm_instance_ip" {
  value = module.ibm_infrastructure.instance_public_ip
  description = "The public IP of the IBM Cloud instance"
}