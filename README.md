# Todo App CI/CD Pipeline (Jenkins + Docker + AWS EC2)

##  Project Overview
This project demonstrates a complete CI/CD pipeline for deploying a containerized frontend application using Jenkins, Docker, and AWS EC2.

The pipeline automates the process of building, versioning, pushing, and deploying the application.

---

##  Tech Stack

- AWS EC2
- Jenkins (Docker container)
- Docker & Docker Hub
- Nginx (for serving frontend)
- GitHub (Source Code Management)

---

##  Architecture

GitHub → Jenkins Pipeline → Docker Build → Docker Hub → EC2 Deployment → Browser

---

##  CI/CD Pipeline Flow

1. Code is pushed to GitHub
2. Jenkins pulls the latest code
3. Docker image is built using Dockerfile
4. Image is tagged using build number
5. Image is pushed to Docker Hub
6. Existing container is stopped and removed
7. New container is deployed on EC2
8. Health check verifies the deployment

---

##  Docker Details

- Base Image: `nginx:alpine`
- Application served via Nginx on port 80
- Port mapping: `3000 → 80`

---

##  Security

- Docker Hub credentials stored securely in Jenkins Credentials Manager
- No hardcoded secrets in Jenkinsfile

---

##  Deployment

Application is accessible at:http://13.218.198.227:3000
