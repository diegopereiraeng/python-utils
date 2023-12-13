# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    zip \
    unzip \
    curl \
    wget \
    krb5-user \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Download and install PowerShell
RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb -o /tmp/powershell.deb \
    && dpkg -i /tmp/powershell.deb \
    && rm /tmp/powershell.deb

# Install Python packages
RUN pip install --no-cache-dir pywinrm
RUN pip install --no-cache-dir winrmcp

# Set up a directory for your scripts and files
RUN mkdir /usr/src/app/scripts
VOLUME /usr/src/app/scripts

# This container does not have a specific entrypoint. 
# It's intended to be used as a base for running CI scripts.
``
