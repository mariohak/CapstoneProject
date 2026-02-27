# 🏗 Automated WordPress Infrastructure on AWS using Terraform

> Production-style Infrastructure as Code deployment of a secure WordPress environment on AWS.

---

## 📌 Executive Summary

This project demonstrates the implementation of a secure, automated, and reproducible WordPress deployment on Amazon Web Services (AWS) using Terraform and Terraform Cloud.

The infrastructure is fully defined as code, version-controlled via GitHub, and deployed through a remote execution workflow, following modern DevOps and Infrastructure as Code (IaC) principles.

The architecture enforces network isolation, security best practices, and automated application provisioning.

---

## 🧱 Architecture Overview

### Core Components

- **Custom VPC**
- **Public Subnet** (Web Layer)
- **Private Subnet** (Database Layer)
- **Internet Gateway**
- **Route Tables**
- **Security Groups**
- **EC2 Instance** (Apache + PHP + WordPress)
- **RDS MySQL Instance** (Private)
- **Terraform Cloud Workspace**

### Architectural Principles

✔ Network Segmentation  
✔ Least Privilege Access  
✔ Infrastructure as Code  
✔ Automated Provisioning  
✔ Layered Security Model  

---

## 🌐 High-Level Architecture

![Flow](images/Flow.png)


---

## 🔐 Security Architecture

Security is implemented through multiple layers:

### Network Isolation
- Web server deployed in a public subnet
- Database deployed in a private subnet
- No direct internet access to database

### Security Groups (Firewall Rules)

**EC2 Security Group**
- Allows HTTP (Port 80) from 0.0.0.0/0
- Allows SSH (Port 22) restricted to specific IP
- Allows outbound traffic

**RDS Security Group**
- Allows MySQL (Port 3306)
- Source restricted to EC2 Security Group
- No public access

This approach follows the principle of **least privilege** and reduces the attack surface.

---

## ⚙️ Infrastructure as Code Implementation

The infrastructure is defined using Terraform configuration files.

### Key Features

- Modular resource definition
- Remote state management via Terraform Cloud
- Automated execution pipeline
- Parameterized configuration using variables
- Dynamic AMI retrieval via AWS SSM Parameter Store

---

## 🔄 DevOps Workflow

### Development Lifecycle

1. Infrastructure code written in **Visual Studio Code**
2. Code pushed to **GitHub**
3. Terraform Cloud connected to repository
4. Automatic `plan` and `apply` triggered
5. Infrastructure provisioned on AWS

This workflow ensures:

- Version control
- Change tracking
- Deployment automation
- Consistent environments
- Reduced configuration drift

---

## 🚀 Automated Application Provisioning

The EC2 instance executes a `user_data` bootstrap script at launch.

### Automated Tasks

- Apache installation
- PHP installation
- WordPress download & configuration
- Database connection setup
- File permissions configuration

Result:
The application is fully functional immediately after infrastructure deployment.

---

## 📁 Repository Structure
.
├── providers.tf
├── wordpress.sh.tpl
├── network.tf
├── security.tf
├── ec2.tf
├── rds.tf
├── variables.tf
├── data.tf
└── output.tf


---

## 🛠 Technology Stack

- Terraform
- Terraform Cloud
- AWS EC2
- AWS RDS (MySQL)
- AWS VPC & Networking
- GitHub
- Apache
- PHP
- WordPress

---

## 📊 Deployment Steps (Local Execution)

```bash
terraform init
terraform plan
terraform apply
```

Alternatively, deployment is triggered automatically via Terraform Cloud upon GitHub push.

---

🎯 Key Learning Outcomes

 -  Cloud networking and VPC design

 -   Subnet isolation strategies

 -   Security group configuration

 -   Terraform state management

 -   DevOps workflow integration

 -   Infrastructure automation best practices


---

📄 License

This project is developed for educational and demonstration purposes.