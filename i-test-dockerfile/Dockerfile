FROM postgres:15.4

# Update the package list and install wget
RUN apt-get update \
    && apt-get install -y wget git iproute2\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV FLYWAY_VERSION 9.21.1
ENV FLYWAY_URL https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz
RUN wget -qO- ${FLYWAY_URL} | tar -xvz
ENV PATH="/flyway-${FLYWAY_VERSION}:$PATH"
RUN chmod +x /flyway-${FLYWAY_VERSION}/flyway
COPY ./entrypoint.sh /docker-entrypoint-initdb.d/entrypoint.sh

