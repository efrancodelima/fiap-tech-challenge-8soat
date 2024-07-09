# Use a imagem oficial do MySQL 8.4.0 LTS
FROM mysql:8.4.0

# Defina as variáveis de ambiente para o MySQL
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=lanchonete
ENV MYSQL_USER=user_fiap
ENV MYSQL_PASSWORD=password_fiap
ENV MYSQL_ROOT_HOST=%

# Copie o script SQL para o diretório de inicialização do MySQL
COPY script.sql /docker-entrypoint-initdb.d/

# Execute o servidor MySQL em primeiro plano
CMD ["mysqld"]