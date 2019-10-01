FROM        ubuntu:16.04
MAINTAINER  Paul D. Hein <pauldhein@email.arizona.edu>
CMD         bash

RUN apt-get update && apt-get install -y \
    build-essential libssl-dev uuid-dev libgpgme11-dev \
    squashfs-tools libseccomp-dev wget pkg-config git

ARG VERSION=1.12
ARG OS=linux
ARG ARCH=amd64

RUN wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
RUN tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
RUN rm go$VERSION.$OS-$ARCH.tar.gz

RUN echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc && \
  source ~/.bashrc

ARG SING_VERSION=3.4.0

RUN wget https://github.com/sylabs/singularity/releases/download/v${SING_VERSION}/singularity-${SING_VERSION}.tar.gz
RUN tar -xzf singularity-${SING_VERSION}.tar.gz && cd singularity
RUN ./mconfig && make -C builddir && make -C builddir install
