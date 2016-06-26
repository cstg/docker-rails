# Docker-Rails

*Docker-Rails* is a Dockerfile for creating a dockerized [Ruby on Rails](https://rubyonrails.org) 
with [RVM](https://rvm.io) which deploys on [Ubuntu](http://www.ubuntu.com). Please note, you will need to have 
[Docker](https://www.docker.com) installed to make use of this file.

The docker ``WORKDIR`` is set to ``/usr/src/app`` but you can change it to whatever your needs are.

## What's in an image?

Currently, the image incorporates the following:

- Ruby On Rails v4.2.6
- Ruby Version Manager v1.27.0
- Ruby v2.3.1p112
- Bundler 1.12.5

*Note:* RVM is installed under ``/usr/local/rvm``. You **must** add users to the 'rvm' group,
 and those users must load ``/etc/profile.d/rvm.sh``. The current Ruby installed is **NOT**
 under RVM control. 
 
 To use that ruby, users need simply execute: ``rvm use system``

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

This image pre-installs [Node.JS v4.4.6 LTS](https://nodejs.org/dist/latest-v4.x/docs/api/) with NPM v2.15.5. This is done using the [NodeSource](https://nodesource.com)
Debian and Ubuntu binary distributions repository (formerly [Chris Lea's](https://github.com/chrislea) Launchpad PPA). 

Support for this repository, along with its scripts, can be found on [GitHub](https://github.com) at 
[nodesource/distributions](https://github.com/nodesource/distributions).


