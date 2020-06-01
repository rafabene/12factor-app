FROM openjdk:14

WORKDIR /usr/src/myapp
COPY target/helloworld-service-fat.jar /usr/src/myapp
COPY config.json /usr/src/myapp

EXPOSE 8080

ENTRYPOINT ["java", "-Dvertx.disableFileCPResolving=true", "-Xmx256m", "-jar", "helloworld-service-fat.jar"]
