FROM docker.io/java:openjdk-8-jdk

MAINTAINER cloudservices@liatrio.com

RUN \
  mkdir /hygieia

COPY hygieia /hygieia
WORKDIR /hygieia

VOLUME ["/hygieia/logs"]
VOLUME ["/hygieia/properties"]

EXPOSE 8080
CMD java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=/hygieia/properties/dashboard.properties
