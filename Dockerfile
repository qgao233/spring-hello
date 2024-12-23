# 使用官方Maven镜像作为构建阶段
FROM maven:3.8.5-openjdk-11 AS maven_build

# 将pom.xml和源代码复制到容器中
COPY pom.xml /app/
COPY src /app/src/

# 设置工作目录
WORKDIR /app

# 使用Maven构建项目
RUN mvn package

# 使用官方Java 11镜像作为运行环境
FROM openjdk:11

# 暴露容器的8080端口
EXPOSE 8080

# 从构建阶段复制构建好的jar文件到运行环境
COPY --from=maven_build /app/target/hello-0.0.1-SNAPSHOT.jar /app/hello-0.0.1-SNAPSHOT.jar

# 设置容器启动时执行的命令
CMD ["java", "-jar", "/app/hello-0.0.1-SNAPSHOT.jar"]