#https://hub.docker.com/_/ubuntu
FROM ubuntu:jammy-20220301

RUN apt-get update && \
    apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo snapd

RUN sudo apt-get install android-sdk --assume-yes

RUN sudo snap install flutter --classic
