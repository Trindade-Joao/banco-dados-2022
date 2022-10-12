/*------ CONSULTAS-------------*/
SELECT * FROM conta_corrente WHERE id_cliente = 1;

/*----- 1 - BUSCA OS GASTOS DO MÊS DE AGOSTO DE 2022 -----*/
SELECT codigo_banco, numero_conta, data_movimentacao, descricao, descricao_movimentacao 
	FROM movimentacao_financeira MF inner join categorias C
	ON MF.descricao_categoria = C.descricao
		where tipo = 'Despesa' AND MONTH(data_movimentacao) = 8 AND YEAR(data_movimentacao) = 2022 AND
		MF.id_cliente = 1;
        
 /*----- 2 - BUSCA AS MOVIMENTAÇÕES POR CODIGO_BANCO E CLIENTE -----*/       
SELECT * FROM movimentacao_financeira WHERE codigo_banco = 237 AND id_cliente = 1;

/*------ 3- BUSCA AS CATEGORIAS QUE TENHAM TRABALHO NA DESCRIÇÃO -------*/
SELECT descricao FROM categorias WHERE id_cliente = 1 AND descricao LIKE '%trabalho%';

/*------ 4- BUSCA TODAS AS MOVIMENTAÇÕES DO PRIMEIRO SEMESTRE -------*/
SELECT * FROM movimentacao_financeira WHERE id_cliente = 1 AND 
	(MONTH(data_movimentacao) BETWEEN 1 AND 6 ) 
		AND YEAR(data_movimentacao) = 2022;
        
/*------ 5- BUSCA AS CATEGORIAS QUE TIVERAM MOVIMENTACAO NA PRIMEIRA SEMANA DE SETEMBRO -------*/
SELECT DISTINCT descricao_categoria FROM movimentacao_financeira 
	WHERE id_cliente = 1 AND 
    (WEEK(data_movimentacao) + 1 ) - WEEK(DATE_ADD(data_movimentacao, INTERVAL - DAY(data_movimentacao) + 1 DAY)) = 1 AND
    DATE_FORMAT(data_movimentacao, "%m-%Y") = '09-2022'
    order by descricao_categoria;
    
/*------- 6- BUSCA A SOMA DE TODAS AS DESPESAS AGRUPADAS POR CATEGORIA, MENOR QUE 1000 REAIS -----------*/
SELECT descricao_categoria, TRUNCATE(SUM(valor), 2) AS despesas FROM movimentacao_financeira MF
	INNER JOIN categorias C ON MF.descricao_categoria = C.descricao
    WHERE MF.id_cliente = 1 AND tipo = 'Despesa'
    GROUP BY descricao_categoria
    HAVING despesas < 1000;

/*----------- 7- BUSCA AS 5 ULTIMAS RECEITAS ---------------*/
SELECT codigo_banco, numero_conta, valor, data_movimentacao, descricao_movimentacao 
	FROM movimentacao_financeira MF 
    INNER JOIN categorias C ON MF.descricao_categoria = C.descricao
    WHERE MF.id_cliente = 1 AND C.tipo = 'Receita'
    ORDER BY data_movimentacao DESC
    LIMIT 5;
    
/*---------- 8- BUSCA A MAIOR MOVIMENTACAO DENTRO DO MÊS ATUAL V2------------*/
SELECT  MAX(valor) maior_movimentacao FROM movimentacao_financeira WHERE id_cliente = 1 
AND MONTH(current_date()) = MONTH(data_movimentacao);


 /*---------- 8- BUSCA A MAIOR MOVIMENTACAO DENTRO DO MÊS ATUAL V2------------*/
SELECT * FROM movimentacao_financeira WHERE id_cliente = 1 
	AND MONTH(current_date()) = MONTH(data_movimentacao)
    ORDER BY valor DESC
    LIMIT 1;       
    
/*--------- 9- BUSCA CATEGORIA MAIS MOVIMENTADA POR MÊS EM 2020 V1(mês escrito por extenso)---------------*/
select A.mes, A.categoria, A.valor_total As valor_movimentado from (SELECT DATE_FORMAT(data_movimentacao, "%M") AS mes, descricao_categoria AS categoria, SUM(valor) AS valor_total
		FROM movimentacao_financeira 
		WHERE id_cliente = 1 AND YEAR(data_movimentacao) = 2020
		GROUP BY mes, categoria) A 
    inner join(select B.mes, max(B.valor_total) As valor_total from (SELECT DATE_FORMAT(data_movimentacao, "%M") AS mes, descricao_categoria AS categoria, SUM(valor) AS valor_total
		FROM movimentacao_financeira 
		WHERE id_cliente = 1 AND YEAR(data_movimentacao) = 2020
		GROUP BY mes, categoria) B
		GROUP BY B.mes) MV
    On A.mes = MV.mes AND A.valor_total = MV.valor_total
    ORDER BY A.mes;  
    
    /* A ordenaçao ficou por ordem alfabetica, 
    preciso pesquisar se há alguma forma de mudar isso*/
    
    
    /*--------- 9- BUSCA CATEGORIA MAIS MOVIMENTADA POR MÊS EM 2020 V2 (mês de forma numérica)---------------*/
select A.mes, A.categoria, A.valor_total As valor_movimentado from (SELECT MONTH(data_movimentacao) AS mes, descricao_categoria AS categoria, SUM(valor) AS valor_total
		FROM movimentacao_financeira 
		WHERE id_cliente = 1 AND YEAR(data_movimentacao) = 2020
		GROUP BY mes, categoria) A 
    inner join(select B.mes, max(B.valor_total) As valor_total from (SELECT MONTH(data_movimentacao) AS mes, descricao_categoria AS categoria, SUM(valor) AS valor_total
		FROM movimentacao_financeira 
		WHERE id_cliente = 1 AND YEAR(data_movimentacao) = 2020
		GROUP BY mes, categoria) B
		GROUP BY B.mes) MV
    On A.mes = MV.mes AND A.valor_total = MV.valor_total
    ORDER BY A.mes;  
    
/*---------- 10- BUSCA O SALDO DAS CONTAS ----------------------*/
SELECT apelido, saldo FROM conta_corrente WHERE id_cliente = 1    
