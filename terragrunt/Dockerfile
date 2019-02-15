FROM hashicorp/terraform:0.11.11

ENV TERRAGRUNT_VERSION=0.18.0
ENV STOML_VERSION=0.1.1

RUN apk update && apk upgrade
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /bin/terragrunt && chmod 755 /bin/terragrunt
RUN wget https://github.com/freshautomations/stoml/releases/download/v${STOML_VERSION}/stoml_linux_amd64 -O /bin/stoml && chmod 755 /bin/stoml

ENTRYPOINT ["/bin/sh"]

