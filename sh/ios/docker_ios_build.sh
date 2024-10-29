#!/usr/bin/env bash

export TZ='Asia/Shanghai'

set -e

docker run \
  -e BUILD_VERSION \
  -e BUILD_BUNDLECODE \
  -e BUILD_PATH \
  -e BUILD_TARGET \
  -e BUILD_METHOD \
  -w /project/ \
  -v $WORKSPACE_OS:/project:cached \
  -v $BUILD_PATH_OS:/project2:cached \
  --rm \
  $MAC_IMAGE \
  /bin/bash -c "
    cd /project2;



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
