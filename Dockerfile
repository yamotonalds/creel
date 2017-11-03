FROM jrottenberg/ffmpeg:3.3-alpine

RUN apk add --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing aws-cli && \
  pip3 install awscli  # awsコマンド使用時にImportErrorになったので追加
