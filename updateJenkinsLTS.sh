#!/bin/bash

if [[ $# -eq 0 ]]; then
  echo "No Version supplied"
  exit 1
fi

# Main Variables
NEW_LTS_VERSION=$1

# Revert files
echo "Reverting Dockerfiles"
git checkout Dockerfile Dockerfile-slim Dockerfile-alpine

# Modify files
echo "Updating to LTS version $NEW_LTS_VERSION"

sed -i.bak 's/jenkins:[0-9.]*/jenkins:${NEW_LTS_VERSION}/' Dockerfile
rm Dockerfile.bak
sed -i.bak 's/jenkins:[0-9.]*/jenkins:${NEW_LTS_VERSION}/' Dockerfile-slim
rm Dockerfile-slim.bak
sed -i.bak 's/jenkins:[0-9.]*/jenkins:${NEW_LTS_VERSION}/' Dockerfile-alpine
rm Dockerfile-alpine.bak

# Stage changes
git add Dockerfile Dockerfile-slim Dockerfile-alpine

git commit -m "Image updated to ${NEW_LTS_VERSION}"
git tag -a "${NEW_LTS_VERSION}" -m "Image updated to ${NEW_LTS_VERSION}"

