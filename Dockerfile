# Ruby On Rails Base Image
#
# VERSION		0.0.1

FROM rails:onbuild


MAINTAINER D Deryl Downey <ddd@deryldowney.com>


# Describe the use for this image, the vendor, and the current version level
LABEL Description="This image is used to set up Ruby On Rails 4.2.6 on Ubuntu using RVM & Ruby 2.3.1" Vendor="CSTG / D Deryl Downey" Version="0.0.1"

# Set Environment here
ENV TERM xterm

# Let's start actually building now..
# Ready? Set! Go!

# Install primary tools needed then update and upgrade the distribution
RUN apt-get update && apt-get install -y apt-utils dialog sudo build-essential debian-keyring && apt-get dist-upgrade -y

# Pull in RVM's deployment gpg key and install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && curl -sSL https://get.rvm.io | sudo bash -s stable

# Let's add a user for everything to run under other than root, and make sure they are in the RVM and sudo groups.
RUN useradd -m -c "CSTG Default User Account" cstg -s /bin/bash && usermod -aG rvm,sudo cstg

# First, lets add Node.JS. We're using the NodeSource.Com PPA for this.
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && apt-get install -y nodejs

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD 
# instructions that follow it in the Dockerfile. If the WORKDIR doesnt exist, it will be created 
# even if its not used in any subsequent Dockerfile instruction
WORKDIR /usr/src/app

# Check this command. Need to see if rvm.sh is already parsed. If it is, we don't need this.
# Commented out until we are sure.
RUN echo '. /etc/profile.d/rvm.sh' >> /home/cstg/.bash_profile

# Now we add all supported database connection gems to the image
RUN gem install mysql pg sqlite3

# Ensure proper permissions and ownership of all directories and files under WORKDIR
RUN chown -R cstg:cstg .
RUN find . -type f -exec chmod 644 {} \; && find . -type d -exec chmod 755 {} \;

# Let's change to the CSTG user now. 
# REMEMBER, ALL FURTHER COMMANDS REQUIRING ROOT PRIVS MUST BE PREFACED WITH 'sudo'
ONBUILD USER cstg

