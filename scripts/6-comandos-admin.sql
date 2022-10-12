/*------------ 1- BUSCA DADOS DO CLIENTE CASO NÃO TENHA MOVIMENTAÇÃO DURANTE O MÊS ATUAL -------------*/
SELECT CLI.nome, CLI.email, EC.cidade FROM clientes CLI
	INNER JOIN endereco_cliente EC ON CLI.id_cliente = EC.id_cliente
    LEFT JOIN (SELECT DISTINCT id_cliente FROM movimentacao_financeira 
		WHERE MONTH(CURRENT_DATE) = MONTH(data_movimentacao)) CM
	ON EC.id_cliente = CM.id_cliente
    WHERE CM.id_cliente is null;

 
 /*----------- 2- BUSCA O NOME E O EMAIL DO CLIENTE COM A MAIOR MOVIMENTACAO DE RECEITA -------------*/  
    SELECT nome, email, VT.valor_total AS valor_movimentado, MR.valor_maximo AS maior_movimentacao FROM clientes CLI
		RIGHT JOIN  (SELECT MF.id_cliente, SUM(valor) AS valor_total FROM movimentacao_financeira MF
			INNER JOIN categorias CAT 
			ON MF.id_cliente = CAT.id_cliente AND MF.descricao_categoria = CAT.descricao
			WHERE CAT.tipo = 'Receita'
			GROUP BY MF.id_cliente) VT
		ON CLI.id_cliente = VT.id_cliente
        INNER JOIN (SELECT MF.id_cliente, MAX(valor) AS valor_maximo FROM movimentacao_financeira MF
			INNER JOIN categorias CAT 
			ON MF.id_cliente = CAT.id_cliente AND MF.descricao_categoria = CAT.descricao
			WHERE CAT.tipo = 'Receita'
			GROUP BY MF.id_cliente) MR
		ON VT.id_cliente = MR.id_cliente
        ORDER BY valor_movimentado DESC
        LIMIT 5;
        
/*----------- 3- BUSCA QUE MOSTRA O DIA COM QUE OCORREM MAIS MOVIMENTAÇÕES --------------*/
SELECT day(data_movimentacao) As dia, count(day(data_movimentacao)) numero_movimentacoes FROM movimentacao_financeira
GROUP BY dia
ORDER BY numero_movimentacoes DESC
LIMIT 1;

/*----------- 4- SCRIPT PARA EXCLUSÃO DO CLIENTE DO BANCO DE DADOS ------------------------*/
DELETE FROM clientes WHERE CPF = '97864532112';



/*---------- 5- CRIAR UM BLOQUEIO PARA O CASO DE FRAUDE ------------------------------*/
DELIMITER //
CREATE TRIGGER tg_bloqueio_seguranca BEFORE INSERT ON movimentacao_financeira FOR EACH ROW BEGIN
   
    IF (SELECT COUNT(valor) FROM movimentacao_financeira WHERE id_cliente = NEW.id_cliente) > 10 AND
		(SELECT MAX(valor) FROM movimentacao_financeira WHERE id_cliente = NEW.id_cliente) < (NEW.valor * 3) THEN			
			signal sqlstate '45000' set message_text = 'OPERAÇAO EXCEDE O LIMITE PERMITIDO';         
                
	END IF;
END//


		
    
    
    





    


    
    