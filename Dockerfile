# Stage 1: Build the JAR using Gradle
FROM gradle:8.14-jdk17 AS build
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew build --no-daemon

# Stage 2: Run the JAR
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
