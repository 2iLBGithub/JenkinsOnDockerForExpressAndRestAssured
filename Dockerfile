# Base image
FROM jenkins/jenkins:lts

# Switch to root user
USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg-agent \
                       software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Create Docker group and add Jenkins user to it
RUN groupadd docker && usermod -aG docker jenkins

# Switch back to Jenkins user
USER jenkins
