FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Run
FROM amazoncorretto:21

WORKDIR /app

COPY --from=builder /app/target/*.jar jese.jar

EXPOSE 8080:8130

ENTRYPOINT ["java", "-jar", "jese.jar"]
