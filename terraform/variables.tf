# Variables for the main Terraform configuration

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_instance_type" {
  description = "The type of AWS EC2 instance to deploy"
  type        = string
  default     = "t3.micro"
}

variable "aws_key_name" {
  description = "The name of the AWS key pair to use for SSH access"
  type        = string
  default     = "paper-social-key"
}

variable "ibm_region" {
  description = "The IBM Cloud region to deploy resources"
  type        = string
  default     = "us-south"
}

variable "ibm_instance_profile" {
  description = "The profile of IBM Cloud instance to deploy"
  type        = string
  default     = "cx2-2x4"
}

variable "ibm_ssh_key_name" {
  description = "The name of the IBM Cloud SSH key to use for access"
  type        = string
  default     = "paper-social-key"
}

variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "paper-social"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}