# Step 1: Build Stage
# Maven వాడి కోడ్‌ని కంపైల్ చేసి JAR ఫైల్ తయారు చేయడం కోసం
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# కేవలం pom.xml ని ముందు కాపీ చేసి డిపెండెన్సీలను డౌన్‌లోడ్ చేస్తాం (Caching కోసం)
COPY pom.xml .
RUN mvn dependency:go-offline

# ఇప్పుడు పూర్తి సోర్స్ కోడ్‌ని కాపీ చేసి బిల్డ్ చేస్తాం
COPY src ./src
RUN mvn clean package -DskipTests

# Step 2: Run Stage
# అప్లికేషన్‌ని రన్ చేయడానికి చిన్న సైజు ఉన్న JRE ఇమేజ్ వాడతాం
FROM openjdk:17-jdk-slim
WORKDIR /app

# Build stage నుండి తయారైన .jar ఫైల్‌ని ఇక్కడికి కాపీ చేస్తాం
COPY --from=build /app/target/*.jar academy-service.jar

# Spring Boot సాధారణంగా 8080 పోర్ట్ వాడుతుంది
EXPOSE 8080

# అప్లికేషన్ స్టార్ట్ చేసే కమాండ్
ENTRYPOINT ["java", "-jar", "academy-service.jar"]