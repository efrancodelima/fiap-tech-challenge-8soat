# PROJETO
**Tech Challenge - Fase 1**  
FIAP - Curso de Especialização em Software Architecture

## OBJETIVOS
Desenvolver um sistema para uma lanchonete.  
Uma aplicação backend (monolito) seguindo os padrões apresentados nas aulas.

### Utilizando arquitetura hexagonal
Sistemas que favorecem reusabilidade de código, alta coesão, baixo acoplamento, independência de tecnologia e que são mais fáceis de serem testados.

### APIs:
- Cadastro do Cliente
- Identificação do Cliente via CPF
- Criar, editar e remover produtos
- Buscar produtos por categoria
- Fake checkout, apenas enviar os produtos escolhidos para a fila. O checkout é a finalização do pedido.
- Listar os pedidos

### Banco de dados

## INSTRUÇÕES PARA RODAR O PROJETO

O projeto possui dois containeres:
- um para o banco de dados (MySQL 8.4.0);
- e outro para a aplicação back-end (Java).

O banco de dados já foi previamente populado com alguns dados de exemplo de uso.

A aplicação pode ser testada pela API (endpoints), que está documentada com o Swagger.  
Não foi desenvolvido o front-end, que está fora do escopo deste projeto.


### Iniciando o container do banco de dados
Os comandos abaixo foram testados com:
- Linux Ubuntu 22.04.4 LTS;
- Docker 27.0.2;
- Docker Compose 1.26.0.

```sh
# Crie a imagem docker e suba o container
# Acesse o diretório ./bd/ pelo terminal e execute:
docker-compose build --no-cache
docker-compose up -d

# Confira se o container foi iniciado corretamente
# O status deve estar 'Up'
docker-compose ps -a

# Em caso de falha, pare e remova o container
# Volte ao início, crie a imagem e suba o container novamente
# Atenção: o último comando irá apagar o volume de dados do container
# Use se desejar voltar o banco de dados ao seu estado inicial
docker-compose stop bd_lanchonete
docker-compose rm -f bd_lanchonete
docker volume rm bd_lanchonete_dados

# Caso queira testar o funcionamento do MySQL pelo terminal, execute:
docker exec -it bd_lanchonete mysql -u user_fiap -p
use lanchonete;
show tables;

