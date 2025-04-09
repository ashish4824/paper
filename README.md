# Paper.Social Multi-Cloud DevOps Setup

## Project Overview

This repository contains the infrastructure as code, configuration management, and CI/CD pipeline for Paper.Social's multi-cloud deployment across AWS and IBM Cloud. The setup ensures resilience and flexibility by distributing the application across multiple cloud providers.

## Architecture

The infrastructure is designed with the following components:

- **Infrastructure as Code (IaC)**: Terraform modules for AWS and IBM Cloud
- **Configuration Management**: Ansible playbooks for server configuration
- **CI/CD Pipeline**: GitHub Actions for automated deployment
- **Monitoring and Logging**: Prometheus, Grafana, and Loki stack
- **Sample Application**: A simple "Hello, Paper.Social" web application

## Repository Structure

```
├── terraform/
│   ├── aws/           # AWS infrastructure modules
│   ├── ibm/           # IBM Cloud infrastructure modules
│   └── main.tf        # Main Terraform configuration
├── ansible/
│   ├── playbooks/     # Ansible playbooks for configuration
│   └── inventory/     # Dynamic inventory scripts
├── app/
│   └── ...            # Sample application code
├── .github/
│   └── workflows/     # GitHub Actions CI/CD pipeline
├── monitoring/
│   └── ...            # Monitoring and logging configuration
└── README.md          # This documentation
```

## Setup Instructions

### Prerequisites

- Terraform >= 1.0.0
- Ansible >= 2.9.0
- AWS CLI configured with appropriate credentials
- IBM Cloud CLI configured with appropriate credentials
- GitHub account for CI/CD pipeline

### Infrastructure Deployment

1. Clone this repository:
   ```bash
   git clone https://github.com/ashish4824/paper.git
   cd paper-social
   ```

2. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

3. Deploy the infrastructure:
   ```bash
   terraform apply
   ```

4. Run Ansible playbooks to configure servers:
   ```bash
   cd ../ansible
   ansible-playbook -i inventory playbooks/setup.yml
   ```

## CI/CD Pipeline

The CI/CD pipeline is implemented using GitHub Actions and automatically:

1. Triggers on every push to the main branch
2. Builds and tests the application
3. Deploys to both AWS and IBM Cloud environments in parallel

The pipeline workflow is defined in `.github/workflows/ci-cd.yml`.

## Monitoring and Logging

The monitoring stack consists of:

- **Prometheus**: For metrics collection
- **Grafana**: For visualization
- **Loki**: For log aggregation

Access the monitoring dashboard at: `http://localhost:3000`

## Security Considerations

- IAM roles with least privilege principle
- Security groups with restricted access
- Encrypted volumes for sensitive data
- HTTPS for all public endpoints
- Secrets management using GitHub Secrets

## Cost Optimization

- AWS t3.micro instances for development environments
- IBM Cloud Lite tier resources where possible
- Auto-scaling based on demand
- Spot instances for non-critical workloads

## Scalability

The infrastructure is designed to scale horizontally with minimal changes:

- Auto-scaling groups for compute resources
- Load balancers for traffic distribution
- Containerized applications for consistent deployment

## Assumptions and Design Decisions

- Multi-cloud approach prioritizes resilience over cost optimization
- GitHub Actions chosen for CI/CD due to tight GitHub integration
- Prometheus stack selected for its open-source nature and flexibility
- Docker used for application containerization to ensure consistency

## Troubleshooting

Common issues and their solutions:

- **Terraform state lock**: Delete the lock file in the S3 bucket
- **Ansible connection issues**: Verify security group rules and SSH keys
- **CI/CD pipeline failures**: Check GitHub Actions logs for details

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT