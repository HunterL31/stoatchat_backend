#!/bin/bash
set -e

echo "🏗️ Building Stoat containers locally..."

# Build base image
echo "Building base image..."
docker build -t ghcr.io/hunterl31/base:latest .

# Build services
echo "Building API service..."
docker build -f crates/delta/Dockerfile -t ghcr.io/hunterl31/api:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "Building Events service..."  
docker build -f crates/bonfire/Dockerfile -t ghcr.io/hunterl31/events:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "Building Files service..."
docker build -f crates/services/autumn/Dockerfile -t ghcr.io/hunterl31/files:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "Building Proxy service..."
docker build -f crates/services/january/Dockerfile -t ghcr.io/hunterl31/proxy:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "Building Gifbox service..."
docker build -f crates/services/gifbox/Dockerfile -t ghcr.io/hunterl31/gifbox:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "Building Crond service..."
docker build -f crates/daemons/crond/Dockerfile -t ghcr.io/hunterl31/crond:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "Building Pushd service..."
docker build -f crates/daemons/pushd/Dockerfile -t ghcr.io/hunterl31/pushd:latest \
  --build-arg BASE_IMAGE=ghcr.io/hunterl31/base:latest .

echo "✅ All services built successfully!"
echo ""
echo "To use in stoat-unraid:"
echo "  cd ../stoat-unraid"
echo "  docker compose up -d"
echo ""
echo "To push to registry:"
echo "  docker push ghcr.io/hunterl31/api:latest"
echo "  docker push ghcr.io/hunterl31/events:latest"
echo "  # ... etc for other services"
