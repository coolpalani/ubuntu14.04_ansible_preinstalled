FROM ubuntu:14.04
MAINTAINER Max Wu

# Install common packages.
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && apt-get clean

# Add Ansible repo and install Ansible packages.
RUN apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends ansible \
    && apt-get clean

# Configure inventory.
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
CMD ansible --version
