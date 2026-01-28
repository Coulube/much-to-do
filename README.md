# StartTech Full-Stack Application

## Architecture
- Frontend: React  S3 + CloudFront
- Backend: Golang  Docker  ECR  EC2 Auto Scaling Group
- Load Balancer: Application Load Balancer
- Cache: Redis (ElastiCache)
- Database: MongoDB Atlas
- Infrastructure: Terraform
- CI/CD: GitHub Actions

## CI/CD Pipelines
### Frontend
- Trigger: Push to feature/full-stack (Client/)
- Build: npm install, test, build
- Deploy: S3 sync
- CDN: CloudFront invalidation

### Backend
- Build Docker image
- Push to Amazon ECR
- Deploy via EC2 Auto Scaling Group

## Scripts
Scripts are provided for documentation purposes.
Actual deployments are automated via GitHub Actions.

## Monitoring
- CloudWatch Logs
- IAM least-privilege roles
