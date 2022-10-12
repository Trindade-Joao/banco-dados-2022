CREATE DATABASE `financas_codar` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; 

USE `financas_codar`;

CREATE TABLE `clientes` 
(
	id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    data_nascimento DATE,
    profissao VARCHAR(50),
    genero VARCHAR(20),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE `endereco_cliente`
(
	id_cliente INT NOT NULL,
    CEP VARCHAR(8),
    rua VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(20) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_cliente),
    CONSTRAINT fk_endereco_id_cliente 
		FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) ON DELETE CASCADE
);

CREATE TABLE `conta_corrente`
(
	id_cliente INT NOT NULL,
    codigo_banco INT(3) UNSIGNED ZEROFILL NOT NULL,
    numero_conta INT UNSIGNED NOT NULL ,
    agencia SMALLINT UNSIGNED NOT NULL,
    apelido VARCHAR(20) NOT NULL,
    saldo DECIMAL(10,2),
    PRIMARY KEY (codigo_banco, numero_conta),
    CONSTRAINT fk_conta_corrente_id_cliente 
		FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) ON DELETE CASCADE
);

CREATE TABLE `categorias`
(	
    id_cliente INT NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_cliente, descricao),
    CONSTRAINT fk_categoria_id_cliente 
		FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) ON DELETE CASCADE
);

CREATE TABLE `movimentacao_financeira`
(
	id_movimentacao INT NOT NULL AUTO_INCREMENT,
	id_cliente INT NOT NULL,
    codigo_banco INT(3) UNSIGNED NOT NULL,
    numero_conta INT UNSIGNED NOT NULL ,
    valor DECIMAL(10,2) NOT NULL,
    data_movimentacao DATE NOT NULL,   
    descricao_categoria VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_movimentacao),
    CONSTRAINT fk_movimentacao_financeira_conta_corrente 
		FOREIGN KEY (codigo_banco, numero_conta) REFERENCES conta_corrente (codigo_banco, numero_conta) ON DELETE CASCADE,
	CONSTRAINT fk_movimentacao_financeira_id_categoria
		FOREIGN KEY (id_cliente, descricao_categoria) REFERENCES categorias(id_cliente, descricao) ON DELETE CASCADE
);


/*---------------- TRIGGER QUE CALCULA SALDO APÓS INSERT NA TABELA MOVIMENTACAO_FINANCEIRA ----------------*/
DELIMITER //
CREATE TRIGGER tg_calcula_saldo_insert AFTER INSERT ON movimentacao_financeira
	FOR EACH ROW BEGIN
	UPDATE conta_corrente
		SET saldo = saldo - new.valor
		WHERE codigo_banco = new.codigo_banco AND
			numero_conta = new.numero_conta;
END //

