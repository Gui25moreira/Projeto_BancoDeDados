-- 1 Listar todos os cliente que tem o nome 'ANA'.> Dica: Buscar sobre função Like
select * from cliente c where c.nome ilike 'ana%';

-- 2 Pedidos feitos em 2023
select * from pedido p where p.data_criacao between '01-01-2023' and '12-31-2023';

-- 3 Pedidos feitos em Janeiro de qualquer ano
select * from pedido p where to_char(p.data_criacao,'MM')='01'; 

-- 4 Itens de pedido com valor entre R$2 e R$5
select * from item_pedido ip where ip.valor between 2 and 5;

-- 5 Trazer o Item mais caro comprado em um pedido
select max(valor) from item_pedido ip;

-- 6 Listar todos os status diferentes de pedidos;
select distinct status from pedido p;

-- 7 Listar o maior, menor e valor médio dos produtos disponíveis.
select avg(valor) from produto;
select max(valor) from produto;
select min(valor) from produto;

-- 8 Listar fornecedores com os dados: nome, cnpj, logradouro, numero, cidade e uf de todos os fornecedores;
select nome,cnpj,e.cidade,e.uf,e.cep,e.logradouro,e.numero from fornecedor f 
join endereco e 
on e.id =f.id_endereco; 

-- 9 Informações de produtos em estoque com os dados: id do estoque, descrição do produto, quantidade do produto no estoque, logradouro, numero, cidade e uf do estoque;
select 	e.id,
		p.descricao,
		ie.quantidade,
		e2.logradouro,
		e2.numero,
		e2.cidade,
		e2.uf
from estoque e 
join item_estoque ie 
	on e.id =ie.id_estoque
join produto p 
	on  p.id  = ie.id_produto
join endereco e2 
	on e.id_endereco =e2.id ; 

-- 10 Informações sumarizadas de estoque de produtos com os dados: descrição do produto, código de barras, quantidade total do produto em todos os estoques;
select p.id,p.descricao,p.codigo_barras, sum(ie.quantidade)
from produto p 
join item_estoque ie on ie.id_produto = p.id
group by p.id;

-- 11 Informações do carrinho de um cliente específico (cliente com cpf '26382080861') com os dados: descrição do produto, quantidade no carrinho, valor do produto.
select p.descricao,ic.quantidade,p.valor  from item_carrinho ic 
join cliente c on ic.id_cliente = c.id 
join produto p on ic.id_produto = p.id 
where c.cpf = '26382080861';

-- 12 Relatório de quantos produtos diferentes cada cliente tem no carrinho ordenado pelo cliente que tem mais produtos no carrinho para o que tem menos, com os dados: id do cliente, nome, cpf e quantidade de produtos diferentes no carrinho.
select 	c.id,
		c.nome,
		count(ic.id_produto) as produtos_diferentes,
		sum(ic.quantidade)  as produtos_totais
from cliente c 
join item_carrinho ic on ic.id_cliente = c.id
group by c.id
order by count(ic.id_produto) desc; 

-- 13 Relatório com os produtos que estão em um carrinho a mais de 10 meses, ordenados pelo inserido a mais tempo, com os dados: id do produto, descrição do produto, data de inserção no carrinho, id do cliente e nome do cliente;
select ic.id_produto, p.descricao, ic.data_insercao, id_cliente, c.nome  from item_carrinho ic 
join produto p on p.id =ic.id_produto
join cliente c on ic.id_cliente = c.id 
where ic.data_insercao < current_date - interval '10 month' 
order by data_insercao ; 

-- 14 Relatório de clientes por estado, com os dados: uf (unidade federativa) e quantidade de clientes no estado;
select e.uf,count(c.id) as numero_clientes from cliente c 
join endereco e on e.id =c.id_endereco 
group by e.uf; 

-- 15 Listar cidade com mais clientes e a quantidade de clientes na cidade;
select e.cidade ,count(c.id) as numero_clientes from cliente c 
join endereco e on e.id =c.id_endereco 
group by e.cidade 
order by numero_clientes desc; 

-- 16 Exibir informações de um pedido específico, pedido com id 952, com os dados (não tem problema repetir dados em mais de uma linha): nome do cliente, id do pedido, previsão de entrega, status do pedido, descrição dos produtos comprados, quantidade comprada produto, valor total pago no produto;
select c.nome, p.id, p.previsao_entrega ,p.status, p2.descricao ,ip.quantidade,ip.valor  from pedido p
join cliente c on p.id_cliente  =c.id
join item_pedido ip on ip.id_pedido  = p.id
join produto p2 on p2.id = ip.id_produto 
where p.id = 952;


-- 17 Relatório de clientes que realizaram algum pedido em 2022, com os dados: id_cliente, nome_cliente, data da última compra de 2022;
select c.id, c.nome, max(p.data_criacao)  from cliente c
join pedido p ON p.id_cliente = c.id
where p.data_criacao between  to_date('01-01-2022','DD-MM-YYYY') and to_date('31-12-2022','DD-MM-YYYY')
group by c.id;  

-- 18 Relatório com os TOP 10 clientes que mais gastaram esse ano, com os dados: nome do cliente, valor total gasto;
select c.id ,c.nome,sum(ip.valor)as total  from cliente c 
join pedido p on p.id_cliente  = c.id 
join item_pedido ip on p.id =ip.id_pedido
where p.data_criacao between '2022-01-01' and '2022-12-31' 
group by c.id,c.nome
order by total desc
limit 10;


-- 19 Relatório com os TOP 10 produtos vendidos esse ano, com os dados: descrição do produto, quantidade vendida, valor total das vendas desse produto;
-- mais vendido em dinheiro
select p.id,p.descricao, sum(ip.quantidade) quantidade , sum(ip.valor) valor_total ,count(ip.id_pedido) num_pedidos  from produto p
join item_pedido ip on ip.id_produto = p.id
group by p.id, p.descricao
order by valor_total desc
limit 10;
-- mais vendido em quantidade
select p.id,p.descricao, sum(ip.quantidade) quantidade , sum(ip.valor) valor_total ,count(ip.id_pedido) num_pedidos  from produto p
join item_pedido ip on ip.id_produto = p.id
group by p.id, p.descricao
order by quantidade desc
limit 10;

-- 20 Exibir o ticket médio do nosso e-commerce, ou seja, a média dos valores totais gasto em pedidos com sucesso;
select  avg(ip.valor*ip.quantidade)  from pedido p 
join item_pedido ip ON p.id = ip.id_pedido 
where status = 'SUCESSO';

-- 21 Relatório dos clientes gastaram acima de R$ 10000 em um pedido, com os dados: id_cliente, nome do cliente, valor máximo gasto em um pedido;
select distinct c.id,c.nome nome, p.id, sum(ip.valor*ip.quantidade) as total  from cliente c 
join pedido p on p.id_cliente = c.id 
join item_pedido ip on ip.id_pedido = p.id
group by c.id ,c.nome, p.id
having  sum(ip.valor*ip.quantidade)  > 10000;

-- 22 Listar TOP 10 cupons mais utilizados e o total descontado por eles.
select p.id_cupom, c.descricao, count(p.id_cupom) qtd_vezes, (count(p.id_cupom) * c.valor) total_descontado
from pedido p join cupom c on p.id_cupom = c.id
group by p.id_cupom, c.descricao, c.valor 
order by qtd_vezes desc limit 10;

-- 23 Listar cupons que foram utilizados mais que seu limite;
select c.descricao,c.limite_maximo_usos , count(p.id_cupom)  from cupom c
join pedido p on p.id_cupom = c.id
group by c.id, c.limite_maximo_usos
having  count(p.id_cupom) > c.limite_maximo_usos;

-- 24 Listar todos os ids dos pedidos que foram feitos por pessoas que moram em São Paulo (unidade federativa, uf, SP) e compraram o produto com código de barras '97692630963921';
select ped.id  from ecommerce926.pedido ped 
inner join ecommerce926.cliente c on ped.id_cliente = c.id 
inner join ecommerce926.endereco e on c.id_endereco = e.id 
inner join ecommerce926.item_pedido ip on ped.id = ip.id_pedido  
inner join ecommerce926.produto prod on ip.id_produto = prod.id 
where e.uf = 'SP' and prod.codigo_barras='97692630963921';

-- 25 Faça um relatório de sua escolha, crie uma view para ele e faça uma consulta nessa view
create view ecommerce926.qtd_pedido_cliente as
SELECT c.nome , count(p.id) 
FROM ecommerce926.cliente c inner join ecommerce926.pedido p on c.id = p.id_cliente GROUP by c.nome ;

select * from ecommerce926.qtd_pedido_cliente;