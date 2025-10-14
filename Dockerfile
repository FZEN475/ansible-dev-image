FROM alpine:3.22 AS ansible

RUN apk add --no-cache \
      python3=3.12.12-r0 \
      py3-pip=24.0-r2 \
      openssh-client=9.7_p1-r5 \
      git=2.45.4-r0 \
      curl=8.14.1-r2 \
      python3-dev=3.12.12-r0 && \
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
      kubernetes.core \
      community.general \
      community.crypto

COPY entrypoint.sh /
COPY ansible.cfg /etc/ansible/ansible.cfg

RUN chmod +x /entrypoint.sh

WORKDIR /source

ENTRYPOINT ["/entrypoint.sh"]