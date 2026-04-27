#!/usr/bin/env bash
set -euo pipefail   

## Konfigurasi image
image_name="karsajobs-ui"
image_tag="latest"
docker_username="archise1"

## package_name berisi <username>/<repo>:<tag>
package_name="${docker_username}/${image_name}:${image_tag}"

## Building Docker image
echo "Step 1: Building Docker image: ${package_name}"
docker build -t "${package_name}" .

## Login ke Docker Hub
echo
echo "Step 2: Login to Docker Hub (you may be prompted for credentials)"
docker login

## Verifikasi image lokal dan push ke Docker Hub
echo 
echo "Step 3: Verifying local image and pushing: ${package_name}"
docker images "${image_name}"
docker push "${package_name}"

echo
echo "Done — if push succeeded, image is at: https://hub.docker.com/r