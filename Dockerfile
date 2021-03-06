FROM        ubuntu:16.04
MAINTAINER  Paul D. Hein <pauldhein@email.arizona.edu>
CMD         bash

RUN apt-get update && apt-get install -y \
    build-essential libssl-dev uuid-dev libgpgme11-dev \
    squashfs-tools libseccomp-dev wget pkg-config git cryptsetup-bin

ARG VERSION=1.15
ARG OS=linux
ARG ARCH=amd64

WORKDIR /usr/local/
RUN wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
RUN tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
RUN rm go$VERSION.$OS-$ARCH.tar.gz

RUN echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
ENV PATH=/usr/local/go/bin:$PATH
ARG SING_VERSION=3.6.3

WORKDIR /
RUN wget https://github.com/sylabs/singularity/releases/download/v${SING_VERSION}/singularity-${SING_VERSION}.tar.gz
RUN tar -xzf singularity-${SING_VERSION}.tar.gz
WORKDIR /singularity
RUN ./mconfig && make -C builddir && make -C builddir install
RUN mkdir -p /tmp/sing-files/
WORKDIR /tmp/sing-files
