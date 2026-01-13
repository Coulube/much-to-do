#!/usr/bin/env bash
set -euo pipefail

docker build -t container-assessment-backend:latest -f Dockerfile .
echo "Built: container-assessment-backend:latest"
