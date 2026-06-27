# 1. Use a tiny, secure base image
FROM eclipse-temurin:21-jre-alpine

# 2. Set the working directory
WORKDIR /app

# 3. Define the argument for the JAR location
ARG JAR_FILE=target/*.jar

# 4. Copy ONLY the built jar into the container
# Renaming it here makes the ENTRYPOINT consistent across all your services
COPY ${JAR_FILE} app.jar

# 5. Security: don't run as root
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# 6. Inform Docker that the container listens on this port
EXPOSE 8761

# 7. Optimized Runtime settings
# Using "app.jar" here allows you to reuse this Dockerfile template for other services
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]


