# IBM Cloud Infrastructure Module

# Define IBM Cloud VPC
resource "ibm_is_vpc" "paper_social_vpc" {
  name = "${var.app_name}-vpc"
  resource_group = data.ibm_resource_group.group.id
  tags = [
    "app:${var.app_name}",
    "environment:${var.environment}"
  ]
}

# Create a public subnet
resource "ibm_is_subnet" "public_subnet" {
  name            = "${var.app_name}-subnet"
  vpc             = ibm_is_vpc.paper_social_vpc.id
  zone            = "${var.ibm_region}-1"
  ipv4_cidr_block = "10.240.0.0/24"
  resource_group  = data.ibm_resource_group.group.id
}

# Create Security Group
resource "ibm_is_security_group" "app_sg" {
  name           = "${var.app_name}-sg"
  vpc            = ibm_is_vpc.paper_social_vpc.id
  resource_group = data.ibm_resource_group.group.id
}

# Security Group Rules

# SSH access
resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.app_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

# HTTP access
resource "ibm_is_security_group_rule" "http" {
  group     = ibm_is_security_group.app_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 80
    port_max = 80
  }
}

# HTTPS access
resource "ibm_is_security_group_rule" "https" {
  group     = ibm_is_security_group.app_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 443
    port_max = 443
  }
}

# Application port
resource "ibm_is_security_group_rule" "app" {
  group     = ibm_is_security_group.app_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 3000
    port_max = 3000
  }
}

# Prometheus
resource "ibm_is_security_group_rule" "prometheus" {
  group     = ibm_is_security_group.app_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 9090
    port_max = 9090
  }
}

# Grafana
resource "ibm_is_security_group_rule" "grafana" {
  group     = ibm_is_security_group.app_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 3000
    port_max = 3000
  }
}

# Outbound traffic
resource "ibm_is_security_group_rule" "outbound" {
  group     = ibm_is_security_group.app_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

# Get default resource group
data "ibm_resource_group" "group" {
  name = "Default"
}

# Find the SSH key
data "ibm_is_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}

# Create a floating IP
resource "ibm_is_floating_ip" "app_ip" {
  name   = "${var.app_name}-ip"
  target = ibm_is_instance.app_server.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.group.id
}

# Create Virtual Server Instance
resource "ibm_is_instance" "app_server" {
  name           = "${var.app_name}-server"
  vpc            = ibm_is_vpc.paper_social_vpc.id
  zone           = "${var.ibm_region}-1"
  profile        = var.instance_profile
  image          = data.ibm_is_image.ubuntu.id
  keys           = [data.ibm_is_ssh_key.ssh_key.id]
  resource_group = data.ibm_resource_group.group.id

  primary_network_interface {
    subnet          = ibm_is_subnet.public_subnet.id
    security_groups = [ibm_is_security_group.app_sg.id]
  }

  boot_volume {
    name = "${var.app_name}-boot-volume"
    encryption = "crn:v1:bluemix:public:kms:::::"
  }

  tags = [
    "app:${var.app_name}",
    "environment:${var.environment}"
  ]
}

# Get latest Ubuntu image
data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-20-04-minimal-amd64-2"
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = ibm_is_floating_ip.app_ip.address
}