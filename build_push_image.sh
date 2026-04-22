#!/usr/bin/env sh
set -e

# Script to build, tag, and push the Docker image for the project.
# Usage:
#   export DOCKERHUB_USERNAME=your-username
#   chmod +x build_push_image.sh
#   ./build_push_image.sh

# Local image name and tag used for the initial build.
IMAGE_NAME=item-app
TAG=v1

# Build the image from the Dockerfile in the current directory and tag it locally.
echo "Building image ${IMAGE_NAME}:${TAG}..."
docker build -t ${IMAGE_NAME}:${TAG} .

# Show any local images matching the app name for verification.
echo "Local images:"
docker images | grep ${IMAGE_NAME} || docker images

# Require the DOCKERHUB_USERNAME env var so the image can be retagged for Docker Hub.
if [ -z "${DOCKERHUB_USERNAME}" ]; then
    echo "Set DOCKERHUB_USERNAME environment variable to retag for Docker Hub."
    echo "Example: export DOCKERHUB_USERNAME=your-username"
    exit 1
fi

# Remote repository name on Docker Hub (format: username/repository:tag).
REMOTE=${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${TAG}

# Create the Docker Hub-style tag locally so it can be pushed to the remote registry.
echo "Tagging image as ${REMOTE}..."
docker tag ${IMAGE_NAME}:${TAG} ${REMOTE}

# Prompt the user to login to Docker Hub interactively (will ask for username/password/token).
echo "Please login to Docker Hub when prompted (or run 'docker login' separately)."
docker login

# Push the tagged image to Docker Hub under the user's account.
echo "Pushing ${REMOTE}..."
docker push ${REMOTE}

echo "Done. Pushed ${REMOTE}"

