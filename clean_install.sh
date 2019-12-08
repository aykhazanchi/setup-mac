#! /usr/bin/env bash

#--------------------------------------------------------
# Prerequisite files: hosts, .gitignore
# TODO: Create .gitignore file
# TODO: Create ssh config file - don't upload this
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

# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
sh ~/.bash_it/install.sh

# Set zork theme
sed -i '' "s/BASH_IT_THEME='bobby'/BASH_IT_THEME='zork'/g" ~/.bash_profile

# Source .bashrc to port between linux and mac
echo 'if [ -f ~/.bashrc ]; then' >> ~/.bash_profile_new
echo '  . ~/.bashrc' >> ~/.bash_profile_new
echo 'fi' >> ~/.bash_profile_new
echo '' >> ~/.bash_profile_new
cat ~/.bash_profile >> ~/.bash_profile_new
rm ~/.bash_profile
mv ~/.bash_profile_new ~/.bash_profile
source ~/.bash_profile

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install pip3 and python3 from brew
brew install python3
brew install pip3

# Install ansible from pip
pip3 install --user ansible
pip3 install --upgrade setuptools
pip3 install --upgrade pip
pip3 install virtualenv
pip3 install virtualenvwrapper

# Run ansible to setup mac
cd ~/workspace/setup-mac
ansible-playbook -i hosts packages.yaml --verbose

# Install tgenv (not in brew)
git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv

# Set PATHs
echo 'export PATH="$HOME/.tgenv/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc

tgenv install latest
tfenv install latest

echo 'eval "$(jenv init -)"' >> ~/.bashrc
jenv enable-plugin export
jenv add $(/usr/libexec/java_home)

# Setup ssh
mkdir ~/.ssh
chmod 0700 ~/.ssh

echo 'Host *' >> ~/.ssh/config
echo '  AddKeysToAgent yes' >> ~/.ssh/config
echo '  UseKeychain yes' >> ~/.ssh/config
echo '  IdentityFile ~/.ssh/akzn' >> ~/.ssh/config
echo '  ServerAliveInterval 60' >> ~/.ssh/config

eval "$(ssh-agent -s)"
