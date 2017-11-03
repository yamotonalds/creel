#!/bin/sh

echo "[`date '+%Y-%m-%d %H:%M:%S'`] download input file from $INPUT_BUCKET"
aws s3 cp s3://$INPUT_BUCKET/input.mp4 input.mp4

echo "[`date '+%Y-%m-%d %H:%M:%S'`] start encoding"
ffmpeg -stats -i ./input.mp4 -c:v libx264 -preset slow -crf 22 -c:a aac ./output.mp4

echo "[`date '+%Y-%m-%d %H:%M:%S'`] upload input file into $OUTPUT_BUCKET"
aws s3 cp output.mp4 s3://$OUTPUT_BUCKET/output_`date "+%Y%m%d_%H%M%S"`.mp4
