#https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy-20220301

RUN apt-get update && \
    apt-get -y install sudo snapd git

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN sudo apt-get install android-sdk --assume-yes

COPY ./src ./docker_flutter
WORKDIR /docker_flutter

RUN git clone https://github.com/flutter/flutter.git -b stable


RUN  export PATH=~/docker_flutter/flutter/bin:$PATH

RUN  echo $PATH

RUN flutter doctor