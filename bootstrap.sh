#! /usr/bin/env bash

# Inspired by https://daemonza.github.io/2017/03/06/using-ansible-to-automate-my-macbook-setup/

#--------------------------------------------------------
# Prerequisite files: hosts, .gitignore
# TODO: Clean up ansible into role/setup
# TODO: Create hooks for packages/ansible vs clean setup
#--------------------------------------------------------

# Start
echo "--- Starting clean setup --- "

# Install xcode (needed for git)
xcode-select --install

while [[ ! -f "/usr/bin/xcode-select" ]]; do
  echo "Waiting on xcode tools to finish install..."
  sleep 10
done

# Get the repo
mkdir -p ~/workspace/
cd ~/workspace
git clone https://github.com/aykhazanchi/setup-mac.git .

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install --user ansible
pip3 install virtualenv
pip3 install virtualenvwrapper

echo 'export PATH="$HOME/Library/Python/3.7/bin:$PATH"' >> $HOME/.bash_profile
source $HOME/.bash_profile

# Run ansible to setup mac
cd ~/workspace/setup-mac
ansible-playbook -i hosts setup-mac.yaml --verbose
