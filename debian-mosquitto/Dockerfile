FROM thekitoinc/debian:latest

RUN upgrade

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install mosquitto -y
RUN apt-get install mosquitto-clients -y


RUN echo "listener 1883" > /etc/mosquitto/conf.d/mqtt.port.conf
RUN echo "protocol mqtt" >> /etc/mosquitto/conf.d/mqtt.port.conf

#RUN echo "listener 8883" > /etc/mosquitto/conf.d/mqtts.port.conf
#RUN echo "protocol mqtt" >> /etc/mosquitto/conf.d/mqtts.port.conf
#RUN echo "require_certificate false" >> /etc/mosquitto/conf.d/mqtts.port.conf

#RUN echo "listener 9001" > /etc/mosquitto/conf.d/ws.port.conf
#RUN echo "protocol websockets" >> /etc/mosquitto/conf.d/ws.port.conf

#RUN echo "listener 9002" > /etc/mosquitto/conf.d/wss.port.conf
#RUN echo "protocol websockets" >> /etc/mosquitto/conf.d/wss.port.conf
#RUN echo "require_certificate false" >> /etc/mosquitto/conf.d/wss.port.conf

ENTRYPOINT [ "mosquitto" ]