USE lanchonete;


-- CRIAÇÃO DAS TABELAS

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(120) NOT NULL,
    cpf BIGINT NOT NULL,
	data_nascimento DATE NOT NULL,
	genero ENUM('Feminino', 'Masculino', 'Não binário', 'Não informado') NOT NULL,
    email VARCHAR(50),
    UNIQUE KEY (cpf)
);

CREATE TABLE telefone (
    cliente_id INT NOT NULL,
    tipo_telefone ENUM('Celular', 'Residencial', 'Trabalho', 'Recado') NOT NULL,
    principal BOOLEAN DEFAULT FALSE NOT NULL,
    ddd CHAR(2) NOT NULL,
    numero VARCHAR(9) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
	CONSTRAINT uk_telefone_cliente UNIQUE (cliente_id, ddd, numero),
    CHECK (ddd REGEXP '^[0-9]{2}$'),
    CHECK (numero REGEXP '^[0-9]{8,9}$')
);

CREATE TABLE estado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sigla CHAR(2) NOT NULL
);

CREATE TABLE municipio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    estado_id INT NOT NULL,
    FOREIGN KEY (estado_id) REFERENCES estado(id)
);

CREATE TABLE endereco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    -- O campo nome é o nome do endereço
    -- Permite que o usuário dê um nome personalizado para o endereço cadastrado
    -- Exemplo: trabalho, casa da sogra, apê em São Paulo, etc.
    nome VARCHAR(20),
    principal BOOLEAN DEFAULT FALSE NOT NULL,
    cep CHAR(8) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(30) NOT NULL,
    municipio_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    FOREIGN KEY (municipio_id) REFERENCES municipio(id)
);

CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    categoria ENUM('Lanche', 'Acompanhamento', 'Bebida', 'Sobremesa') NOT NULL
);

CREATE TABLE pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
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
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    situacao ENUM('Recebido', 'Em preparação', 'Pronto','Finalizado') NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);


-- TRIGGERS

DELIMITER //

CREATE TRIGGER before_insert_telefone
BEFORE INSERT ON telefone
FOR EACH ROW
BEGIN
	IF NEW.principal THEN
		IF (SELECT COUNT(*) FROM telefone WHERE cliente_id = NEW.cliente_id AND principal = TRUE) > 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O cliente já possui um telefone principal.';
		END IF;
	END IF;
END;
//

CREATE TRIGGER before_update_telefone
BEFORE UPDATE ON telefone
FOR EACH ROW
BEGIN
	IF NEW.principal AND OLD.principal = FALSE THEN
		IF (SELECT COUNT(*) FROM telefone WHERE cliente_id = NEW.cliente_id AND principal = TRUE) > 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O cliente já possui um telefone principal.';
		END IF;
	END IF;
END;
//

CREATE TRIGGER before_insert_endereco
BEFORE INSERT ON endereco
FOR EACH ROW
BEGIN
    IF NEW.principal THEN
        IF (SELECT COUNT(*) FROM endereco WHERE cliente_id = NEW.cliente_id AND principal = TRUE) > 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O cliente já possui um endereço principal.';
		END IF;
    END IF;
END;
//

CREATE TRIGGER before_update_endereco
BEFORE UPDATE ON endereco
FOR EACH ROW
BEGIN
    IF NEW.principal AND OLD.principal = FALSE THEN
        IF (SELECT COUNT(*) FROM endereco WHERE cliente_id = NEW.cliente_id AND principal = TRUE) > 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O cliente já possui um endereço principal.';
		END IF;
    END IF;
END;
//

DELIMITER ;


-- PRIVILEGES

GRANT ALL PRIVILEGES ON lanchonete.* TO 'user_fiap'@'%';
FLUSH PRIVILEGES;


-- INSERTS

INSERT INTO estado (nome, sigla) VALUES
('Acre', 'AC'), 
('Alagoas', 'AL'), 
('Amapá', 'AP'), 
('Amazonas', 'AM'), 
('Bahia', 'BA'),
('Ceará', 'CE'), 
('Distrito Federal', 'DF'), 
('Espírito Santo', 'ES'), 
('Goiás', 'GO'),
('Maranhão', 'MA'), 
('Mato Grosso', 'MT'), 
('Mato Grosso do Sul', 'MS'), 
('Minas Gerais', 'MG'),
('Pará', 'PA'), 
('Paraíba', 'PB'), 
('Paraná', 'PR'), 
('Pernambuco', 'PE'), 
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'), 
('Rio Grande do Norte', 'RN'), 
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'), 
('Roraima', 'RR'), 
('Santa Catarina', 'SC'), 
('São Paulo', 'SP'),
('Sergipe', 'SE'), 
('Tocantins', 'TO');


INSERT INTO municipio (nome, estado_id) VALUES
('São Paulo', 25), 
('Campinas', 25), 
('Santos', 25), 
('São José dos Campos', 25), 
('Ribeirão Preto', 25),
('Sorocaba', 25), 
('Bauru', 25), 
('São Bernardo do Campo', 25), 
('Santo André', 25), 
('Osasco', 25),
('Mogi das Cruzes', 25), 
('Piracicaba', 25), 
('Jundiaí', 25), 
('Franca', 25), 
('Guarulhos', 25);


INSERT INTO cliente (nome_completo, cpf, data_nascimento, genero, email) VALUES
('Ana Silva', 12345678901, '1985-05-15', 'Feminino', 'ana.silva@example.com'),
('Bruno Souza', 23456789012, '1990-07-20', 'Masculino', 'bruno.souza@example.com'),
('Carla Pereira', 34567890123, '1978-03-10', 'Feminino', 'carla.pereira@example.com'),
('Daniel Oliveira', 45678901234, '1982-11-25', 'Masculino', 'daniel.oliveira@example.com'),
('Eduarda Lima', 56789012345, '1995-01-30', 'Feminino', 'eduarda.lima@example.com'),
('Felipe Costa', 67890123456, '1988-09-05', 'Masculino', 'felipe.costa@example.com'),
('Gabriela Santos', 78901234567, '1992-06-18', 'Não binário', 'gabriela.santos@example.com'),
('Henrique Almeida', 89012345678, '1980-12-12', 'Masculino', 'henrique.almeida@example.com'),
('Isabela Rocha', 90123456789, '1987-04-22', 'Feminino', 'isabela.rocha@example.com'),
('João Mendes', 12345678902, '1993-08-14', 'Masculino', 'joao.mendes@example.com'),
('Karina Martins', 23456789023, '1984-02-28', 'Feminino', 'karina.martins@example.com'),
('Lucas Fernandes', 34567890134, '1991-10-07', 'Masculino', 'lucas.fernandes@example.com'),
('Mariana Ribeiro', 45678901245, '1986-12-19', 'Feminino', 'mariana.ribeiro@example.com'),
('Nicolas Cardoso', 56789012356, '1994-05-03', 'Não binário', 'nicolas.cardoso@example.com'),
('Olivia Azevedo', 67890123467, '1989-07-29', 'Não informado', 'olivia.azevedo@example.com');


INSERT INTO endereco (cliente_id, nome, principal, cep, logradouro, complemento, bairro, municipio_id) VALUES
(1, 'Casa', TRUE, '01001000', 'Praça da Sé', 'Apto 101', 'Sé', 1),
(1, 'Casa na praia', FALSE, '13010000', 'Av. Francisco Glicério', 'Sala 202', 'Centro', 2),
(2, 'Casa', TRUE, '11013001', 'Av. Ana Costa', 'Apto 303', 'Gonzaga', 3),
(3, 'Casa', TRUE, '12245000', 'Av. São João', 'Casa 4', 'Jardim Satélite', 4),
(4, 'Casa', TRUE, '14020000', 'Rua Floriano Peixoto', 'Casa 5', 'Centro', 5),
(5, 'Casa da sogra', TRUE, '18035000', 'Av. Dom Aguirre', 'Apto 606', 'Centro', 6),
(6, 'Casa', TRUE, '17012000', 'Rua Araújo Leite', 'Casa 7', 'Centro', 7),
(7, 'Casa', TRUE, '09750000', 'Av. Lucas Nogueira Garcez', 'Apto 808', 'Centro', 8),
(8, 'Casa da mãe', TRUE, '09010000', 'Rua Senador Fláquer', 'Casa 9', 'Centro', 9),
(9, 'Casa', TRUE, '06010000', 'Av. dos Autonomistas', 'Apto 1010', 'Centro', 10),
(10, 'Casa', TRUE, '08710000', 'Rua Dr. Deodato Wertheimer', 'Casa 11', 'Centro', 11),
(11, 'Casa', TRUE, '13400000', 'Rua do Porto', 'Casa 12', 'Centro', 12),
(12, 'Casa', TRUE, '13201000', 'Av. Nove de Julho', 'Apto 1314', 'Centro', 13),
(13, 'Casa', TRUE, '14400000', 'Av. Presidente Vargas', 'Casa 15', 'Centro', 14),
(14, 'Casa', TRUE, '07110000', 'Av. Paulo Faccini', 'Apto 1617', 'Centro', 15),
(15, 'Casa', TRUE, '01001000', 'Praça da Sé', 'Apto 1819', 'Sé', 1);


INSERT INTO telefone (cliente_id, tipo_telefone, principal, ddd, numero) VALUES
(1, 'Celular', TRUE, '11', '997123456'),
(1, 'Residencial', FALSE, '11', '31234567'),
(2, 'Celular', TRUE, '13', '997234567'),
(2, 'Trabalho', FALSE, '13', '32345678'),
(3, 'Celular', TRUE, '12', '997345678'),
(3, 'Recado', FALSE, '12', '997456789'),
(4, 'Celular', TRUE, '16', '997456789'),
(5, 'Celular', TRUE, '15', '997567890'),
(6, 'Celular', TRUE, '14', '997678901'),
(7, 'Celular', TRUE, '11', '997789012'),
(8, 'Celular', TRUE, '11', '997890123'),
(9, 'Celular', TRUE, '11', '997901234'),
(10, 'Celular', TRUE, '11', '998012345'),
(11, 'Celular', TRUE, '19', '998123456'),
(12, 'Celular', TRUE, '11', '998234567'),
(13, 'Celular', TRUE, '16', '998345678'),
(14, 'Celular', TRUE, '11', '998456789'),
(15, 'Celular', TRUE, '11', '998567890');


INSERT INTO produto (nome, descricao, preco, quantidade, categoria) VALUES
('Hambúrguer Clássico', 'Hambúrguer com carne bovina, queijo, alface, tomate e molho especial.', 15.90, 50, 'Lanche'),
('Cheeseburger', 'Hambúrguer com carne bovina, queijo cheddar, alface, tomate e picles.', 17.50, 40, 'Lanche'),
('Sanduíche Natural', 'Sanduíche com pão integral, peito de peru, alface e tomate.', 12.00, 50, 'Lanche'),
('Wrap de Frango', 'Wrap com frango grelhado, alface, tomate e molho.', 13.00, 50, 'Lanche'),
('Batata Frita', 'Porção de batata frita crocante.', 8.00, 100, 'Acompanhamento'),
('Onion Rings', 'Anéis de cebola empanados e fritos.', 10.00, 80, 'Acompanhamento'),
('Salada Caesar', 'Salada com alface, frango grelhado, croutons e molho Caesar.', 14.00, 30, 'Acompanhamento'),
('Nuggets de Frango', 'Porção de nuggets de frango.', 9.00, 90, 'Acompanhamento'),
('Batata Rústica', 'Porção de batata rústica com ervas.', 9.50, 70, 'Acompanhamento'),
('Refrigerante', 'Lata de refrigerante de 350ml.', 5.00, 200, 'Bebida'),
('Suco Natural', 'Copo de suco natural de laranja.', 7.00, 150, 'Bebida'),
('Água Mineral', 'Garrafa de água mineral de 500ml.', 3.00, 300, 'Bebida'),
('Café Expresso', 'Café expresso quente.', 4.50, 100, 'Bebida'),
('Chá Gelado', 'Copo de chá gelado com limão.', 6.00, 120, 'Bebida'),
('Milkshake de Chocolate', 'Milkshake cremoso de chocolate.', 12.00, 60, 'Sobremesa'),
('Milkshake de Morango', 'Milkshake cremoso de morango.', 12.00, 60, 'Sobremesa'),
('Torta de Maçã', 'Torta de maçã com massa folhada.', 6.00, 50, 'Sobremesa'),
('Brownie de Chocolate', 'Brownie de chocolate com nozes.', 7.50, 40, 'Sobremesa'),
('Salada de Frutas', 'Salada de frutas frescas.', 8.50, 70, 'Sobremesa'),
('Sorvete de Baunilha', 'Bola de sorvete de baunilha.', 5.00, 80, 'Sobremesa');


INSERT INTO pedido (cliente_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6);


INSERT INTO item_pedido (pedido_id, produto_id, quantidade) VALUES
(1, 1, 2),
(1, 5, 2),
(2, 2, 1),
(2, 3, 1),
(3, 4, 1),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(5, 9, 1),
(5, 10, 1),
(6, 11, 1),
(6, 12, 1);


INSERT INTO fila_pedido (pedido_id, situacao) VALUES
(1, 'Finalizado'),
(2, 'Pronto'),
(3, 'Em preparação'),
(4, 'Em preparação'),
(5, 'Recebido'),
(6, 'Recebido');
