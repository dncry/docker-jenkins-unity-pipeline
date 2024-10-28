#!/usr/bin/env bash

set -e

docker run \
  -e UNITY_USERNAME \
  -e UNITY_PASSWORD \
  -e UNITY_LICENSE \
  -e BUILD_VERSION \
  -e BUILD_BUNDLECODE \
  -e BUILD_PATH \
  -e BUILD_TARGET \
  -e BUILD_METHOD \
  -w /project/ \
  -v $WORKSPACE_OS:/project:cached \
  --rm \
  $IMAGE \
  /bin/bash -c "${CI_DIR_UNITY_ShGit}/build-personal.sh"
