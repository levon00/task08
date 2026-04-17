Azure Cloud-Native Containerized Infrastructure

This project demonstrates a production-ready, cloud-native architecture on Microsoft Azure, fully automated using Terraform. It implements a containerized Python application deployed across multiple Azure compute services (ACI and AKS), utilizing managed services for state (Redis) and security (Key Vault).

Architecture Overview

The infrastructure is designed to solve environment consistency issues by leveraging immutable container images and Infrastructure as Code (IaC).

Components

Azure Container Registry (ACR): Acts as the central hub for Docker images, utilizing ACR Tasks to automate the building of images directly from source code.

Azure Kubernetes Service (AKS): A managed Kubernetes cluster for scalable, production-grade orchestration. It uses the Secrets Store CSI Driver to securely pull environment variables from Key Vault.

Azure Container Instance (ACI): Used for lightweight, isolated container execution, providing a secondary deployment target for the application.

Azure Cache for Redis: A managed, in-memory data store used by the application to track visit counts across sessions.

Azure Key Vault: Centralized secret management, storing Redis connection strings and access keys to ensure no sensitive data is hardcoded.

Project Structure

The project is organized into reusable Terraform modules:

.
└── task08

    ├── application/             # Python Flask app, Dockerfile, and dependencies
    ├── k8s-manifests/           # Kubernetes YAML templates (Deployment, Service, Secret Provider)
    ├── modules/
    │   ├── aci/                 # Container Instance configuration
    │   ├── acr/                 # Container Registry & Build Tasks
    │   ├── aks/                 # Managed Kubernetes Cluster & IAM roles
    │   ├── keyvault/            # Secret storage & Access policies
    │   └── redis/               # Redis Cache instance & Secret injection
    ├── main.tf                  # Root orchestration
    ├── variables.tf             # Global input definitions
    └── versions.tf              # Provider configurations (AzureRM, Kubectl, Kubernetes)
Infrastructure Features
Automated Image Pipeline

Instead of local Docker builds, this project uses ACR Tasks. It connects to the source repository via a Personal Access Token (PAT) and builds the image inside Azure, ensuring a clean and consistent build environment.

Security & Identity

Managed Identities: AKS uses a Managed Identity to authenticate with Key Vault and ACR.

Secrets Store CSI Driver: Secrets are mounted directly into the AKS pods as volumes or environment variables, ensuring that sensitive data like REDIS_PWD never touches the disk in plaintext.

Network Security: Communication with Redis is forced over SSL (Port 6380).

Deployment Logic

The application is deployed twice to demonstrate different hosting models:

ACI Deployment: Configured with a public FQDN and specific environment variables identifying it as the "ACI" instance.

AKS Deployment: Orchestrated via the kubectl Terraform provider, utilizing a LoadBalancer to expose the application to the internet.

Configuration Parameters

The following resource specifications are implemented:

Resource	SKU/Type
AKS Node Pool	Standard_D2ads_v6 (Ephemeral OS disk)
Redis Cache	Basic C2
Container Registry	Basic
Key Vault	Standard
Deployment

Initialize Terraform:

code
Bash
download
content_copy
expand_less
terraform init

Plan the Deployment:
You will need to provide the git_pat variable for the ACR task to access the source code.

code
Bash
download
content_copy
expand_less
terraform plan -var="git_pat=your_personal_access_token"

Apply Infrastructure:

code
Bash
download
content_copy
expand_less
terraform apply -var="git_pat=your_personal_access_token"
Outputs

Upon successful completion, the project provides:

aci_fqdn: The Fully Qualified Domain Name to access the app on ACI.

aks_lb_ip: The public Load Balancer IP address for the AKS deployment.

Application Functionality

The application displays a greeting message (unique to the environment) and a visit counter. The counter persists in the Azure Redis Cache, demonstrating successful integration between the compute layers and the data layer.
