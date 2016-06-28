# Ruby On Rails Base Image - CyberSpace Technologies Group, LLC.
#
# VERSION		0.0.4

FROM rails:onbuild


MAINTAINER D Deryl Downey "ddd@deryldowney.com"

# Set the Description, Vendor, and Version number on the resulting image. NOTE: Increment Version and VERSION. Both are to match.
LABEL Description="Built with Ruby On Rails 4.2.6 and Ruby 2.3.1p112 on Ubuntu Jessie. It's built from the official Rails OnBuild docker image." \
      Vendor="CyberSpace Technologies Group, LLC. [CSTG]" \
      Version="0.0.4"

# Set needed Environment variables here. Ex: ENV VAR value or ENV VAR=value
ENV TERM=xterm
ENV TTY=$(tty)

# Update pkgs db, install primary toolsets, and then upgrade the distribution itself
# NOTE: Dockerfile 'Best Practices' is to list pkgs being installed in alphabetical order
RUN apt-get update && apt-get install -y \
  apt-utils \
  build-essential \
  debian-keyring \
  dialog \
  git \
  git-extras \
  git-flow \
  gnupg2 \
  less \
  makepasswd \
  net-tools \
  openssh-server \
  sudo \
  traceroute \
  && apt-get dist-upgrade -y

# Add non-privileged user for everything to run under. Make sure they are in the sudo and staff groups.
# Normally, one would chain as many RUN commands as possible. But since this one is creating
# a user and setting a default password it's being kept to it's own line even though it generates
# an additional image layer to do so.
RUN useradd -m -p $(echo cstguser | makepasswd --clearfrom=- --crypt-md5 | cut -d ' ' -f4) -c "CSTG User" -s /bin/bash cstg \
    && usermod -aG sudo,staff cstg

# Add Node.JS v4.4 series using the NodeSource.Com PPA.
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && apt-get install -y nodejs

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD 
# instructions that follow it in the Dockerfile. If the WORKDIR doesnt exist, it will be created 
# even if its not used in any subsequent Dockerfile instruction
WORKDIR /usr/src/app

# Now we add all CSTG-supported database connection gems to the image, we then
# ensure proper permissions and ownership of all directories and files under WORKDIR
# Also, to cut down on the number of RUNs, AND the size of the image, clean up apt.
RUN  gem install mysql pg sqlite3 \
  && chown -R cstg:cstg . \
  && find . -type f -exec chmod 644 {} \; \
  && find . -type d -exec chmod 755 {} \; \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/tmp/*

# Pass on the default user for new images being created. Users of this Docker image will
# have their own image(s), that are based off this one, preset to executing as 'cstg'.
# They should start their images out with 'USER root' if they need to modify the system.
ONBUILD USER cstg

