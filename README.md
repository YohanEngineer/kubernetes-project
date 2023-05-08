# Kubernetes Project


Rédiger une documentation complète à la racine du dépôt (README.md) expliquant les prérequis, présentant les composants de l'application, l'organisation de votre code, le rôle des composants, les instructions pour développer/tester les composants sans Docker/Kubernetes + avec Docker + avec Kubernetes, les instructions de build et de déploiement, et/ou toute information utile


## Objectif

L'objectif de ce projet est d'utiliser un cluster Kubernetes à un seul nœud et d'y déployer une application API simple fonctionnant avec un cache Redis.

## Prérequis

- NodeJS
- NPM
- Docker
- Kubernetes (Digital Ocean Cluster)
- Container Registry

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
docker image tag yohanengineer/node-api-app:1.0.0 localhost:5001/yohanengineer/node-api-app:1.0.0
# Push image
docker image push --all-tags localhost:5001/yohanengineer/node-api-app
```
## Composants

## Structure du code

## Rôle des composants

## Developper/tester sans Docker/Kubernetes

## Developper/tester avec Docker

## Developper/tester avec Kubernetes

## Build

## Deployer

## Autre

Access to the API :

https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster-services/

```bash
http://127.0.0.1:53587/api/v1/namespaces/tp-namespace/services/http:api-service:8080/proxy/
```
