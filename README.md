# Multi-Region AWS SaaS Platform

## Overview
This project demonstrates a production-style multi-region AWS architecture using Terraform and ECS Fargate.

## Key Features
- Infrastructure as Code - Terraform modules
- Containerized application - Docker + ECS Fargate
- Environment-aware CI/CD pipelines - GitHub Actions
- Approval-gated infrastructure changes
- Multi-region disaster recovery setup
- CloudWatch-based monitoring and alerting

The system is designed with **scalability, resilience, and operational control** in mind.


## Architecture (Coming Soon)
Diagram will be added.

## ⚙️ Tech Stack

- **Cloud**: AWS (VPC, ALB, ECS Fargate, CloudWatch, ECR)
- **IaC**: Terraform (modular design)
- **CI/CD**: GitHub Actions
- **Containerization**: Docker
- **State Management**: S3 + DynamoDB (remote backend)


## 🏗️ Infrastructure Design

### Environments

- `dev` - used as testing environment  
- `prod` - created as primary production environment  
- `dr` - disaster recovery (secondary region) for multi- region purpose 
- `global` - shared/global services (Route 53 - planned for failover scenario)


### Terraform Modules

- `vpc` - networking (subnets, routing)
- `security_groups`
- `alb` - load balancer + target groups
- `ecs` - cluster, service, task definition
- `monitoring` - CloudWatch alarms
- `route53_failover` - (planned DNS failover)

## 🔁 CI/CD Pipelines

### App Deployment

- Manual trigger (environment selection)
- Builds Docker image
- Pushes to ECR
- Deploys to ECS

Supports - environment-specific secrets
- dev deployment
- prod deployment

### Infrastructure Deployment

- Push → Terraform **plan**
- Manual trigger → Terraform **apply**
- Approval required before apply

Ensures:
- controlled infrastructure changes
- no accidental deployments
- cost-aware workflow

## 📊 Monitoring & Observability

CloudWatch alarms are configured for:

- ECS CPU utilization
- ECS memory utilization
- ALB 5XX errors
- Target group unhealthy hosts

Provides visibility into:
- application health
- infrastructure performance

## 🌍 Multi-Region Strategy

- Primary region: `us-east-1`
- Secondary region (DR): `us-west-2`

DR environment mirrors production infrastructure and can serve traffic during failures.

## 🔐 Design Decisions

- **Approval-based infra deployment** → prevents unintended AWS costs  
- **Separate app & infra pipelines** → clean DevOps separation  
- **Remote Terraform state** → enables team-safe workflows  
- **Modular Terraform design** → reusable and scalable  
- **Manual DR activation** → cost-optimized for non-production use  

## 🧪 How to Run

### Deploy infrastructure

In the local environment, through bash or powershell.

`cd terraform/environments/dev`
`terraform init`
`terraform plan`
`terraform apply`

### Deploy Application

Go to GitHub repository, the GitHub Actions.
- Run Deploy App to ECS
- Select the environment

### Screenshots
The screenshots added here are for each module upon successful deployment.

`ECS`
`ALB`
`VPC`
`CloudWatch`
`GitHub Actions Approval`

### Future Enhancements

- Route 53 failover - the DNS -based traffic routing is placed in the project but could not deploy due to unavailability of domain name.
- Auto Failover testing
- SNS notifications for alarms
- Blue/Green Deployments

### Key Takeaways

This project demonstrates:

- End-to-end cloud infrastructure automation
- CI/CD pipeline design with approval gates
- Multi-region deployment strategy
- Observability integration
- Cost-aware DevOps practices

### Author
**Hema Praharsha Kanithi**
GitHub: https://github.com/hpkanithi
Linkedin: https://www.linkedin.com/in/hema-praharsha-kanithi-100aa1287/