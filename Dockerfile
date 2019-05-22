FROM maven:3.6.0-jdk-11 as BUILD

ADD local/m2.tar.gz /opt
COPY . /usr/src/app
RUN export MAVEN_OPTS="-Xmx2048m -Xms1024m -XX:MaxPermSize=512m -Djava.awt.headless=true" && \
     mvn  --batch-mode -f /usr/src/app/pom.xml -Dmaven.repo.local=/opt/m2 clean package &&   \
     cp /usr/src/app/target/app.war /usr/src/app/target/app.jar

FROM openjdk:11.0.2-oracle as PACKAGER

COPY --from=BUILD  /usr/src/app/target/app.jar /opt
RUN jlink --output /opt/jre-slim --add-modules $(jdeps --print-module-deps /opt/app.jar),java.xml,jdk.unsupported,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument,jdk.jdwp.agent --no-header-files --no-man-pages --compress=2

From  debian:9-slim

COPY --from=PACKAGER /opt/jre-slim /opt/jre-slim
COPY --from=BUILD /usr/src/app/target/app.war  /opt/app.war

EXPOSE 8080 5005

ENV _JAVA_OPTIONS '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005'

CMD ["/opt/jre-slim/bin/java", "-jar", "/opt/app.war"]
