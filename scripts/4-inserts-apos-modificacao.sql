USE `financas_codar`;

/*-------------------------------- INSERTS APÓS AS MODIFICAÇÕES ---------------------------------*/
INSERT INTO categorias 
	(id_cliente, descricao, tipo)
VALUES 
	(1,'Salario','Receita'),
	(2,'Salario','Receita'),
	(2,'Rendimentos','Receita'),
	(3,'Salario','Receita'),
	(4,'Salario','Receita'),
	(4,'Recebimentos','Receita'),
	(5,'Salario','Receita'),
	(6,'Aposentadoria','Receita');
    
    
INSERT INTO movimentacao_financeira
	(id_cliente, codigo_banco, numero_conta, valor, data_movimentacao, descricao_categoria, descricao_movimentacao)
VALUES
	(1,237,2451971,4500.0000,'2022-10-05','Salario','Salario'),
	(1,735,1234565,138.9872,'2022-10-06','Alimentação Trabalho','Restaurante Pedra Azul'),
	(1,237,2451971,268.1856,'2022-10-09','Futebol trabalho','Futebol de Sábado'),
	(2,477,1264896,4678.2365,'2022-09-20','Rendimentos','Fundo Imobiliario'),
	(2,341,12547,1785.5000,'2022-09-20','Salario','Adiantamento Quinzenal'),
	(2,336,165421,1200.0000,'2022-10-05','Moradia','Aluguel'),
	(3,341,265391,1856.0500,'2022-09-30','Salario','Adiantamento'),
	(3,033,156781,856.3625,'2022-10-05','Faculdade','Mensalidade de Outubro'),
	(4,422,236654,3500.00,'2022-10-05','Recebimentos','Aluguel Ponto Comercial'),
	(5,336,1254698,3698.5694,'2022-09-20','Salario','Adiantamento'),
	(6,104,127845,8596.6532,'2022-10-05','Aposentadoria','Aposetadoria'),
	(6,341,13298,356.4567,'2022-10-07','Alimentação','Jantar com esposa');