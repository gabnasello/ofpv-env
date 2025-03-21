#!/bin/bash

DOCKERHUB_USER="gnasello"
CONTAINER_NAME="ofpv-env"
VERSION='2025-03-14'

docker push "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}"

docker tag "${DOCKERHUB_USER}/${CONTAINER_NAME}:${VERSION}" "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest" 

docker push "${DOCKERHUB_USER}/${CONTAINER_NAME}:latest"