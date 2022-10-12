USE `financas_codar`;

/*--------------------------------------- INSERÇÃO TABELA CLIENTES ----------------------------------------*/
INSERT INTO clientes 
	(nome, CPF, email, senha, data_nascimento, profissao, genero)
VALUES 
	('Felipe Monteiro Junior', '15498732167', 'felipe@gmail.com', 'felipe1234', '1990-05-12', 'vendedor', 'masculino'),
	('Maria Fernanda Silva', '98712335791', 'fernandinha@gmail.com', 'MFernandaS', '1995-09-28', 'dentista', 'feminino'),
    ('Paulo Henrique Souza', '45636489745', 'paulo.h@gmail.com', 'BatmaN', '1980-12-04', 'advogado', 'masculino'),
    ('Janaína Alves', '17895135719', 'janainaaaa@gmail.com', 'j220790', '1990-07-22', 'gerente', 'feminino'),
    ('Natalia Braga', '97864532112', 'natizinha@hotmail.com', 'N4t4l14', '1997-02-15', 'desenvolvedora', 'feminino'),
    ('Manoel Ferraz', '13246579887', 'manoel.ferraz@hotmail.com', 'Maria0107', '1956-11-04', 'aposentado', 'masculino');
    

/*--------------------------------------- INSERÇÃO TABELA CATEGORIAS ----------------------------------------*/
INSERT INTO categorias 
	(id_cliente, descricao)
VALUES
	(1,'Aluguel'), (1,'Combustível'), (1,'Alimentação Trabalho'), (1,'Futebol trabalho'),
	(2,'Transporte'), (2,'Moradia'), (2,'Alimentação'), 
    (3,'Faculdade'), (3,'Alimentação'), (3,'Aluguel'), (3,'Lazer'),
	(4,'Moradia'), (4,'Pet'), (4,'Saúde'), (4,'Transporte'),
	(5,'Alimentação'), (5,'Lazer'), (5,'Estudos'),
	(6,'Alimentação'), (6,'Moradia'), (6,'Saúde'), (6,'Lazer');

/*--------------------------------------- INSERÇÃO TABELA ENDERECO_CLIENTE ----------------------------------------*/
INSERT INTO endereco_cliente
	(id_cliente, CEP, rua, numero, complemento, bairro, cidade, estado, pais)
VALUES 
	(1,'91510720','R. da Tuca',120,'','Vila Joao Pessoa','Porto Alegre','RS','Brasil'),
    (2,'86020110','R. Pref. Hugo Cabral',750,'apt 351','Centro','Londrina','PR','Brasil'),
    (3,'74275050','R. C-136',795,'','Jardim América','Goiânia','GO','Brasil'),
    (4,'39402090','Alameda Santa Lúcia',280,'Em frente ao mercado','Santa Lucia','Montes Claros','MG','Brasil'),
    (5,'63034090','R. José Henrique',42,'','Limoeiro','Juazeiro do Norte','CE','Brasil'),
    (6,'13100017','R. Sinésio de Melo Oliveira',386,'apt 23','Jardim Paraíso','Campinas','SP','Brasil');
	

/*--------------------------------------- INSERÇÃO TABELA CONTA_CORRENTE ----------------------------------------*/
INSERT INTO conta_corrente 
	(id_cliente, codigo_banco, numero_conta, agencia, apelido, saldo)
VALUES 
	(1,735,1234565,7894,'conta principal',15652.36),
	(1,237,2451971,1452,'Bradesco conjunta',2598.42),
	(2,477,1264896,2359,'Citibank',1923.56),
	(2,341,12547,0568,'itau principal',487.92),
	(2,336,165421,3654,'C6',4892.98),
	(3,341,265391,6548,'Itau recebimentos',2564.65),
	(3,033,156781,3124,'Santander',1560.02),
	(4,077,123545,2564,'Inter recebimentos',856.84),
	(4,422,236654,2222,'Safra conjunta',2365.05),
	(5,229,456124,7896,'Cruzeiro do Sul',1235.32),
	(5,341,034565,0369,'principal',356.32),
	(5,336,1254698,6985,'C6 ',3956.88),
	(6,104,127845,0103,'caixa',4523.15),
	(6,341,13298,0259,'itau recebimentos',2312.13);
    
/*-------------------- INSERÇÃO TABELA MOVIMENTACAO_FINANCEIRA --------------------*/
INSERT INTO movimentacao_financeira
	(id_cliente, codigo_banco, numero_conta, valor, data_movimentacao, descricao_categoria)
VALUES
	(1,735,1234565,50.00,'2022-08-20','Alimentação Trabalho'),
	(1,735,1234565,145.23,'2022-09-30','Futebol trabalho'),
	(1,735,1234565,10.50,'2022-10-02','Alimentação Trabalho'),
	(1,237,2451971,210.50,'2020-10-01','Combustível'),
	(1,237,2451971,1500.00,'2022-09-05','Aluguel'),
	(1,237,2451971,149.80,'2020-08-12','Futebol trabalho'),
	(2,477,1264896,132.65,'2022-08-15','Alimentação'),
	(2,477,1264896,800.00,'2022-09-05','Moradia'),
	(2,341,12547,54.00,'2022-09-20','Transporte'),
	(2,341,12547,65.32,'2022-10-08','Alimentação'),
	(2,336,165421,80.56,'2022-08-15','Transporte'),
	(2,336,165421,145.65,'2022-09-12','Alimentação'),
	(3,341,265391,500.00,'2022-08-05','Faculdade'),
	(3,341,265391,956.00,'2022-08-20','Aluguel'),
	(3,341,265391,132.65,'2022-09-05','Alimentação'),
	(3,033,156781,256.45,'2022-09-16','Lazer'),
	(3,033,156781,956.00,'2022-09-20','Aluguel'),
	(4,077,123545,150.00,'2022-08-26','Pet'),
	(4,077,123545,765.20,'2022-09-05','Moradia'),
	(4,422,236654,52.65,'2022-09-07','Transporte'),
	(4,422,236654,450.00,'2022-09-25','Saúde'),
	(4,422,236654,156.78,'2022-10-06','Saúde'),
	(5,229,456124,125.36,'2022-08-09','Alimentação'),
	(5,229,456124,321.60,'2022-08-15','Lazer'),
	(5,341,034565,156.98,'2022-09-10','Alimentação'),
	(5,341,034565,150.00,'2022-09-18','Estudos'),
	(5,336,1254698,132.00,'2022-10-02','Estudos'),
	(6,104,127845,890.00,'2022-08-23','Moradia'),
	(6,104,127845,236.00,'2022-09-03','Saúde'),
	(6,104,127845,156.54,'2022-09-18','Lazer'),
	(6,341,13298,132.89,'2022-09-25','Alimentação'),
	(6,341,13298,456.65,'2022-10-01','Alimentação'),
	(6,341,13298,123.91,'2022-10-05','Saúde');

