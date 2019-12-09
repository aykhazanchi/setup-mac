#! /usr/bin/env bash

# Inspired by https://daemonza.github.io/2017/03/06/using-ansible-to-automate-my-macbook-setup/

#--------------------------------------------------------
# Prerequisite files: hosts, .gitignore
# TODO: Clean up ansible into role/setup
# TODO: Create hooks for packages/ansible vs clean setup
#--------------------------------------------------------

# Start
echo "--- Starting clean setup --- "
mkdir -p ~/workspace/setup

# Get the repo
cd ~/workspace
git clone git@github.com:aykhazanchi/setup-mac.git .

# Install xcode
xcode-select --install

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install pip3 and python3 from brew
brew install python3
brew install pip3

pip3 install --upgrade pip
pip3 install --user ansible
pip3 install --upgrade setuptools
pip3 install virtualenv
pip3 install virtualenvwrapper

# Run ansible to setup mac
cd ~/workspace/setup-mac
ansible-playbook -i hosts setup-mac.yaml --verbose