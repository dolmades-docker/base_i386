FROM i386/ubuntu:18.04

MAINTAINER Stefan Kombrink

RUN apt-get update && apt-get -y install yad wget less vim software-properties-common python3-software-properties apt-transport-https winbind p7zip-full x11-xserver-utils wmctrl xvfb xosd-bin language-pack-en-base && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget https://dl.winehq.org/wine-builds/winehq.key && apt-key add winehq.key && apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ && rm winehq.key
RUN mkdir -p /wineprefix && chmod +rwx /wineprefix && echo 'source /.dolmades/start.env' >> /etc/bash.bashrc

COPY wrapper.sh     /usr/local/bin/wrapper.sh
COPY targetLauncher /usr/local/bin/targetLauncher
COPY .dolmades /.dolmades 
COPY deb/ /deb
RUN dpkg -i /deb/*.deb

ENV WINEPREFIX /wineprefix
ENV WINEARCH win32
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
