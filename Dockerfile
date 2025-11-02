FROM alpine:3.22 AS ansible

RUN apk add --no-cache \
      python3=3.12.12-r0 \
      python3-dev=3.12.12-r0 \
      py3-pip=25.1.1-r0 \
      openssh-client=10.0_p1-r9 \
      git=2.49.1-r0 \
      curl=8.14.1-r2 && \
    pip3 install --no-cache-dir --upgrade --break-system-packages \
      pip==25.2 && \
    pip3 install --no-cache-dir  --break-system-packages \
      ansible==10.7.0 \
      ansible-lint==25.9.2 \
      mitogen==0.3.29 \
      etcd3==0.12.0 \
      protobuf==3.20.1 \
      passlib==1.7.4 \
      jmespath==1.0.1  && \
    ansible-galaxy collection install \
      community.docker \
      ansible.posix \
      kubernetes.core:6.2.0 \
      community.general \
      community.crypto \
      community.hashi_vault

COPY entrypoint.sh /
COPY ansible.cfg /etc/ansible/ansible.cfg

RUN chmod +x /entrypoint.sh

WORKDIR /source

ENTRYPOINT ["/entrypoint.sh"]