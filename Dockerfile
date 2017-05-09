FROM jboss/wildfly:9.0.2.Final

COPY standalone.patch /tmp/standalone.patch

USER root

RUN yum install -y patch \
 && yum clean all \
 && patch $JBOSS_HOME/standalone/configuration/standalone.xml /tmp/standalone.patch \
 && echo "2420a107fd55bd46541844a0f43d4cdf  $JBOSS_HOME/standalone/configuration/standalone.xml" | md5sum - \
 && rm -f /tmp/standalone.patch \
 && curl -fsSL https://repo1.maven.org/maven2/mysql/mysql-connector-java/6.0.6/mysql-connector-java-6.0.6.jar > $JBOSS_HOME/modules/mysql/jdbc/main/mysql-connector-java-6.0.6.jar \
 && echo "2420a107fd55bd46541844a0f43d4cdf  $JBOSS_HOME/modules/mysql/jdbc/main/mysql-connector-java-6.0.6.jar" | md5sum -
