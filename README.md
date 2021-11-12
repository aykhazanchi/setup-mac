# setup-mac

Ansible and bash automation script to setup a new mac with my preferred settings.

### Modifications
- To modify the `login user`, `brew taps`, `brew packages`, and `mas apps` (app store) it installs: `roles/install/vars/main.yaml`

- To modify the `brew casks`: `roles/install/brew_casks.yaml`

- To modify the `.bashrc` settings: `roles/install/tasks/config.yaml`

- To modify the OSX settings: `dotfiles.sh`

### Steps to run the script:
1. cd ~ && `wget https://raw.githubusercontent.com/aykhazanchi/setup-mac/master/bootstrap.sh`
2. `sh bootstrap.sh`