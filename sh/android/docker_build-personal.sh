#!/usr/bin/env bash

set -e

docker run \
  -e UNITY_USERNAME \
  -e UNITY_PASSWORD \
  -e UNITY_LICENSE \
  -e BUILD_VERSION \
  -e BUILD_BUNDLECODE \
  -e BUILD_PATH \
  -e BUILD_SEPARATEASSET \
  -e BUILD_BUILDAAB \
  -e BUILD_BUILDIL2CPP \
  -e BUILD_BUILDEXPORTPROJECT \
  -e BUILD_TARGET \
  -e BUILD_METHOD \
  -e Sdk_Path_Env \
  -e Ndk_Path_Env \
  -e Jdk_Path_Env \
  -e Gradle_Path_Env \
  -w /project/ \
  -v $WORKSPACE_OS:/project:cached \
  -v $GRADLECACHE_OS:/root/.gradle \
  -v $Sdk_Path_OS:$Sdk_Path_UNITY \
  -v $Ndk_Path_OS:$Ndk_Path_UNITY \
  -v $Jdk_Path_OS:$Jdk_Path_UNITY \
  -v $Gradle_Path_OS:$Gradle_Path_UNITY \
  --rm \
  $IMAGE \
  /bin/bash -c "${CI_DIR_UNITY_ShGit}/build-personal.sh"
