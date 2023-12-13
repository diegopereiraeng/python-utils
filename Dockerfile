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

# Configure Kerberos and SSH
RUN echo "[libdefaults]\ndefault_realm = YOUR_DOMAIN.COM\n..." > /etc/krb5.conf
RUN echo "GSSAPIAuthentication yes\nGSSAPIDelegateCredentials no\n..." >> /etc/ssh/ssh_config

# Install PowerShell
RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-linux-x64.tar.gz -o /tmp/powershell.tar.gz \
    && mkdir -p /opt/microsoft/powershell/7 \
    && tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 \
    && ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

# Install Python packages
RUN pip install --no-cache-dir pywinrm
RUN pip install --no-cache-dir winrmcp

# Set up a directory for your scripts and files
RUN mkdir /usr/src/app/scripts
VOLUME /usr/src/app/scripts

# This container does not have a specific entrypoint. 
# It's intended to be used as a base for running CI scripts.
