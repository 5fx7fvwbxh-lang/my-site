# trixie may not support all features/packages that are needed for dev as of 02/2026, using bookworm for now.
FROM python:3.14-slim-bookworm

# Prevent python from writing pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    # pip (uv will use system Python but these ensure pip behavior is clean)
    PIP_NO_CACHE_DIR=1 \
    # Disable pip version check to speed up installs and avoid unnecessary network calls
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    # uv package manager configuration
    # similar to pip's no-cache-dir but for uv's own caching of packages and metadata
    UV_NO_CACHE=1 \
    # use system python for uv to avoid conflicts (e.g., with virtual environments) and ensure consistency
    UV_SYSTEM_PYTHON=1 \
    # compile python to bytecode for faster startup
    UV_COMPILE_BYTECODE=1 \
    # use copy mode for uv to avoid issues with symlinks in some environments
    UV_LINK_MODE=copy

# set shell to bash for better scripting capabilities and feature installations
SHELL ["/bin/bash", "-c"]

# install system dependencies
# NOTE: See docs/DEVCONTAINER_DEPENDENCIES.md for adding database, GeoDjango, or other dependencies
RUN apt-get update && apt-get install -y \
    # shell
    bash \
    zsh \
    # essential build tools for compiling python packages with C extensions (e.g, Pillow, psycopg2)
    build-essential \
    # development tools
    curl \
    git \
    vim \
    wget \
    # for locale support (utf-8 handling)
    locales \
    # clean up apt cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# create a non-root user (when set with `USER $USERNAME`, it is inherited by containerUser and remoteUser in devcontainer.json)
ARG USERNAME=vc
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && rm -rf /var/lib/apt/lists/*

# set up working directory
WORKDIR /workspaces/my-site

# switch to non-root user for subsequent commands (e.g., uv installation, deps installations, etc)
USER $USERNAME

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
