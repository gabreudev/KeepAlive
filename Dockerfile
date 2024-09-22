# Fase de construção (build)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copiar o código fonte e os arquivos de configuração
COPY . .

# Executar o build do Maven para gerar o arquivo JAR
RUN mvn clean install -DskipTests

# Verificar se o diretório target foi criado e o JAR foi gerado
RUN ls -la /app/target

# Fase de execução (runtime)
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app

# Copiar o JAR gerado na fase de build para a imagem final
COPY --from=build /app/target/KeepAlive-0.0.1-SNAPSHOT.jar demo.jar

# Expor a porta da aplicação
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "demo.jar"]
