# Usar uma imagem base do OpenJDK
FROM openjdk:18-jdk-alpine

# Definir o diretório de trabalho
WORKDIR /app

# Copiar o arquivo JAR para o contêiner
COPY target/KeepAlive-0.0.1-SNAPSHOT.jar app.jar

# Expor a porta que sua aplicação vai usar (por exemplo, 8080)
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]