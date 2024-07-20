# Os comandos abaixo foram testados no linux Ubuntu 22.04.4 LTS usando o docker 27.0.2 e o docker-compose 1.26.0

# Cria a imagem docker
docker build -t bd-lanchonete .

# Executa o docker-compose, que irá subir os containers do projeto
docker-compose up -d

# Acessa o container pelo terminal e loga no mysql
docker exec -it bd-lanchonete mysql -u user_fiap -p

# Para os serviços do docker-compose
docker-compose down


# OUTROS COMANDOS

# Visualiza o log do container
docker logs bd-lanchonete

# Comandos para recriar o banco de dados
# Útil quando alguma coisa é alterada no script sql
# Para e remove o container
# Remove e cria novamente a imagem
# Sobe o container e acessa o mysql pelo terminal
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
docker exec -it bd-lanchonete mysql -u user_fiap -p
    password_fiap
    use lanchonete;
    select * from pedido;

