#!/bin/sh -e

INPUT_FILE=$1
FILE_NAME=`basename "$INPUT_FILE"`
FILE_NAME_WITHOUT_EXT=${FILE_NAME%.*}

echo "[`date '+%Y-%m-%d %H:%M:%S'`] download input file from $INPUT_FILE"
aws s3 cp "s3://$INPUT_FILE" "$FILE_NAME"

echo "[`date '+%Y-%m-%d %H:%M:%S'`] start encoding"
# outputのファイル名は、inputのファイル名と重ならないようにしつつ、出力形式を指定するために拡張子を付けている
ffmpeg -stats -i "$FILE_NAME" -c:v libx264 -preset slow -crf 22 -c:a aac _output.mp4

echo "[`date '+%Y-%m-%d %H:%M:%S'`] upload input file into $OUTPUT_BUCKET"
aws s3 cp _output.mp4 "s3://$OUTPUT_BUCKET/${FILE_NAME_WITHOUT_EXT}.mp4"
