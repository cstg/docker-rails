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
  net-tools \
  openssh-server \
  sudo \
  traceroute \
  && apt-get dist-upgrade -y

# Add non-privileged user for everything to run under. Make sure they are in the sudo group.
RUN useradd -m -c "CSTG Default User" cstg -s /bin/bash && usermod -aG sudo,staff cstg

# Add Node.JS v4.4 series using the NodeSource.Com PPA.
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && apt-get install -y nodejs

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD 
# instructions that follow it in the Dockerfile. If the WORKDIR doesnt exist, it will be created 
# even if its not used in any subsequent Dockerfile instruction
WORKDIR /usr/src/app

# Now we add all CSTG-supported database connection gems to the image
RUN gem install mysql pg sqlite3

# Ensure proper permissions and ownership of all directories and files under WORKDIR
# Also, to cut down on the number of RUNs, clean out apt at the same time.
RUN chown -R cstg:cstg . \
  && find . -type f -exec chmod 644 {} \; \
  && find . -type d -exec chmod 755 {} \; \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/tmp/*

ONBUILD USER cstg

