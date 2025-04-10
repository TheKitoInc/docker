FROM thekitoinc/debian:latest

RUN upgrade

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install mosquitto -y
RUN apt-get install mosquitto-clients -y


RUN echo "listener 1883" > /etc/mosquitto/conf.d/mqtt.port.conf
RUN echo "protocol mqtt" >> /etc/mosquitto/conf.d/mqtt.port.conf
ENTRYPOINT [ "mosquitto" ]