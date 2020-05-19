FROM maven:3.6.3-jdk-14 AS build
COPY src /usr/src/server/src
COPY pom.xml /usr/src/server
RUN mvn -v
RUN mvn -f /usr/src/server/pom.xml dependency:go-offline
RUN mvn -f /usr/src/server/pom.xml clean package

#FROM gcr.io/distroless/java
FROM openjdk:14
RUN java --version
COPY --from=build /usr/src/server/target /usr/server/target
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/server/target/EpiCovid-0.0.1-SNAPSHOT.jar"]