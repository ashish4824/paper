# Variables for AWS Infrastructure Module

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "instance_type" {
  description = "The type of AWS EC2 instance to deploy"
  type        = string
}

variable "key_name" {
  description = "The name of the AWS key pair to use for SSH access"
  type        = string
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}