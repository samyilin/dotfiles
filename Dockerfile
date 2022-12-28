FROM ubuntu:rolling

LABEL MAINTAINER "Sam Su samsu42@yahoo.ca"

LABEL DESCRIPTION "Self-contained Vim/Tmux based Workspace"

ENV DEBIAN_FRONTEND=noninteractive

RUN yes | unminimize && \
    apt-get -y --no-install-recommends upgrade && \
    apt-get install -y \
        man-db \
        curl \
        sudo \
        ssh  \
        tmux \
        git \
        vim \
        shellcheck \
        busybox \
        iputils-ping \
        bash-completion \
        wget \
        less \
        && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/dmesg.* && \
        cat /dev/null > /var/log/dmesg

COPY . /usr/share/workspace
ENTRYPOINT ["sh","/usr/share/workspace/setup","-d"]
