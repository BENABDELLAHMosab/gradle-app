FROM eclipse-temurin:11-jre

WORKDIR /app

COPY build/libs/*.jar app.jar

CMD ["java", "-cp", "app.jar", "simple.gradle.java.app.App"]
