
FROM docker.io/java:openjdk-8-jdk

MAINTAINER Hygieia@capitalone.com


ENV SPRING_DATA_MONGODB_DATABASE=dashboard
ENV SPRING_DATA_MONGODB_HOST=mongo
ENV SPRING_DATA_MONGODB_PORT=27017
ENV SPRING_DATA_MONGODB_USERNAME=db
ENV SPRING_DATA_MONGODB_PASSWORD=dbpass

ENV AUTH_EXPIRATION_TIME=300000
ENV AUTH_SECRET=secret 


RUN \
  mkdir /hygieia

COPY hygieia /hygieia
COPY properties-builder.sh /hygieia/


WORKDIR /hygieia

VOLUME ["/hygieia/logs"]


EXPOSE 8080
CMD ./properties-builder.sh &&\
  java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=/hygieia/dashboard.properties
