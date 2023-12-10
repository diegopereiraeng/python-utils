# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install necessary packages
# This includes zip and unzip utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir pywinrm

# Set up a directory for your scripts and files
RUN mkdir /usr/src/app/scripts
VOLUME /usr/src/app/scripts

# This container does not have a specific entrypoint. 
# It's intended to be used as a base for running CI scripts.
