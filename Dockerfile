FROM ubuntu:14.04
MAINTAINER Palani

# Install common packages.
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && apt-get clean

# Add Ansible repo and install Ansible packages.
RUN apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends ansible \
    && apt-get clean

# Install OpenSSH Server.
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:cloud123' | chpasswd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Language setup 
RUN locale-gen zh_TW zh_TW.UTF-8 en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# Common alias 
RUN alias ls='ls --color=auto'
RUN alias ll='ls -halF'

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Configure inventory.
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
CMD ansible --version
