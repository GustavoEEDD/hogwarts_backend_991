# Usamos una imagen de Maven con JDK 23 para construir la aplicacion
FROM maven:3.9-eclipse-temurin-23 AS imagen_construccion

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el pom.xml y el codigo fuente
COPY pom.xml .
COPY src ./src

# Empaquetamos el proyecto con Maven
RUN mvn clean package -DskipTests

# Generamos la imagen con el JRE o JDK
FROM eclipse-temurin:23-jre AS imagen_ejecucion

WORKDIR /app

# Copiamos el .jar segun el pom.xml
COPY --from=imagen_construccion /app/target/*.jar app.jar

# Exponemos el puerto tipico de Spring Boot (se puede cambiar si usa otro)
EXPOSE 8080

# Comando para arrancar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
