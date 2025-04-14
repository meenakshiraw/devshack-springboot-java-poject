# Stage 1: Build the application using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY pom.xml .
COPY src ./src

# Build the project and skip tests if you want faster build
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight image with just the built app
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the jar from the previous build stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port if your app runs on a specific port (optional)
EXPOSE 9090

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

