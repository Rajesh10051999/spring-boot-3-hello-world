# Use a lightweight JDK runtime image
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the pre-built jar from host (e.g., from GitHub Actions build)
COPY /home/runner/work/spring-boot-3-hello-world/spring-boot-3-hello-world/target/spring-boot-3-hello-world-1.0.0-SNAPSHOT.jar.original app.jar

# Expose Spring Boot's default port
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
