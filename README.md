🚀 Flask App CI/CD with Jenkins, Docker, AWS ECR & ECS (Fargate)

This project demonstrates a DevOps pipeline to build, containerize, and deploy a simple Flask application onto AWS ECS using Fargate.
It uses Jenkins, Docker, and AWS (ECR + ECS) for a complete CI/CD workflow.

📌 CI/CD Pipeline

Jenkins pipeline executes the following stages:

✅ Checkout source code from GitHub

✅ Build Docker image for Flask app

✅ Push Docker image to AWS ECR

✅ Deploy container to AWS ECS (Fargate)

AWS Infrastructure

ECR (Elastic Container Registry) → Stores Docker images securely

ECS (Elastic Container Service) with Fargate → Runs containers without servers

IAM Roles & Policies → Secure access between Jenkins and AWS

📂 Project Structure
├── app/                  # Flask application source code
│   ├── app.py
│   ├── requirements.txt
|── Dockerfile            # Dockerfile for Docker Image
├── Jenkinsfile           # CI/CD pipeline definition
├── README.md             # Documentation


⚙️ Setup Instructions
1️⃣ Prerequisites

AWS Account with:

ECS Cluster (Fargate)

ECR Repository

IAM user/role with AmazonEC2ContainerRegistryFullAccess & AmazonECSFullAccess

Jenkins installed (with Docker & AWS CLI available)

GitHub repository

2️⃣ Jenkins Setup

Install Jenkins plugins:

Pipeline

Amazon EC2 Plugin (optional for agents)

AWS Steps Plugin

Configure Jenkins credentials:

aws-creds → your AWS Access Key & Secret

Add githubPush() trigger in Jenkinsfile

3️⃣ AWS Setup

Create ECR repository:

Ensure ECS Cluster & Service are created (Fargate mode).

4️⃣ GitHub Webhook

Go to Repo → Settings → Webhooks → Add Webhook

Payload URL:

http://<your-jenkins-url>/github-webhook/

Content type: application/json

Trigger on: Push events

🚀 Deployment

Push changes to main branch under /app/ directory.

Jenkins pipeline automatically:

Builds Docker image

Pushes to AWS ECR

Deploys updated task on ECS Fargate