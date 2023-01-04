FROM openjdk:17-jdk

ARG JAR=spring-petclinic-3.0.0-SNAPSHOT.jar

ENV JAVA_OPTS=''

RUN useradd Hanna
USER Hanna

COPY target/$JAR /petclinic.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar","/petclinic.jar"]
