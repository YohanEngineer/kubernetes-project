# Créer un nouveau registry avec Digital Ocean Container Registry
doctl registry create episen-registry
# Se connecter au registry
doctl registry login
# Construire l'image
docker build -t node-api-app:1.0.0 .
# Tag l'image
docker tag node-api-app:1.0.0  registry.digitalocean.com/episen-registry/node-api-app:1.0.0-local
# Pousser l'image
docker push  registry.digitalocean.com/episen-registry/node-api-app:1.0.0-local