#!/usr/bin/env bash

set -e
set -x

echo "Building for $BUILD_TARGET"

 
cd ~
ls
mkdir -p root/.local/share/unity3d/Unity/
echo $UNITY_LICENSE > root/.local/share/unity3d/Unity/Unity_lic.ulf
cat root/.local/share/unity3d/Unity/Unity_lic.ulf

 

${UNITY_EXECUTABLE:-xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' unity-editor} \
  -projectPath / \
  -quit \
  -nographics \
  -logFile /dev/stdout \
  -username $UNITY_USERNAME \
  -password $UNITY_PASSWORD \
  -executeMethod $BUILD_METHOD  \
  -buildVersion $BUILD_VERSION \
  -buildBundleCode $BUILD_BUNDLECODE \
  -buildPath $BUILD_PATH \
  -buildSeparateAsset $BUILD_SEPARATEASSET \
  -buildAAB $BUILD_BUILDAAB \
  -exportProject $BUILD_BUILDEXPORTPROJECT \
  -buildTarget $BUILD_TARGET \
  -sdkPath $Sdk_Path_Env \
  -ndkPath $Ndk_Path_Env \
  -jdkPath $Jdk_Path_Env \
  -gradlePath $Gradle_Path_Env

UNITY_EXIT_CODE=$?

if [ $UNITY_EXIT_CODE -eq 0 ]; then
  echo "Run succeeded, no failures occurred";
elif [ $UNITY_EXIT_CODE -eq 2 ]; then
  echo "Run succeeded, some tests failed";
elif [ $UNITY_EXIT_CODE -eq 101 ]; then
  echo "Run failure (other failure)";
elif [ $UNITY_EXIT_CODE -eq 102 ]; then
  echo "Run cancelled";
else
  echo "Unexpected exit code $UNITY_EXIT_CODE";
fi
