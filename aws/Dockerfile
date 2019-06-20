FROM alpine:3.9

ENV AWS_REGION=us-east-1

COPY aws-access /usr/bin
# `apk add ansible` installs PyYAML and `pip3 install awscli` fails because of dependency conflict.
# Instead of installing an older ansible from the package repository, we build a fresh version using pip.
RUN apk update && apk upgrade && apk add bash openssh zip git py3-pip && \
    pip3 install awscli boto boto3 && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    chmod +x /usr/bin/aws-access && \
    adduser -D -u 3434 -s /bin/bash circleci

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

