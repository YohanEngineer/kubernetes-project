#!/bin/bash

# Get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Go to previous directory
cd $DIR/..

# Create cache directory variables
CACHE_DIR=$DIR/../k8s-2-services/cache
API_DIR=$DIR/../k8s-2-services/app

# Run k8s deployment
kubectl apply -f $CACHE_DIR/cache.yaml
kubectl apply -f $API_DIR/api.yaml
kubectl apply -f $API_DIR/api-ingress.yaml
kubectl apply -f $API_DIR/api-hpa.yaml
