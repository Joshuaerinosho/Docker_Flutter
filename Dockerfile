#https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy-20220301

RUN apt-get update && \
    apt-get -y install sudo snapd git nano

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN sudo apt-get install android-sdk --assume-yes

COPY ./src ./docker_flutter
WORKDIR /docker_flutter

RUN git clone https://github.com/flutter/flutter.git -b stable

RUN nano ~/.bash_profile

RUN  export PATH=~./flutter/bin:$PATH

RUN source $HOME/.bash_profile

RUN  echo $PATH

RUN which flutter

RUN flutter doctor