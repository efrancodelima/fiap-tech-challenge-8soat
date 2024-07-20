# Usa a imagem oficial do MySQL 8.4.0 LTS
FROM mysql:8.4.0

# Define os argumentos de build
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_HOST

# Define as variáveis de ambiente
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_HOST=${MYSQL_ROOT_HOST}

# Copia o script SQL para o diretório de inicialização do MySQL
COPY script.sql /docker-entrypoint-initdb.d/