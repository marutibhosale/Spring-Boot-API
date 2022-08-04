#FROM ubuntu
FROM 863522791199.dkr.ecr.us-east-1.amazonaws.com/cleancity/docker-io-cache@sha256:d5108131d876f68ea77d876a2aa236f69099c0e49a317a9a92afdbf1ce80d872
RUN apt-get update && \
    apt-get install -y wget
ARG JDK_VERSION=11.0.15
ARG MAVEN_VERSION=3.5.2
RUN wget https://aka.ms/download-jdk/microsoft-jdk-${JDK_VERSION}-linux-x64.tar.gz -P /tmp && \
    tar xf /tmp/microsoft-jdk-${JDK_VERSION}-linux-x64.tar.gz -C /opt && \
    ln -s /opt/jdk-${JDK_VERSION}+10 /opt/jdk
ENV JAVA_HOME=/opt/jdk
ENV PATH=${JAVA_HOME}/bin:${PATH}
RUN java --version
RUN wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}/apache-maven-${MAVEN_VERSION}-bin.tar.gz -P /tmp && \
    tar xf /tmp/apache-maven-*.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}
COPY . /opt
WORKDIR /opt
RUN    mvn package -Dmaven.test.skip=true
RUN mvn --version
CMD ["sleep","infinity"]
