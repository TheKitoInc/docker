#!/bin/env bash

# Search all dockerfiles in the current respository and build them

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed."
    exit 1
fi

# Get Git root
GIT_ROOT=$(git rev-parse --show-toplevel)
if [ $? -ne 0 ]; then
    echo "Error: Not a git repository."
    exit 1
fi

# Change to the Git root directory
cd "$GIT_ROOT" || {
    echo "Error: Failed to change directory to $GIT_ROOT."
    exit 1
}

# Check if the script is run from a git repository
if [ ! -d ".git" ]; then
    echo "Error: This script must be run from a git repository."
    exit 1
fi

# Find all Dockerfiles in the repository and build them using the path as the image name
# The script will search for Dockerfiles in the current directory and all subdirectories
find "$GIT_ROOT" -type f -iname 'Dockerfile' | while read -r dockerfile; do

    # Get the directory of the Dockerfile
    DOCKERFILE_DIR=$(dirname "$dockerfile")

    # Get the name of the Dockerfile
    DOCKERFILE_NAME=$(basename "$dockerfile")

    # Get the name based from path in the repository
    IMAGE_NAME=$(echo "$DOCKERFILE_DIR" | sed -e "s|$GIT_ROOT/||" -e 's|/|-|g' -e 's|_|-|g')

    # Check if the Dockerfile exists
    if [ ! -f "$dockerfile" ]; then
        echo "Error: Dockerfile $dockerfile does not exist."
        exit 1
    fi

    # Check if the Dockerfile is empty 
    if [ ! -s "$dockerfile" ]; then
        echo "Error: Dockerfile $dockerfile is empty."
        exit 1
    fi

    # Check if the Dockerfile is valid
    if ! grep -q 'FROM' "$dockerfile"; then
        echo "Error: Dockerfile $dockerfile is not valid."
        exit 1
    fi

    # Build the image
    echo "Building image $IMAGE_NAME from $DOCKERFILE_DIR/$DOCKERFILE_NAME"

    docker build -t "$IMAGE_NAME" "$DOCKERFILE_DIR"

    # Check if the build was successful
    if [ $? -ne 0 ]; then
        echo "Error: Docker build failed."
        exit 1
    fi

    # Push the image to Docker Hub
    echo "Pushing image $IMAGE_NAME to Docker Hub"

    # Check if the image exists
    if ! docker images | grep -q "$IMAGE_NAME"; then
        echo "Error: Docker image $IMAGE_NAME does not exist."
        exit 1
    fi

    # Check if the image is tagged
    if ! docker images | grep "$IMAGE_NAME" | grep -q "latest"; then
        echo "Error: Docker image $IMAGE_NAME is not tagged with latest."
        exit 1
    fi

     
continue
    docker push $IMAGE_NAME:latest

    if [ $? -ne 0 ]; then
        echo "Error: Docker push failed."
        exit 1
    fi
done

echo "All Docker images built successfully."