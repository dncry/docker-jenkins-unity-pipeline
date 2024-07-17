#!/usr/bin/env bash

set -e

docker run \
  -e UNITY_USERNAME \
  -e UNITY_PASSWORD \
  -e UNITY_SERIAL \
  -e BUILD_VERSION \
  -e BUILD_BUNDLECODE \
  -e BUILD_PATH \
  -e BUILD_SEPARATEASSET \
  -e BUILD_BUILDAAB \
  -e BUILD_BUILDEXPORTPROJECT \
  -e BUILD_TARGET \
  -e BUILD_METHOD \
  -e Sdk_Path_Env \
  -e Ndk_Path_Env \
  -e Jdk_Path_Env \
  -e Gradle_Path_Env \
  -w /project/ \
  -v $WORKSPACE_OS:/project:cached \
  -v $BUILD_PATH_OS:/project2:cached \
  -v $GRADLECACHE_OS:/root/.gradle \
  -v $Sdk_Path_OS:$Sdk_Path_UNITY \
  -v $Ndk_Path_OS:$Ndk_Path_UNITY \
  -v $Jdk_Path_OS:$Jdk_Path_UNITY \
  -v $Gradle_Path_OS:$Gradle_Path_UNITY \
  --rm \
  "abc/android:cimg-2024.04.1-ndk" \
  /bin/bash -c "
    cd /project2;
    chmod +x \$Gradle_Path_Env/bin/gradle ;

    \$ANDROID_HOME= \$Sdk_Path_Env;
    \$ANDROID_NDK_HOME = \$Ndk_Path_Env;
    \$JAVA_HOME = \$Jdk_Path_Env;


    \$Gradle_Path_Env/bin/gradle assembleRelease \
       -Dsdk.dir=\$Sdk_Path_Env \
       -Dndk.dir=\$Ndk_Path_Env \
       -Dorg.gradle.java.home=\$Jdk_Path_Env ;
  "
