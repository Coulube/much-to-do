#!/usr/bin/env bash
set -euo pipefail

docker compose up -d --build
echo "Backend: http://localhost:3000/health"
