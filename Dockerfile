FROM maven:3.9.6-eclipse-temurin-8

LABEL maintainer="vouu <contact@manhtuong.net>" version="7.19.5"

ARG ATLASSIAN_PRODUCTION=bitbucket
ARG APP_NAME=bitbucket
ARG APP_VERSION=8.19.10
ARG AGENT_VERSION=1
ARG MYSQL_DRIVER_VERSION=8.0.22

ENV BITBUCKET_HOME=/var/bitbucket \
    BITBUCKET_INSTALL=/opt/bitbucket \
    JVM_MINIMUM_MEMORY=1g \
    JVM_MAXIMUM_MEMORY=3g \
    JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g' \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar \
    LIB_PATH=/bitbucket/WEB-INF/lib

ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"
RUN mkdir -p ${BITBUCKET_INSTALL} ${BITBUCKET_HOME} ${AGENT_PATH} ${BITBUCKET_INSTALL}${LIB_PATH} \
&& curl -o ${AGENT_PATH}/${AGENT_FILENAME}  https://github.com/vncloudsco/random/releases/download/v${AGENT_VERSION}/agent.jar -L \
&& curl -o /tmp/atlassian.tar.gz https://product-downloads.atlassian.com/software/stash/downloads/atlassian-${APP_NAME}-${APP_VERSION}.tar.gz -L \
&& tar xzf /tmp/atlassian.tar.gz -C /opt/bitbucket/ --strip-components 1 \
&& rm -f /tmp/atlassian.tar.gz 
WORKDIR $BITBUCKET_INSTALL
EXPOSE 8090