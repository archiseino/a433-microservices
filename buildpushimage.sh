#!/bin/sh

# Define package name
$package_name=archise1/order-service:latest

# Build the Docker image
docker build -t $package_name .

# Login to Docker registry (if required)
docker login

# Check and Push the Docker image to the registry
docker images $package_name
docker push $package_name

echo "image was successfully built and can be viewed on docker.io/archise1/order-service:latest"