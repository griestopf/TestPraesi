# Create an image with blender and godot installed to run headless in /usr/local/bin
# Godot installation as in https://github.com/abarichello/godot-ci
# Blender installation as in https://github.com/nytimes/rd-blender-docker
FROM ubuntu:jammy

USER root
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary updates. Some are required for Godot Android builds only.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    git-lfs \
    unzip \
    wget \
    zip \
    adb \
    openjdk-17-jdk-headless \
    rsync \
	libopenexr-dev \ 
	bzip2 \ 
	build-essential \ 
	zlib1g-dev \ 
	libxmu-dev \ 
	libxi-dev \ 
	libxxf86vm-dev \ 
	libfontconfig1 \ 
	libxrender1 \ 
	libgl1-mesa-glx \
    libxkbcommon-x11-0 \ 
	xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Download and install Godot
ARG GODOT_VERSION="4.2.1"
ARG RELEASE_NAME="stable"
ARG SUBDIR=""
ARG GODOT_TEST_ARGS=""
ARG GODOT_PLATFORM="linux.x86_64"

RUN wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip

# Download and install Blender
RUN wget https://download.blender.org/release/Blender4.0/blender-4.0.2-linux-x64.tar.xz \
	&& tar -xvf blender-4.0.2-linux-x64.tar.xz --strip-components=1 -C /usr/local/bin \
	&& rm -rf blender-4.0.2-linux-x64.tar.xz \
	&& rm -rf blender-4.0.2-linux-x64 \
    && chmod +x /usr/local/bin/blender

# Only for local testing purposes
# ENTRYPOINT [ "blender", "--version" ]
# ENTRYPOINT [ "godot", "--version" ]
