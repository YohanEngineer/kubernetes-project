# Get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Go to previous directory
cd $DIR/..

# Create cache directory variables
CACHE_DIR=$DIR/../cache
API_DIR=$DIR/../app

# Run cache deployment
kubectl apply -f $CACHE_DIR/cache.yaml
kubectl apply -f $API_DIR/api.yaml
kubectl apply -f $API_DIR/api-ingress.yaml
kubectl apply -f $API_DIR/api-hpa.yaml