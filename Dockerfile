# Build stage
FROM gradle:8.5-jdk21 AS builder
WORKDIR /app
COPY . .
RUN gradle build

# Run stage
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

# Environment variables
ENV SERVER_PORT=8081

# Expose the application port
EXPOSE 8081

# Command to run the application
CMD ["java", "-jar", "app.jar"] 