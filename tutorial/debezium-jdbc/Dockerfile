FROM debezium/connect:1.8
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc

ARG KAFKA_JDBC_VERSION=5.3.2

RUN cd $MAVEN_DEP_DESTINATION &&\ 
  curl -L 'https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/sqljdbc_6.0.8112.200_enu.tar.gz'| tar xz &&\
  cp ./sqljdbc_6.0/enu/jre8/sqljdbc42.jar $MAVEN_DEP_DESTINATION &&\
  rm -rf sqljdbc_6.0

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar