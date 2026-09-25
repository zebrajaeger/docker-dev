ARG NVM_VERSION=v0.40.3
ARG NODE_VERSION=24
ARG JAVA_VERSION=21.0.12+1-sapmchn
ARG MAVEN_VERSION=3.9.16

FROM ubuntu:24.04

ARG NVM_VERSION
ARG NODE_VERSION
ARG JAVA_VERSION
ARG MAVEN_VERSION

RUN apt-get update && apt-get install -y \
    sudo \
    openssh-client \
    openssh-server \
    git \
    curl \
    ca-certificates \
    gnupg \
    btop \
    mc \
    ttyd \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash developer \
    && mkdir -p /run/sshd \
    && mkdir -p /home/developer/.ssh \
    && chmod 700 /home/developer/.ssh \
    && chown -R developer:developer /home/developer/.ssh

RUN usermod -aG sudo developer \
    && echo 'developer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/developer \
    && chmod 440 /etc/sudoers.d/developer

ENV NVM_DIR=/home/developer/.nvm
ENV SDKMAN_DIR=/home/developer/.sdkman
ENV PATH=/home/developer/.local/bin:${PATH}

RUN mkdir -p "$NVM_DIR" "$SDKMAN_DIR" \
    && chown -R developer:developer "$NVM_DIR" "$SDKMAN_DIR"

USER developer

RUN curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install "$NODE_VERSION" \
    && nvm alias default "$NODE_VERSION" \
    && npm install --global npm@latest \
    && npm config set allow-scripts=codebase-memory-mcp,omniroute,opencode-ai,keytar,onnxruntime-node,tls-client-node,@parcel/watcher,@swc/core,protobufjs,koffi,esbuild --location=user \
    && npm install --global \
        codeburn \
        omniroute \
        opencode-ai \
        codebase-memory-mcp \
        @openai/codex

# Claude Code's native installer is Anthropic's recommended installation method.
RUN curl -fsSL https://claude.ai/install.sh | bash

RUN curl -fsSL https://get.sdkman.io | bash \
    && bash -c 'source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install java "$JAVA_VERSION"'

RUN bash -c 'source "$SDKMAN_DIR/bin/sdkman-init.sh" && sdk install maven "$MAVEN_VERSION"'

USER root

COPY config-templates /usr/local/share/config-templates
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D", "-e"]
