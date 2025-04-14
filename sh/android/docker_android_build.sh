#!/usr/bin/env bash

export TZ='Asia/Shanghai'

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
  -v $BUILD_PATH_OS:/project2:cached \
  -v $GRADLECACHE_OS:/root/.gradle \
  -v $Sdk_Path_OS:$Sdk_Path_UNITY \
  -v $Ndk_Path_OS:$Ndk_Path_UNITY \
  -v $Jdk_Path_OS:$Jdk_Path_UNITY \
  -v $Gradle_Path_OS:$Gradle_Path_UNITY \
  --rm \
  $IMAGE \
  /bin/bash -c "
    cd /project2;
    chmod +x \$Gradle_Path_Env/bin/gradle ;

    export ANDROID_SDK_ROOT=$Sdk_Path_Env;

    export ANDROID_NDK_HOME=$Ndk_Path_Env;
    export ANDROID_NDK_ROOT=$Ndk_Path_Env;

    export JAVA_HOME=$Jdk_Path_Env;

    if [ \"\$BUILD_BUILDAAB\" = \"true\" ]; then
      echo 'Building AAB...';
      \$Gradle_Path_Env/bin/gradle bundleRelease \
         -Dsdk.dir=\$Sdk_Path_Env \
         -Dndk.dir=\$Ndk_Path_Env \
         -Dorg.gradle.java.home=\$Jdk_Path_Env \
         --stacktrace --info ;
    else
      echo 'Building APK...';
      \$Gradle_Path_Env/bin/gradle assembleRelease \
         -Dsdk.dir=\$Sdk_Path_Env \
         -Dndk.dir=\$Ndk_Path_Env \
         -Dorg.gradle.java.home=\$Jdk_Path_Env \
         --stacktrace --info ;
    fi
  "



find "$BUILD_PATH_Jenkins" -type f \( -name "*.apk" -o -name "*.aab" \) -exec bash -c '
    for file; do
        # 提取文件的完整路径

        full_path="$file"

        # 提取文件名
        file_name=$(basename "$full_path")

        # 提取不带后缀的文件名
        file_name_without_extension="${file_name%.*}"

        # 提取后缀
        extension="${file_name##*.}"

        # 获取当前日期时间

        timestamp=$(date +"%m%d%H%M")

        new_filename="${FILE_NAME}_${BUILD_VERSION}_${timestamp}.${extension}"

        # 构建新的文件路径（保持原目录结构不变）

        dir=$(dirname "$full_path")

        new_full_path="$dir/$new_filename"

        # 重命名文件

        mv "$full_path" "$new_full_path"

        echo "Renamed $full_path to $new_full_path"

    done

' bash {} +
