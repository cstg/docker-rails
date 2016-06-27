# Docker-Rails

*Docker-Rails* is a Dockerfile for creating a dockerized [Ruby on Rails](https://rubyonrails.org) 
with [Ruby](https://ruby-lang.org) which deploys on [Ubuntu](http://www.ubuntu.com). Please note, you will need to have 
[Docker](https://www.docker.com) installed to make use of this file.

The docker ``WORKDIR`` is set to ``/usr/src/app`` but you can change it to whatever your needs are.

## What's in an image?

Currently, the image incorporates the following:

  - Ruby On Rails v4.2.6
  - Ruby v2.3.1p112
  - Bundler 1.12.5
  - RSpec v3.4.1

## Pre-loaded Gems

The following additional gems are installed as well:

  - RSpec v3.4.0
  - RSpec-Rails v3.4.2
  - FactoryGirl + FactoryGirlRails v4.7.0
  - Shoulda v3.5.0
  - Shoulda-Matchers v2.8.0
  - ByeBug v9.0.5
  - Pry-Rails v0.3.4 (This pulls in Pry v0.10.3)
  - Capybara-Rails + DatabaseCleaner
  - Capistrano-Rails
  - Faker
  - SimpleCov (aka Simple Coverage. Gem to help you see how much of your code is covered by tests)

## Database Support

The image created by this Dockerfile supports:

  - PostgreSQL
  - MySQL
  - SQLite3

out of the box. All necessary headers, libraries, and associated gems are preinstalled.

## JavaScript Support

  This image pre-installs [Node.JS v4.4.6 LTS](https://nodejs.org/dist/latest-v4.x/docs/api/) with NPM v2.15.5. This is done using the [NodeSource](https://nodesource.com) Debian and Ubuntu binary distributions repository (formerly [Chris Lea's](https://github.com/chrislea) Launchpad PPA). 

  Support for this repository, along with its scripts, can be found on [GitHub](https://github.com) at [nodesource/distributions](https://github.com/nodesource/distributions).

## Dockerfile Usage

  0 - Sign up for, and confirm, a [Docker Hub ID](https://hub.docker.com). You'll need it later

  1 - Install and configure [Docker](https://www.docker.com). 
      See [docs.docker.com](https://docs.docker.com) for OS-specific instructions.
      Once you've installed, configured, and executed Docker, you will need to 
      log into the Docker Hub vi ``docker login``. See ``docker login --help`` for more info.
  
  2 - Clone this repository into WORKDIR via ``git clone https://github.com/ddd/docker-rails.git``
  
  3 - run ``docker build -t your_docker_hub_username/name_of_image:tag_name .``

  4 - Push your new image up to your Docker Hub account via: 
  	``docker push your_docker_hub_username/name_of_image:tag_name``

  5 - You can now use your image as the basis for your own personal/private application builds.
 

NOTE: The above steps assume you want to modify this for your own use. If you want to base off it, Step 2 should be changed to you creating your own Dockerfile
      with its FROM set to ``FROM deryldowney/rails:latest`` or ``FROM deryldowney/rails:4.2.6`` and the remaining steps staying the same.


