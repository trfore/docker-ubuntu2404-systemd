ARG BASEOS_DIGEST
FROM docker.io/library/debian:10${BASEOS_DIGEST:-}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    procps systemd systemd-sysv sudo \
    libffi-dev libssl-dev python3 \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

STOPSIGNAL SIGRTMIN+3

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/init"]
