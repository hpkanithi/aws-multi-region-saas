# Multi-Region AWS SaaS Platform (Terraform + ECS + CI/CD)
> Production-grade multi-region AWS architecture with CI/CD, monitoring, and disaster recovery design.

## Overview
This project showcases a production-grade multi-region AWS SaaS architecture built using Terraform and ECS Fargate, featuring environment-aware CI/CD pipelines, approval-gated infrastructure deployments, and integrated monitoring.

## Key Features
- Infrastructure as Code (Terraform modules)
- Containerized application - Docker + ECS Fargate
- Environment-aware CI/CD pipelines - GitHub Actions
- Approval-gated infrastructure changes
- Multi-region disaster recovery setup
- CloudWatch-based monitoring and alerting

The system is designed with **scalability, resilience, and operational control** in mind.

## Capabilities

- Deploy infrastructure using Terraform with remote state (S3 + DynamoDB)
- Deploy applications via GitHub Actions to ECS Fargate
- Enforce approval gates for infrastructure changes
- Run identical stacks across multiple AWS regions
- Monitor application and infrastructure health using CloudWatch
- Support disaster recovery architecture with a secondary region

## Architecture
```plaintext
                        ┌───────────────────────────┐
                        │     CI/CD Pipeline        │
                        │     (GitHub Actions)      │
                        └────────────┬──────────────┘
                                     │
                                     ▼
                            ┌────────────────┐
                            │   Amazon ECR   │
                            └───────┬────────┘
                                    │
               ┌────────────────────┴────────────────────┐
               │                                         │
               ▼                                         ▼
┌──────────────────────────────┐        ┌──────────────────────────────┐
│   Primary Region (us-east-1) │        │  Standby Region (us-west-2)  │
│                              │        │                              │
│        ┌────────────┐        │        │        ┌────────────┐        │
│ User → │    ALB     │        │        │        │    ALB     │        │
│        └─────┬──────┘        │        │        └─────┬──────┘        │
│              │               │        │              │               │
│              ▼               │        │              ▼               │
│        ┌────────────┐        │        │        ┌────────────┐        │
│        │ ECS Fargate│        │        │        │ ECS Fargate│        │
│        │ (App)      │        │        │        │ (App)      │        │
│        └────────────┘        │        │        └────────────┘        │
│                              │        │                              │
└──────────────┬───────────────┘        └──────────────┬───────────────┘
               │                                       │
               └──────────────┬────────────────────────┘
                              ▼
                   ┌────────────────────────┐
                   │  CloudWatch Monitoring │
                   └────────────────────────┘

        ─ ─ ─ ─ ─ Route 53 Failover (Planned) ─ ─ ─ ─ ─

                   ┌────────────────────────┐
                   │ Terraform Backend      │
                   │ (S3 + DynamoDB)        │
                   └────────────────────────┘

```

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
- `dr` - disaster recovery environment in a secondary region for failover readiness
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

Supports:
- environment-specific secrets
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

- Designed with a clear separation between application and infrastructure pipelines to align with real-world DevOps practices

## 🧪 How to Run

### Deploy infrastructure

In the local environment, through bash or powershell.
```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

### Deploy Application

Go to GitHub repository, the GitHub Actions.
- Run Deploy App to ECS
- Select the environment

### Screenshots

The following screenshots demonstrate successful deployment and operation:

- ECS service running tasks
- ALB endpoint responding with application output
- CloudWatch alarms configured and active
- Terraform infrastructure deployment
- GitHub Actions approval workflow

### Future Enhancements

- Route 53 failover - designed for DNS-based traffic routing but not fully deployed due to lack of domain configuration
- Auto Failover testing
- SNS notifications for alarms
- Blue/Green Deployments

### Key Takeaways

This project demonstrates:

- End-to-end cloud infrastructure automation
- CI/CD pipeline design with approval gates
- Traffic failover is designed using a primary-secondary model, where the DR region can serve traffic during primary region failure.
- Observability integration
- Cost-aware DevOps practices
- Demonstrates real-world DevOps practices including environment isolation, deployment safety, and multi-region resilience

### Author
**Hema Praharsha Kanithi**
- GitHub: https://github.com/hpkanithi
- Linkedin: https://www.linkedin.com/in/hema-praharsha-kanithi-100aa1287/