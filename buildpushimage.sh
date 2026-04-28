#!/bin/sh

# nama package
package_name="archise1/shipping-service:latest"

# membuat image di Docker dengan format untuk GitHub Container Registry
echo -e "Building a new Docker image:"
docker build -t $package_name .

# log masuk ke Docker Hub 
echo -e "\nLogin into Docker"
docker login 

# Check the image that was built
echo -e "\nChecking the image that was built:"
docker images $package_name

# mengunggah image ke Docker Hub
echo -e "\nPublishing image to Docker Hub:"
docker push $package_name

echo "Image $package_name has been published to Docker Hub. Image was in Docker Hub: https://hub.docker.com/r/archise1/shipping-service"