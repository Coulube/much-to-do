# MuchTodo Container + Kubernetes Assessment (Docker + Kubernetes Kind)

This repository contains the containerization and Kubernetes deployment of the **MuchTodo backend application** (Golang API) with **MongoDB**.

✅ Backend runs on: **port 3000**  
✅ Health check endpoint: **/health**  
✅ MongoDB runs internally on: **port 27017**

---

## Repository Structure

container-assessment/
├── application-code/ # Provided Go backend source code
├── Dockerfile # Multi-stage optimized Dockerfile
├── docker-compose.yml # Local dev: backend + mongodb
├── .dockerignore # Ignore unnecessary files
├── kubernetes/
│ ├── namespace.yaml
│ ├── mongodb/
│ │ ├── mongodb-secret.yaml
│ │ ├── mongodb-configmap.yaml
│ │ ├── mongodb-pvc.yaml
│ │ ├── mongodb-deployment.yaml
│ │ └── mongodb-service.yaml
│ ├── backend/
│ │ ├── backend-secret.yaml
│ │ ├── backend-configmap.yaml
│ │ ├── backend-deployment.yaml
│ │ └── backend-service.yaml
│ └── ingress.yaml
├── scripts/
│ ├── docker-build.sh
│ ├── docker-run.sh
│ ├── k8s-deploy.sh
│ └── k8s-cleanup.sh
├── evidence/ # Screenshots required for submission
└── README.md

---

## Phase 1: Docker Setup (Local Development)

### 1) Build the backend image
```bash
docker build -t container-assessment-backend:latest -f Dockerfile .

2) Run backend + MongoDB using Docker Compose
docker compose up -d --build

3) Verify containers are running
docker ps

4) Test backend health endpoint
curl http://localhost:3000/health


Expected response:

{"cache":"disabled","database":"ok"}

5) Stop and clean containers (optional)
docker compose down -v

Phase 2: Kubernetes Deployment using Kind
1) Create Kind cluster
kind create cluster --name muchtodo


Verify cluster:

kubectl get nodes

2) Load backend Docker image into Kind

Since Kind runs inside Docker, the locally built backend image must be loaded into the Kind node:

kind load docker-image container-assessment-backend:latest --name muchtodo

3) Deploy Kubernetes manifests
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml

4) Verify deployments and services
kubectl get pods -n muchtodo
kubectl get svc -n muchtodo
kubectl get ingress -n muchtodo

5) Test backend via NodePort

The backend service is exposed using NodePort 30080:

curl http://localhost:30080/health


Expected response:

{"cache":"disabled","database":"ok"}

6) Helpful debug commands
kubectl logs -n muchtodo deploy/muchtodo-backend
kubectl describe svc backend-service -n muchtodo
kubectl describe pod -n muchtodo -l app=muchtodo-backend

Cleanup Kubernetes resources
kubectl delete -f kubernetes/ingress.yaml
kubectl delete -f kubernetes/backend/
kubectl delete -f kubernetes/mongodb/
kubectl delete -f kubernetes/namespace.yaml


Delete Kind cluster:

kind delete cluster --name muchtodo

Evidence (Screenshots)

All required screenshots are stored in the evidence/ folder, including:

Docker Evidence

Docker build completed successfully

Docker Compose running backend + mongodb

Successful health endpoint test: curl http://localhost:3000/health

Kubernetes Evidence

Kind cluster created / kubectl get nodes

MongoDB + backend pods running: kubectl get pods -n muchtodo

Services visible: kubectl get svc -n muchtodo

Successful NodePort access: curl http://localhost:30080/health

NodePort proof: kubectl describe svc backend-service -n muchtodo


---

## ✅ Step 3: Confirm README exists
Back in PowerShell:

```powershell
dir README.md


