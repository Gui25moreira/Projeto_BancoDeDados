-- 5 clientes
insert into endereco (cep,uf,cidade,logradouro,numero)
values ('75708290','GO','Catalão','Rua Ministro Almeron Caminha','561'),
('40015001','BA','Salvador','Rua Portugal','840'),
('96413160','RS','Bagé','Travessa Professor Túlio Pinaud Madruga','160'),
('49052110','SE','Aracaju','Rua Eládio Modesto','632'),
('59115044','RN','Natal','Rua Osvaldo Cruz','46');

insert into cliente (nome,cpf,id_endereco)
values ('Antonio Kevin Bryan Aparício','83893664602',1),
('Heloisa Luzia Carolina Martins','98294721328',2),
('Yago Anderson Nascimento','58889358165',3),
('Flávia Sandra Marina Moreira','81795422890',4),
('Guilherme Benjamin Erick Jesus','78362065729',5);

--5 produtos
insert into produto (descricao,codigo_barra,valor)
values ('Harry Potter e a Pedra Filosofal: 1 Capa dura','9516516203265',42.5),
('Fritadeira sem Óleo Cadence Pratic Fryer, 3L, Preta, 110V, FRT515','498159400894080495',307.07),
('JBL, Headset Gamer, Quantum 100 - Branco','054195409095186',152.82),
('Óleo Extraordinário LOréal Paris Elseve, 100ml','9804945129510549',32.30),
('Tênis Softride Rift Slip-on Bold, Puma, Masculino','54961320654512216',239.99);

--2 clientes devem ter pelo menos 3 produtos no carrinho
-- criando carrinhos para 2 clientes
insert into carrinho (id_cliente)
values (1),
(2);

insert into carrinho_produto (id_carrinho,id_produto,quantidade)
values (1,1,1),
(1,2,1),
(1,3,1),
(2,4,3),
(2,5,1),
(2,1,1);

--3 campanhas de cupons
insert into cupom (codigo_cupom,data_inicio,data_expiracao,valor,descricao)
values ('MAR10',to_date('01-03-2023','DD-MM-YYYY'),to_date('31-03-2023','DD-MM-YYYY'),10,'Desconto de 10 reais no mês de março'),
('PRIMEIRA15',to_date('01-01-2023','DD-MM-YYYY'),to_date('31-12-2023','DD-MM-YYYY'),15,'Desconto de 15 na primeira compra'),
('INDQ10',to_date('01-03-2023','DD-MM-YYYY'),to_date('30-04-2023','DD-MM-YYYY'),10,'Indique um amigo e ganhe 10 reais em compras');

-- 6 pedidos com pelo menos 2 produtos cada um
-- 2 pedidos que utilizaram cupons
insert into pedido  (data_pedido,previsao_entrega,meio_pagamento,status,id_cliente,id_cupom)
values (default, to_date('01-04-2023','DD-MM-YYYY'),'crédito','enviado',1,1),
(to_date('25-03-2023','DD-MM-YYYY'), to_date('05-04-2023','DD-MM-YYYY'),'crédito','enviado',2,1);

--4 pedidos sem cupons
insert into pedido  (data_pedido,previsao_entrega,meio_pagamento,status,id_cliente,data_entrega)
values (to_date('05-03-2023','DD-MM-YYYY'), to_date('22-03-2023','DD-MM-YYYY'),'crédito','entregue',3,to_date('20-03-2023','DD-MM-YYYY')),
(to_date('05-03-2023','DD-MM-YYYY'), to_date('22-03-2023','DD-MM-YYYY'),'crédito','entregue',4,to_date('20-03-2023','DD-MM-YYYY'));

insert into pedido  (data_pedido,previsao_entrega,meio_pagamento,status,id_cliente)
values (default, to_date('01-04-2023','DD-MM-YYYY'),'boleto','processando',3),
(default, to_date('10-04-2023','DD-MM-YYYY'),'débito','processando',4),
(to_date('15-03-2023','DD-MM-YYYY'), to_date('05-04-2023','DD-MM-YYYY'),'débito','enviado',5);

insert into item_pedido (id_pedido,id_produto,quantidade,valor)
values (1,1,5,35.00),
(1,2,1,300),
(2,2,1,280.67),
(2,5,1,200.50),
(3,1,2,40),
(3,3,1,160),
(4,2,1,280),
(4,4,5,25),
(5,3,2,150),
(5,5,2,230),
(6,4,4,32),
(6,5,1,250);


--2 fornecedores associe os produtos com esses dois fornecedores
insert into endereco (cep,uf,cidade,logradouro,numero)
values ('68927230','AP','Santana','Travessa Pedro Salvador Diniz','123'),
('52090410','PE','Recife','Rua Almir Custônio de Lima','612');

insert into fornecedor (nome,cnpj,id_endereco)
values ('Camilo Eletro Eletronicos LTDA','83764526000175',6),
('Varejo Variedades LTDA','64323824000185',7);
--associe os produtos com esses dois fornecedores
insert  into fornecedor_produto (id_fornecedor,id_produto)
values (1,2),
(1,3),
(2,1),
(2,3),
(2,4),
(2,5);

--2 estoques adicione os produtos cadastrados nos estoque
insert into endereco (cep,uf,cidade,logradouro,numero)
values ('83327069','PR','Pinhais','Estrada Ecológica de Pinhais','406'),
('06857740','SP','Itapecerica da Serra','Rua Macedônia','72');

insert into estoque (id_endereco,id_produto,quantidade)
values (2,1,1267),
(2,2,132),
(2,3,369),
(2,5,230),
(1,4,836),
(1,3,153),
(1,5,132);