FROM alpine:3.9

RUN apk update && apk upgrade && apk add bash ruby git && \
    gem install rdoc || gem install network && \
    gem install rdoc && \
    gem install twurl && \
    adduser -D -u 3434 -s /bin/bash circleci

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

