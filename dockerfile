# ------------ Build Stage ------------
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .

# Download dependencies early (better caching)
RUN mvn dependency:go-offline

# Copy the rest of the application
COPY src ./src

# Package the application (build the jar)
RUN mvn clean package -DskipTests

# ------------ Run Stage ------------
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose default Spring Boot port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
