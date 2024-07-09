USE lanchonete;

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cpf BIGINT NOT NULL,
	data_nascimento DATE NOT NULL,
	genero ENUM('Feminino', 'Masculino', 'Não binário') NOT NULL,
    email VARCHAR(50)
);

CREATE TABLE telefone (
    cliente_id INT NOT NULL,
    tipo_telefone ENUM('Celular', 'Residencial', 'Trabalho', 'Recado') NOT NULL,
    ddd CHAR(2) NOT NULL,
    numero CHAR(8) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
	CONSTRAINT uk_telefone_cliente UNIQUE (cliente_id, tipo_telefone, ddd, numero)
);

CREATE TABLE categoria_produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria_produto(id)
);

CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE item_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id),
    FOREIGN KEY (produto_id) REFERENCES produto(id)
);

CREATE TABLE fila_pedido (
    pedido_id INT NOT NULL,
    timestamp TIMESTAMP,
    situacao ENUM('Recebido', 'Em preparação', 'Aguardando retirada','Pedido finalizado') NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

GRANT ALL PRIVILEGES ON lanchonete.* TO 'user_fiap'@'%';
FLUSH PRIVILEGES;
