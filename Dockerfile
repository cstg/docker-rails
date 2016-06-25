FROM rails:4.2.6

RUN apt-get -y update 
RUN apt-get install -y dialog apt-utils sudo
RUN apt-get dist-upgrade -y
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | sudo bash -s stable
RUN . /etc/profile.d/rvm.sh

WORKDIR /usr/src/app


