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

# Forma alternativa para executar o container sem o docker-compose
## A porta 4567 é do host e a 3306 a do container
docker run -d --name bd-lanchonete -p 4567:3306 bd-lanchonete

# Visualiza o log do container
docker logs bd-lanchonete

# Lista os containers existentes na máquina local
docker ps -a

# Para e remove o container
# Remove e cria novamente a imagem
# Sobe o container e conecta no mysql pelo terminal
docker stop bd-lanchonete
docker rm bd-lanchonete
docker rmi bd-lanchonete
docker build -t bd-lanchonete .
docker-compose up -d
docker exec -it bd-lanchonete mysql -u user_fiap -p
password_fiap
use lanchonete
select * from pedido