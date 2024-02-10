# Use an official Python runtime as a parent image
FROM python:3.9-slim

ARG DEBIAN_FRONTEND=noninteractive


# Set the working directory in the container
WORKDIR /usr/src/app

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    zip \
    unzip \
    curl \
    wget \
    gnupg \
    krb5-user \
    openssh-client \
    apt-transport-https && \
    rm -rf /var/lib/apt/lists/* 

# Download and install PowerShell
# RUN curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell_7.4.0-1.deb_amd64.deb -o /tmp/powershell.deb && \
#     dpkg -i /tmp/powershell.deb && \
#     rm /tmp/powershell.deb  # 'rm' command in lowercase

# Import the public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the Microsoft's Debian repository
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list'

# Install PowerShell
RUN apt-get update \
    && apt-get install -y \
    powershell
    
# Install PWShell modules
RUN pwsh -Command 'Install-Module -Name PSWSMan'

# Install Python packages
RUN pip install --no-cache-dir pywinrm
RUN pip install --no-cache-dir winrmcp
RUN pip install --no-cache-dir requests  # Add this line to install the requests library
RUN pip install --no-cache-dir prettytable

# Set up a directory for your scripts and files
RUN mkdir /usr/src/app/scripts
VOLUME /usr/src/app/scripts

# This container does not have a specific entrypoint. 
# It's intended to be used as a base for running CI scripts.

# Start PowerShell
CMD pwsh
