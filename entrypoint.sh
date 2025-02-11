#!/usr/bin/env ash

function init_ssh_access() {
  mkdir -p /root/.ssh/
  [ -f /root/.ssh/id_ed25519 ] || cp /run/secrets/id_ed25519 /root/.ssh/ && chmod 0600 /root/.ssh/id_ed25519
  ssh-keyscan "${SECURE_SERVER}" >> /root/.ssh/known_hosts
  ssh-keyscan github.com >> /root/.ssh/known_hosts
  echo "
    Host ${SECURE_SERVER}
        HostName ${SECURE_SERVER}
        User root
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
    " > ~/.ssh/config
}

# shellcheck disable=SC2120
function init_ansible() {
  mkdir -p /source
  git clone "${GIT_EXTRA_PARAM}" "${ANSIBLE_REPO}" /source
  [[ -d  /source/playbooks/library ]] || rm -rf /source/playbooks/library && mkdir -p /source/playbooks/library
  git clone "${LIBRARY}" /source/playbooks/library
    scp -O "${SECURE_SERVER}:${SECURE_PATH}structure.yaml" /source
    scp -O "${SECURE_SERVER}:${SECURE_PATH}inventory.json" /source
}

init_ssh_access
init_ansible
ansible-lint /source/playbook.yaml
ansible-playbook /source/playbook.yaml -i /source/inventory.json -i /source/structure.yaml
