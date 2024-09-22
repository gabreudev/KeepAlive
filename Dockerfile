# Usar uma imagem base do Maven e OpenJDK para construir o projeto
FROM maven:3.8.6-openjdk:17-jdk-slim AS build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o arquivo pom.xml e o diretório de código-fonte
COPY pom.xml .
COPY src ./src

# Construir o projeto
RUN mvn clean package -DskipTests

# Usar uma imagem base do OpenJDK para a aplicação
FROM openjdk:17-jdk-alpine

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o JAR construído do estágio anterior
COPY --from=build /app/target/KeepAlive-0.0.1-SNAPSHOT.jar app.jar

# Expor a porta que sua aplicação vai usar (por exemplo, 8080)
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
