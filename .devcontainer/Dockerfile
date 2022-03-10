# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.224.2/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# Version of install scripts to use from the GitHub script library page
# See https://github.com/microsoft/vscode-dev-containers/tree/main/script-library#readme for more info
ARG DEVCONTAINER_SCRIPT_VERSION="main"

# Install bash-completion and other required tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        bash-completion \
        software-properties-common \
    && mkdir -p /etc/bash_completion.d && chmod -R 777 /etc/bash_completion.d \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Setup Terraform CLI, Terragrunt, TFLint, terraform-ls, and terraform-docs. 
# Include Graphviz for Terraform diagram generation
ARG TERRAFORM_VERSION="latest"
ARG TFLINT_VERSION="latest"
ARG TERRAGRUNT_VERSION="none"
ARG TERRAFORM_DOCS_VERSION="0.16.0"

RUN curl -sSL "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/${DEVCONTAINER_SCRIPT_VERSION}/script-library/terraform-debian.sh" | bash -s "${TERRAFORM_VERSION}" "${TFLINT_VERSION}" "${TERRAGRUNT_VERSION}" \
    && echo "complete -C $(which terraform) terraform" > /etc/bash_completion.d/terraform-cli \
    && curl -sSL https://apt.releases.hashicorp.com/gpg | (OUT=$(apt-key add - 2>&1) || echo $OUT) \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install -y --no-install-recommends \
        graphviz \
        graphviz-doc \
        terraform-ls \
    && mkdir -p /tmp/terraform-docs \
    && curl -sSL "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-$(uname | tr '[:upper:]' '[:lower:]')-$(dpkg --print-architecture).tar.gz" | tar -xz -C /tmp/terraform-docs \
    && chmod +x /tmp/terraform-docs/terraform-docs \
    && mv /tmp/terraform-docs/terraform-docs /usr/local/bin/terraform-docs \
    && echo 'source <(terraform-docs completion bash)' >> /etc/bash.bashrc \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /tmp/terraform-docs /var/lib/apt/lists/*