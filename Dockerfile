# Use a slim version of the Python 3.10.11 image as the base
FROM python:3.10.11-slim-buster

# Set environment variables to prevent Python from buffering output and writing bytecode
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin
ENV GOPATH /go
ENV GOROOT /usr/local/go

# Install Golang
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends wget \
    && wget -qO- https://go.dev/dl/go1.20.3.linux-amd64.tar.gz | tar -xz -C /usr/local \
    && rm -rf go1.20.3.linux-amd64.tar.gz \
    && mkdir $GOPATH \
    && apt-get clean && apt-get autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install PostgreSQL dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libpq-dev \
    && apt-get clean && apt-get autoclean && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
