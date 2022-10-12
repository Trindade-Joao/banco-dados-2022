USE `financas_codar`;

/*------ ADICIONA A COLUNA DESCRICAO_MOVIMENTACAO E CRIA UMA MENSAGEM DEFAULT NOS DADOS ANTIGOS ----*/
ALTER TABLE movimentacao_financeira ADD COLUMN descricao_movimentacao 
VARCHAR(100) default 'É necessário atualizar os dados' NOT NULL;

ALTER TABLE movimentacao_financeira alter COLUMN descricao_movimentacao 
drop default;

/*-------------------- ALTERA A PRECISÃO DO VALOR DA TABELA MOVIMENTACAO_FINANCEIRA --------------------*/
ALTER TABLE movimentacao_financeira MODIFY COLUMN valor DECIMAL(10, 4);
/* para reduzir o número de casas decimais se usa o mesmo comando que é utilizado para 
aumentar o número de casas decimais, o número é truncado para ocupar o novo tamanho */


/*-------------------- ADICIONA A COLUNA TIPO NA TABELA CATEFORIAS --------------------*/
ALTER TABLE categorias ADD COLUMN tipo ENUM('Receita', 'Despesa') DEFAULT 'Despesa';


/*------------------ MODIFICA A TRIGGER QUE ATUALIZA O SALDO--------------------------*/
DROP TRIGGER tg_calcula_saldo_insert;

DELIMITER //
CREATE TRIGGER tg_calcula_saldo_insert AFTER INSERT ON movimentacao_financeira FOR EACH ROW BEGIN

	IF (SELECT tipo FROM categorias WHERE new.id_cliente = id_cliente AND new.descricao_categoria = descricao) = 'Despesa' THEN
		UPDATE conta_corrente
		SET saldo = saldo - new.valor
		WHERE codigo_banco = new.codigo_banco AND
			numero_conta = new.numero_conta;
	ELSEIF (SELECT tipo FROM categorias A WHERE new.id_cliente = id_cliente AND new.descricao_categoria = descricao) = 'Receita' THEN
		UPDATE conta_corrente
		SET saldo = saldo + new.valor
		WHERE codigo_banco = new.codigo_banco AND
			numero_conta = new.numero_conta;
	END IF;
    
END//



