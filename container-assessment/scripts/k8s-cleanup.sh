#!/usr/bin/env bash
set -euo pipefail

kubectl delete -f kubernetes/ingress.yaml --ignore-not-found
kubectl delete -f kubernetes/backend/ --ignore-not-found
kubectl delete -f kubernetes/mongodb/ --ignore-not-found
kubectl delete -f kubernetes/namespace.yaml --ignore-not-found
