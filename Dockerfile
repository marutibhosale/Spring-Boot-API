FROM ubuntu
USER root
RUN apt-get update && apt-get install -y maven
COPY . /opt
WORKDIR /opt
RUN    mvn package -Dmaven.test.skip=true
CMD ["sleep","300"]
