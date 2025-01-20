-- criação de banco de dados para o cenário E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;
drop table ecommerce;
-- criar tabela cliente

CREATE TABLE clients(
	idclient int auto_increment primary key,
	Fname varchar(25),
    Lname varchar(20),
    CPF char(11) not null,
    adress varchar(50),
	constraint unique_cpf_client unique (CPF)
    );
alter table clients auto_increment=1;


-- tabela produto

CREATE TABLE produto(
	idProduto int auto_increment primary key,
    Pname VARCHAR(100),
    classification_kids bool,
    category enum('Eletronico','Vestimento','Brinquedo','Moveis'),
    valor VARCHAR(10),
    Avaliação FLOAT DEFAULT 0
    );


-- tabela pedido

CREATE TABLE pedido(
	idPedido int auto_increment PRIMARY KEY,
    idPedidoClient int,
    status_pedido ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em Processamento',
    pedidoDescrição VARCHAR(255),
    frete FLOAT DEFAULT 10,
    CONSTRAINT fk_pedido_client FOREIGN KEY (idPedidoClient) REFERENCES  clients(idClient)
    );
    


-- tabela estoque 

CREATE TABLE estoque(
	idEstoque int auto_increment PRIMARY KEY,
    localidade VARCHAR(255),
    quantidade INT DEFAULT 0
    );
    
    
    
-- tabela fornecedor

CREATE TABLE fornecedor(
	idfornecedor INT auto_increment PRIMARY KEY,
    NomeSocial VARCHAR(255),
    CNPJ CHAR(11),
    contato CHAR(11) NOT NULL,
    localidade VARCHAR (255),
    CONSTRAINT unique_fornecedor UNIQUE(CNPJ)
    );
alter table fornecedor
modify column CNPJ CHAR(14);


-- tabela vendedor

CREATE TABLE vendedor(
	idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    nomefantasia VARCHAR(200),
    CNPJ CHAR (15) NOT NULL,
    localidade VARCHAR(255),
    CONSTRAINT unique_cnpj_vendedor UNIQUE (CNPJ)
    );
    
    

CREATE TABLE ProdutoVendedor (
	idPvendedor INT,
    idPproduto INT,
    ProdQuantidade INT NOT NULL,
	PRIMARY KEY (idPvendedor, idPproduto),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (idPvendedor) REFERENCES vendedor(idVendedor),
    CONSTRAINT fk_produto_produto FOREIGN KEY (idPproduto) REFERENCES produto(idProduto)
    );
    

-- produto estoque e produto 
CREATE TABLE ProdutoEstoque(
	idLproduto INT,
    idLestoque INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduto, idLestoque),
    CONSTRAINT fk_storage_location_Lproduto FOREIGN KEY (idLproduto) REFERENCES produto(idproduto),
    CONSTRAINT fk_storage_location_Lestoque FOREIGN KEY (idLestoque) REFERENCES estoque(idEstoque)
    );


-- PRODUTOE PEDIDO
CREATE TABLE ProdutoPedido(
	idPOproduto INT,
	idPOpedido INT, 
    poQuantidade INT DEFAULT 1,
    poStatus ENUM ('Disponivel','Sem estoque') DEFAULT 'Disponivel',
    PRIMARY KEY (idPOproduto, idPOpedido),
    CONSTRAINT fk_produto_vendedor_terceiro FOREIGN KEY (idPOproduto) REFERENCES produto(idproduto),
    CONSTRAINT fk_produto_produto_terceiro FOREIGN KEY (idPOpedido) REFERENCES pedido(idPedido)
    );

CREATE TABLE produtoFornecedor(
	idPfornecedor INT,
    idPFproduto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idPfornecedor, idPFproduto),
    CONSTRAINT fk_produto_fornecedor_fornecedor FOREIGN KEY (idPfornecedor) REFERENCES fornecedor(idfornecedor),
    CONSTRAINT fk_produto_fornecedor_produto FOREIGN KEY (idPFproduto) REFERENCES produto(idProduto)
    );
desc REFERENTIAL_CONSTRAINTS;




-- tabela cliente PF
CREATE TABLE ClientePF(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Adress VARCHAR(30),
    CONSTRAINT unique_cpf_cliente UNIQUE(CPF)
    );


-- TABELA CLIENTE PJ
CREATE TABLE ClientePJ(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Fnome VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    address CHAR(30),
    contato CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_cliente UNIQUE(CNPJ)
    );


-- tabela pagamento
CREATE TABLE Pagamento(
	idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    typePagamento ENUM('Boleto','Cartão','Pix'),
    limitDisponivel FLOAT,
	CONSTRAINT fk_pagamento_cliente FOREIGN KEY (idCliente) REFERENCES clientePF(idCliente)
    );
    


-- inserção dos dados

SHOW TABLES;
-- tabela clientes
INSERT INTO Clients(Fname,Lname, CPF, Adress)
	values ('Maria','Silva',12346789,'rua silva de prata 29,Carangola-Cidade das Flores'),
		   ('Matheus','Pimentel',987654321,'avenida alameda vinho 29,Centro-Cidade das Flores'),
           ('Ricardo','França',45678913,'rua alameda 456, Centro-Cidade das Flores');
           
           
	


INSERT INTO Produto(Pname,classification_kids,category,Avaliação,valor) values
	('Smartphone XYZ', true, 'Eletronico', '1500.00', 4.5),
    ('Camisa Polo', false, 'Vestimento', '99.99', 4.2),
    ('Bicicleta Infantil', true, 'Brinquedo', '350.00', 4.8);
    
    
INSERT INTO Pedido(idPedidoClient,status_pedido,pedidoDescrição,frete) values
	(1,null,'compra via aplicativo',null),
    (1, 'Confirmado', 'Pedido de 2 smartphones', 10.0),
	(2, 'Em processamento', 'Compra de roupas', 15.0);
    
INSERT INTO Estoque(localidade, quantidade) values
	('Armazém A', 100),
    ('Armazém B', 50);
    

INSERT INTO fornecedor (NomeSocial, CNPJ, contato, localidade) 
VALUES 
('Fornecedor A Ltda', '12345678000123', '98765432100', 'Rua X, 789'),
('Fornecedor B Ltda', '23456789000145', '98765432101', 'Avenida Y, 234');


INSERT INTO vendedor (nomefantasia, CNPJ, localidade) VALUES 
	('Vendas A', '67016388294502', 'Rua Z, 123'),
	('Vendas B', '19257903658036', 'Avenida W, 456');
    


INSERT INTO ProdutoVendedor ( idPvendedor,idPproduto, ProdQuantidade) VALUES 
	(1, 2, 50),
	(2, 3, 30);
    

INSERT INTO ProdutoEstoque ( idLproduto,idLestoque, location) VALUES 
( 2,1, 'Armazém A - Prateleira 1'),
( 3,5, 'Armazém B - Prateleira 2');

INSERT INTO ProdutoPedido ( idPOproduto,idPOpedido, poQuantidade, poStatus) VALUES 
	( 1, 2, 'Disponivel'),
	( 2, 1, 'Sem estoque');
    
INSERT INTO produtoFornecedor (idPfornecedor, idPFproduto, quantidade) VALUES 
	(1, 1, 500),
	(2, 3, 200);
    
INSERT INTO ClientePF (Fname, Minit, Lname, CPF, Adress) VALUES 
	('Carlos', 'A', 'Santos', '98765432100', 'Rua L, 321'),
	('Fernanda', 'B', 'Costa', '87654321009', 'Avenida M, 654');


INSERT INTO ClientePJ (Fnome, CNPJ, address, contato) VALUES 
	('Empresa A', '12345678000123', 'Rua A, 123', '9988776655'),
	('Empresa B', '23456789000145', 'Avenida B, 456', '9988776644');
    

INSERT INTO Pagamento (idCliente, typePagamento, limitDisponivel) VALUES 
	(1, 'Cartão', 1500.00),
	(2, 'Pix', 1000.00);






    