FROM hashicorp/terraform:0.11.11

ENV TERRAGRUNT_VERSION=0.18.0

RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /bin/terragrunt && \
    chmod 755 /bin/terragrunt

ENTRYPOINT ["/bin/terragrunt"]

