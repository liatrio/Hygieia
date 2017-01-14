FROM docker.io/java:openjdk-8-jdk

MAINTAINER cloudservices@liatrio.com

RUN \
  mkdir /hygieia

COPY *.jar /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]
VOLUME ["/hygieia/properties"]

CMD java -jar udeploy-deployment-collector*.jar --spring.config.location=/hygieia/properties/dashboard.properties
