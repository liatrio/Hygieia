FROM maven:3.5.0

MAINTAINER hunterm@liatrio.com

# Add user
RUN useradd -ms /bin/bash maven

# Install Docker
RUN curl -fsSL https://get.docker.com/ | sh

# Give docker staff permission to run docker
RUN usermod -aG staff maven

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


