--criando schema
create schema ecommerce926_gp5;

--criando tabela endereco
create table endereco (
    id serial primary key,
    cep char(8) not null,
    uf char(2) not null,
    cidade varchar(200) not null,
    logradouro varchar(1000) not null,
    numero varchar(30) DEFAULT 'S/N' not null
);

--criando tabela cliente
CREATE TABLE cliente (
    id serial primary key,
    nome varchar(930) not null,
    cpf char(11) unique not null,
    id_endereco integer unique not null,
    foreign key (id_endereco) references endereco(id)
);

--criando tabela fornecedor
CREATE TABLE fornecedor (
    id serial primary key,
    nome varchar(1000) not null,
    cnpj char(14) unique not null,
    id_endereco integer unique not null,
    foreign key (id_endereco) references endereco(id)
);

--criando tabela produto
CREATE TABLE produto (
    id serial primary key,
    descricao varchar(1000) not null,
    codigo_barra varchar(44) unique not null,
    valor numeric not null
);

--criando tabela relacao fornecedor produto
CREATE TABLE fornecedor_produto (
	id_fornecedor integer not null,
	id_produto integer not null,
    primary key (id_fornecedor,id_produto),
    foreign key (id_fornecedor) references fornecedor(id),
    foreign key (id_produto) references produto(id)
);

--criando tabela cupom
create table cupom(
	id serial primary key,
	codigo_cupom varchar(10) not null unique,
	data_inicio date default current_date,
	data_expiracao date not null,
	valor numeric not null,
	descricao varchar(1000) not null
);

--criando tabela pedido
CREATE TABLE pedido (
    id serial primary key,
    data_pedido date default current_date,
    previsao_entrega date,
    data_entrega date,
    meio_pagamento varchar(200) not null,
    status varchar(200) not null,
    id_cliente integer not null,
    id_cupom integer,
    unique (id_cliente,id_cupom),
    foreign key (id_cliente) references cliente(id),
    foreign key (id_cupom) references cupom(id)
);


--criando tabela que relaciona a tabela produtos com a tabela pedidos
CREATE TABLE item_pedido (
    id_pedido integer not null,
    id_produto integer not null,
    quantidade integer not null,
    valor numeric,
    primary key (id_pedido,id_produto),
    foreign key (id_produto) references produto(id) ON DELETE cascade,
    foreign key (id_pedido) references pedido(id)
);

create table estoque(
	id_endereco integer not null,
	id_produto integer not null,
	quantidade integer not null,
	primary key (id_endereco, id_produto),
	foreign key (id_endereco) references endereco(id),
	foreign key (id_produto) references produto(id)
);

create table carrinho(
	id serial primary key,
	id_cliente integer unique not null,
	foreign key (id_cliente) references cliente(id)
);

create table carrinho_produto(
	id serial primary key,
	id_carrinho integer not null,
	id_produto integer not null,
	quantidade integer default 1,
	data_insercao timestamp default now(),
	unique (id_carrinho, id_produto),
	foreign key (id_carrinho) references carrinho(id),
	foreign key (id_produto) references produto(id)
);