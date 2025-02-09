#!/usr/bin/env ash



function init_ssh_access() {
  mkdir -p /root/.ssh/
  [ -f /root/.ssh/id_ed25519 ] || cp /run/secrets/id_ed25519 /root/.ssh/ && chmod 0600 /root/.ssh/id_ed25519
  ssh-keyscan 192.168.2.1 >> /root/.ssh/known_hosts
  ssh-keyscan github.com >> /root/.ssh/known_hosts
  echo "
    Host 192.168.2.1
        HostName 192.168.2.1
        User root
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
    " > ~/.ssh/config
}

# shellcheck disable=SC2120
function init_ansible() {
  [[ -d  /source ]] || rm -rf /source && mkdir -p /source
  git clone "${ANSIBLE_REPO}" /source
  [[ -d  /source/playbooks/library ]] || rm -rf /source/playbooks/library && mkdir -p /source/playbooks/library
  git clone https://github.com/FZEN475/ansible-library.git /source/playbooks/library
  [[ -f  /inventory.yaml ]] || mv -rf /inventory.yaml /source/
  scp -O "${ANSIBLE_INVENTORY_CSP_PATH}" /source/
}

env

init_ssh_access
# shellcheck disable=SC2119
init_ansible
ansible-lint /source/playbook.yaml
cat /source/inventory.json
cat /source/inventory.yaml
cat /source/playbook.yaml
ansible-playbook /source/playbook.yaml -i /source/inventory.json -i /source/inventory.yaml
