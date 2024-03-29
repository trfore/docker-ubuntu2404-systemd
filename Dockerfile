ARG BASEOS_DIGEST
FROM docker.io/library/ubuntu:24.04${BASEOS_DIGEST:-}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    rsyslog systemd systemd-cron sudo \
    iproute2 \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

# https://bugzilla.redhat.com/show_bug.cgi?id=1046469#c11
# https://github.com/ansible-community/molecule/issues/1104
RUN rm -f /lib/systemd/system/systemd*udev* \
    && rm -f /lib/systemd/system/getty.target

STOPSIGNAL SIGRTMIN+3

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
