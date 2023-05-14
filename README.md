# Kubernetes Project

## Consignes

Rédiger une documentation complète à la racine du dépôt (README.md) expliquant les prérequis, présentant les composants de l'application, l'organisation de votre code, le rôle des composants, les instructions pour développer/tester les composants sans Docker/Kubernetes + avec Docker + avec Kubernetes, les instructions de build et de déploiement, et/ou toute information utile


## Objectif

L'objectif de ce projet est d'utiliser un cluster Kubernetes à un seul nœud et d'y déployer une application API simple fonctionnant avec un cache Redis.

## Remarques

J'ai fait le choix d'utiliser un cluster Kubernetes hébergé dans le cloud après avoir rencontré des problèmes avec Kubernetes In Docker lors d'un redémarrage de Docker. J'ai ensuite utilisé Minikube, mais j'ai rencontré des problèmes de connectivité entre le cache et l'API.  J'ai choisi Digital Ocean car il propose un cluster Kubernetes gratuit pendant 30 jours. J'ai donc créé un cluster Kubernetes à un seul nœud sur Digital Ocean et j'ai déployé mon application dessus. Finalement, les problèmes de connectivité entre le cache et l'API sont toujours présents, il ne s'agissait donc pas d'un problème lié à Minikube...

## Prérequis

- NodeJS : https://nodejs.org/en/download/
- NPM : https://www.npmjs.com/get-npm
- Docker : https://docs.docker.com/get-docker/
- Kubernetes (Digital Ocean Cluster) : https://www.digitalocean.com/docs/kubernetes/how-to/create-clusters/
- Container Registry (Digital Ocean) : https://www.digitalocean.com/docs/containers/how-to/registry/

## Structure du projet

```bash	
├───app
├───k8s
│   ├───app
│   ├───cache
│   └───scripts
└───scripts
```

Le code de l'application se décompose en trois parties : l'application en elle-même, les ressources Kubernetes et les scripts qui permettent ...

## Composants

L'application se décompose en 2 parties avec d'une part l'API et d'autre part le cache Redis. L'ensemble des ressources kubernetes est créé dans le namespace <b>tp-namespace</b> afin d'avoir un namespace spécifique à notre application dans le cas où notre cluster serait amené à être utilisé pour de nombreuses applications.

### Cache Redis

Le cache Redis est créé à partir de l'image Docker officielle Redis. Il est déployé dans un <b>pod</b> Kubernetes à l'aide d'un <b>déploiement</b> k8s. On utilise ensuite un <b>service</b> k8s pour exposer le cache Redis à l'API au sein du cluster.

### API

L'API est créée à partir d'une image Docker NodeJS avec notre code en surchouche. Cette image est hébergée dans un repository Docker privé. Elle est déployée dans un <b>pod</b> Kubernetes à l'aide d'un <b>déploiement</b> k8s. On utilise ensuite un <b>service</b> k8s pour exposer l'API à l'intérieur du cluster. Enfin, on utilise un <b>ingress</b> k8s pour exposer l'API à l'extérieur du cluster et on a un <b>HorizontalPodAutoscaler</b> pour scaler l'API en fonction de la charge.


## Rôle des composants

### Cache Redis

#### Deployment
Un déploiement est un objet Kubernetes de niveau supérieur qui gère les ReplicaSets et les mises à jour des pods. Il permet de déployer, mettre à jour et mettre à l'échelle des applications conteneurisées en gérant automatiquement les ReplicaSets. Ici, le déploiement sert à créer et gérer des pods Redis en utilisant le label app: cache. Il s'assure qu'un pod Redis est en cours d'exécution avec un conteneur basé sur l'image Docker redis. Le conteneur exécute le serveur Redis, qui écoute sur toutes les adresses IP (0.0.0.0) et expose le port 6379.

#### Service
Un service est un objet Kubernetes qui expose une application (généralement un ensemble de pods) à l'intérieur du cluster. Il fournit un point d'accès stable pour la communication avec les pods, indépendamment du nombre de replicas et de leur emplacement. Ici, le service expose les pods Redis (sélectionnés par le label app: cache) via un LoadBalancer. Il redirige le trafic entrant sur le port 6379 en utilisant le protocole TCP vers le port 6379 des pods cibles. Le service permet d'accéder au cache Redis à l'aide d'une adresse IP stable, même si les pods sous-jacents changent.

### API

#### Deployment
Ce déploiement crée et gère un pod d'API avec le label app: api. Il spécifie un seul replica, ce qui signifie qu'un seul pod sera en cours d'exécution initialement. Le conteneur dans ce pod est basé sur l'image Docker registry.digitalocean.com/episen-registry/node-api-app:1.0.0. Le conteneur expose le port 8080.

#### Service
Ce service expose les pods d'API (sélectionnés par le label app: api) en utilisant un service de type ClusterIP. Il redirige le trafic entrant sur le port 8080 en utilisant le protocole TCP vers le port 8080 des pods cibles. Un service de type ClusterIP expose l'application uniquement à l'intérieur du cluster Kubernetes, ce qui signifie que l'API ne sera accessible que par d'autres composants du cluster et non depuis l'extérieur. On doit donc utiliser un ingress pour exposer l'API à l'extérieur du cluster.

#### Ingress
L'Ingress est un objet Kubernetes qui gère l'accès externe aux services dans un cluster. L'Ingress api-ingress est configuré pour diriger le trafic HTTP entrant vers le service api-service dans le namespace tp-namespace. Cet Ingress redirige toutes les requêtes HTTP entrantes avec un préfixe de / vers le service api-service sur le port 8080. L'Ingress est une manière courante d'exposer les services au sein d'un cluster Kubernetes à des clients externes.

#### HorizontalPodAutoscaler
L'HPA est un objet Kubernetes qui automatise le redimensionnement horizontal du nombre de réeplicas d'un déploiement, d'un ReplicaSet ou d'un StatefulSet en fonction de l'utilisation des ressources. Cet HPA surveille l'utilisation du CPU pour le déploiement api-deployment et ajuste automatiquement le nombre de replicas entre 1 et 5 en fonction de l'utilisation moyenne du CPU. Si l'utilisation moyenne du CPU dépasse 50%, il augmentera le nombre de replicas pour équilibrer la charge.

## Développer/tester sans Docker/Kubernetes

## Développer/tester avec Docker

## Développer/tester avec Kubernetes

## Build

```bash
# Create a new registry on Digital Ocean Container Registry
doctl registry create episen-registry
# Login to the registry
doctl registry login
# Build the image
docker build -t node-api-app:1.0.0 .
# Tag the image
docker tag node-api-app:1.0.0  registry.digitalocean.com/episen-registry/node-api-app:1.0.0
# Push the image
docker push  registry.digitalocean.com/episen-registry/node-api-app:1.0.0
```

## Déployer

## Autre

Access to the API :

https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster-services/

```bash
http://127.0.0.1:53587/api/v1/namespaces/tp-namespace/services/http:api-service:8080/proxy/
```
