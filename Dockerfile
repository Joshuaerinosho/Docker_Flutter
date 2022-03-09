#https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy-20220301

RUN apt-get update && \
    apt-get -y install sudo snapd

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN sudo apt-get install android-sdk --assume-yes

RUN git clone https://github.com/flutter/flutter.git -b stable

RUN export PATH="$PATH:`pwd`/flutter/bin"

RUN flutter doctor
