# docker-ubuntu2404-systemd

[![CI](https://github.com/trfore/docker-ubuntu2404-systemd/actions/workflows/ci.yml/badge.svg)](https://github.com/trfore/docker-ubuntu2404-systemd/actions/workflows/ci.yml)
[![CD](https://github.com/trfore/docker-ubuntu2404-systemd/actions/workflows/cd.yml/badge.svg)](https://github.com/trfore/docker-ubuntu2404-systemd/actions/workflows/cd.yml)

A minimal systemd enabled Ubuntu 24.04 Docker image for testing Ansible roles with Molecule.

NOTE: This image does NOT contain Ansible tooling, e.g. `ansible-core` or `yamllint`. Thus, the use case is as target host for Ansible controllers or within the Molecule `create`/`converge`/`test` cycle.

**Docker Pull Command**

```sh
docker pull trfore/docker-ubuntu2404-systemd
```

## How to Build

This image is built on Docker Hub automatically any time the upstream OS image is rebuilt, and any time a commit is made or merged to the `main` branch. But if you need to build the image on your own locally, do the following:

1. Install [docker]
2. Clone the repo, `git clone https://github.com/trfore/docker-ubuntu2404-systemd.git`
3. `cd` into the directory
4. Run `docker build --tag trfore/docker-ubuntu2404-systemd .`

## How to Use

### Within Molecule Scenario

1. Add the following code to your molecule scenario file, e.g. `molecule/default/molecule.yml`.

```yaml
platforms:
  - name: instance
    image: trfore/docker-ubuntu2404-systemd:latest
    tmpfs:
      - /run
      - /tmp
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
    cgroupns_mode: host
    privileged: true
    pre_build_image: true
```

### Interactively Using Docker

1. Install [docker]
2. Build an image locally (see above) or pull from Docker Hub: `docker pull trfore/docker-ubuntu2404-systemd:latest`
3. Run a container from the image:

```sh
docker run -d -it --name ubuntu2404-systemd --privileged --cgroupns=host --tmpfs=/run --tmpfs=/tmp --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw trfore/docker-ubuntu2404-systemd:latest
```

4. Use it, example:

```sh
docker exec -it ubuntu2404-systemd /bin/bash
```

### Using Podman

- Podman defaults to running containers in systemd mode, `--systemd=true`, and will mount the required tmpfs and cgroup filesystem. See [Podman Docs: Commands `run --systemd`] for details.

```sh
podman run -d -it --name ubuntu2404-systemd docker.io/trfore/docker-ubuntu2404-systemd:latest
```

## Additional Images

| Base OS                          | Github                      | Docker Hub                         |
| -------------------------------- | --------------------------- | ---------------------------------- |
| [CentOS Stream 8][centos-stream] | [docker-centos8-systemd]    | [trfore/docker-centos8-systemd]    |
| [CentOS Stream 9][centos-stream] | [docker-centos9-systemd]    | [trfore/docker-centos9-systemd]    |
| [Debian 10][debian]              | [docker-debian10-systemd]   | [trfore/docker-debian10-systemd]   |
| [Debian 11][debian]              | [docker-debian11-systemd]   | [trfore/docker-debian11-systemd]   |
| [Debian 12][debian]              | [docker-debian12-systemd]   | [trfore/docker-debian12-systemd]   |
| [Ubuntu 20.04][ubuntu]           | [docker-ubuntu2004-systemd] | [trfore/docker-ubuntu2004-systemd] |
| [Ubuntu 22.04][ubuntu]           | [docker-ubuntu2204-systemd] | [trfore/docker-ubuntu2204-systemd] |
| [Ubuntu 24.04][ubuntu]           | [docker-ubuntu2404-systemd] | [trfore/docker-ubuntu2404-systemd] |

## Maintainers

Taylor Fore (https://github.com/trfore)

## Acknowledgements

Inspired by Jeff Geerling's ([@geerlingguy](https://github.com/geerlingguy)), CentOS 8, Debian 10/11, and Ubuntu 20/22 docker images for ansible, [geerlingguy/docker-\*-ansible](https://github.com/geerlingguy?tab=repositories&q=docker-ansible).

## References

- https://molecule.readthedocs.io/en/stable/index.html
- https://molecule.readthedocs.io/en/stable/examples.html#systemd-container
- https://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container
- [github runner - ubuntu 20.04] preinstalled software
- [github runner - ubuntu 22.04] preinstalled software

[alpine]: https://hub.docker.com/_/alpine/
[centos]: https://hub.docker.com/_/centos/
[centos-stream]: https://quay.io/repository/centos/centos?tab=tags
[debian]: https://hub.docker.com/_/debian/
[docker]: https://docs.docker.com/engine/installation/
[rocky]: https://hub.docker.com/r/rockylinux/
[ubuntu]: https://hub.docker.com/_/ubuntu/
[docker-centos8-systemd]: https://github.com/trfore/docker-centos8-systemd/blob/main/Dockerfile
[docker-centos9-systemd]: https://github.com/trfore/docker-centos9-systemd/blob/main/Dockerfile
[docker-debian10-systemd]: https://github.com/trfore/docker-debian10-systemd/blob/main/Dockerfile
[docker-debian11-systemd]: https://github.com/trfore/docker-debian11-systemd/blob/main/Dockerfile
[docker-debian12-systemd]: https://github.com/trfore/docker-debian11-systemd/blob/main/Dockerfile
[docker-ubuntu2004-systemd]: https://github.com/trfore/docker-ubuntu2004-systemd/blob/main/Dockerfile
[docker-ubuntu2204-systemd]: https://github.com/trfore/docker-ubuntu2204-systemd/blob/main/Dockerfile
[docker-ubuntu2404-systemd]: https://github.com/trfore/docker-ubuntu2404-systemd/blob/main/Dockerfile
[trfore/docker-centos8-systemd]: https://hub.docker.com/r/trfore/docker-centos8-systemd
[trfore/docker-centos9-systemd]: https://hub.docker.com/r/trfore/docker-centos9-systemd
[trfore/docker-debian10-systemd]: https://hub.docker.com/r/trfore/docker-debian10-systemd
[trfore/docker-debian11-systemd]: https://hub.docker.com/r/trfore/docker-debian11-systemd
[trfore/docker-debian12-systemd]: https://hub.docker.com/r/trfore/docker-debian12-systemd
[trfore/docker-ubuntu2004-systemd]: https://hub.docker.com/r/trfore/docker-ubuntu2004-systemd
[trfore/docker-ubuntu2204-systemd]: https://hub.docker.com/r/trfore/docker-ubuntu2204-systemd
[trfore/docker-ubuntu2404-systemd]: https://hub.docker.com/r/trfore/docker-ubuntu2404-systemd
[github runner - ubuntu 20.04]: https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2004-Readme.md
[github runner - ubuntu 22.04]: https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2204-Readme.md
[Podman Docs: Commands `run --systemd`]: https://docs.podman.io/en/latest/markdown/podman-run.1.html#systemd-true-false-always
