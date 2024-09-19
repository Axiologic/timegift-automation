#!/bin/bash
set -e  # Exit script if any command fails

# Ensure values.sh exists and is executable
chmod +x values.sh
source values.sh

# Ensure TIMEGIFT_REPO and other important variables are set
if [ -z "$TIMEGIFT_REPO" ] || [ -z "$TIMEGIFT_IMAGE_NAME" ] || [ -z "$NODE_ALPINE_BASE_IMAGE" ]; then
    echo "One or more required environment variables are not set."
    exit 1
fi

# Clean up old repo directory if it exists
rm -rf tmp/timegift

# Clone the TIMEGIFT repository
git clone "$TIMEGIFT_REPO" tmp/timegift
cd tmp/timegift

# Run the dev-install script
npm run dev-install

npm run build-all
# Go back to the original directory
cd ../../

# Build the Docker image with no cache and necessary build arguments
DOCKER_BUILDKIT=1 docker build --no-cache -t "$TIMEGIFT_IMAGE_NAME:latest" --build-arg BASE_IMAGE="$NODE_ALPINE_BASE_IMAGE" -f Dockerfile . --network host

# Optionally, clean up the cloned repository
#rm -rf tmp/timegift
