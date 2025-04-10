FROM thekitoinc/debian-python:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install supervisor -y

WORKDIR /
COPY root/ /

ENTRYPOINT [ "supervisord" , "-c" , "/etc/supervisor/supervisord.conf" ]