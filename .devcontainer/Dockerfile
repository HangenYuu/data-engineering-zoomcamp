# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.177.0/containers/go/.devcontainer/base.Dockerfile

# [Choice] Go version (use -bullseye variants on local arm64/Apple Silicon): 1, 1.16, 1.17, 1-bullseye, 1.16-bullseye, 1.17-bullseye, 1-buster, 1.16-buster, 1.17-buster
ARG VARIANT=1-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/go:0-${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Install powershell
ARG PS_VERSION="7.2.1"
# powershell-7.3.0-linux-x64.tar.gz
# powershell-7.3.0-linux-arm64.tar.gz
RUN ARCH="$(dpkg --print-architecture)"; \
    if [ "${ARCH}" = "amd64" ]; then \
        PS_BIN="v$PS_VERSION/powershell-$PS_VERSION-linux-x64.tar.gz"; \
    elif [ "${ARCH}" = "arm64" ]; then \
        PS_BIN="v$PS_VERSION/powershell-$PS_VERSION-linux-arm64.tar.gz"; \
    elif [ "${ARCH}" = "armhf" ]; then \
        PS_BIN="v$PS_VERSION/powershell-$PS_VERSION-linux-arm32.tar.gz"; \
    fi; \
    wget https://github.com/PowerShell/PowerShell/releases/download/$PS_BIN -O pwsh.tar.gz; \
    mkdir /usr/local/pwsh && \
    tar Cxvfz /usr/local/pwsh pwsh.tar.gz && \
    rm pwsh.tar.gz

ENV PATH=$PATH:/usr/local/pwsh

RUN echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | tee /etc/apt/sources.list.d/shells:fish:release:3.list; \
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null; \
    apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
    fish \
    tmux \
    fzf \
    && apt-get clean

ARG USERNAME=vscode

# NOTE: devcontainers are Linux-only at this time but when
# Windows or Darwin is supported someone will need to improve
# the code logic above.

# add the oh-my-posh path to the PATH variable
ENV PATH "$PATH:/home/${USERNAME}/bin"

# Everything runs as root during build time, so we want
# to make sure the vscode user can edit these paths too:
RUN chmod 777 -R /home/${USERNAME}/.config

# Set container timezone:
ARG TZ="UTC"
RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

# Required for Python - Confluent Kafka on M1 Silicon
RUN apt update && apt -y install software-properties-common gcc
RUN git clone https://github.com/edenhill/librdkafka
RUN cd librdkafka && ./configure && make && make install && ldconfig