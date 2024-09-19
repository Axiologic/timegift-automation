#!/bin/bash
echo "Setting variables ..."
NODE_ALPINE_BASE_IMAGE='node:20.15.0-alpine'
HUB_IDENTIFIER='docker.io'
TIMEGIFT_REPO='https://github.com/Axiologic/timegift.git'
TIMEGIFT_NAME='timegift'
TIMEGIFT_IMAGE_NAME='assistos/timegift'
if [[ -z "$VERSION" ]]; then
  VERSION='1.0.0'
fi
