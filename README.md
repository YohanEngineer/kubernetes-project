# Kubernetes Project


Rédiger une documentation complète à la racine du dépôt (README.md) expliquant les prérequis, présentant les composants de l'application, l'organisation de votre code, le rôle des composants, les instructions pour développer/tester les composants sans Docker/Kubernetes + avec Docker + avec Kubernetes, les instructions de build et de déploiement, et/ou toute information utile


## Goal

The aim of this project is to use a singlenode Kubernetes cluster and deploy a simple API application on it running with a Redis Cache.

## Pre-requisites

- NodeJS
- NPM
- Docker
- Kubernetes (minikube)

## Minikube

```bash
minikube start
minikube addons enable metrics-server
minikube addons enable ingress
minikube dashboard
kubectl create namespace tp-namespace
```

## Docker Registry

```bash
# Tag image
docker image tag yohan-engineer/node-api-app:3.0.0 localhost:5001/yohan-engineer/node-api-app:3.0.0
# Push image
docker image push --all-tags localhost:5001/yohan-engineer/node-api-app
```
## Components

## Code structure

## Components roles

## Develop/test without Docker/Kubernetes

## Develop/test with Docker

## Develop/test with Kubernetes

## Build

## Deploy

## Other
