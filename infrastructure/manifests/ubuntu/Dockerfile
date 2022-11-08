
# -----------------------------------------------------------------------------
# This is base image of Ubuntu LTS with SSHD service.
#
# Authors: Art567
# Updated: Sep 20th, 2015
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

FROM   ubuntu:22.04
ENV    DEBIAN_FRONTEND noninteractive

ADD    ./scripts/start /start

RUN    apt-get -q -y update; apt-get -q -y upgrade && \
       apt-get -q -y install sudo openssh-server && \
       mkdir /var/run/sshd

# Set root password
RUN    echo 'root:password' >> /root/passwdfile

# Create user and it's password
RUN    useradd -m -G sudo master && \
       echo 'master:password' >> /root/passwdfile

# Apply root password
RUN    chpasswd -c SHA512 < /root/passwdfile && \
       rm /root/passwdfile
EXPOSE 22
VOLUME ["/data"]

RUN    chmod +x /start

# Starting sshd
CMD    ["/start"]