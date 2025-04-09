# Variables for IBM Cloud Infrastructure Module

variable "ibm_region" {
  description = "The IBM Cloud region to deploy resources"
  type        = string
}

variable "instance_profile" {
  description = "The profile of IBM Cloud instance to deploy"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the IBM Cloud SSH key to use for access"
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