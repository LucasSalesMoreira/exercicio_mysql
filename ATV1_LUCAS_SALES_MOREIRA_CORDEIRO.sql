create database atv;

use atv;

/*
1. Crie, no seu banco de dados, a tabela abaixo, insira os valores apresentados e em
seguida escreva as consultas solicitadas abaixo. OBS: Os valores em branco devem ser
nulos no banco de dados.
*/
create table produto (
	ID_NF int,
    ID_ITEM int,
    COD_PROD int,
    VALOR_UNIT float,
    QUANTIDADE int,
    DESCONTO float
);

alter table produto add constraint PK primary key(ID_NF, ID_ITEM, COD_PROD); 

insert into
produto (ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE, DESCONTO) 
values 
(1, 1, 1, 25, 10, 5),
(4, 1, 5, 30, 10, 15),
(4, 2, 4, 10, 12, 5),
(4, 3, 1, 25, 13, 5),
(4, 4, 2, 13.5, 15, 5),
(6, 1, 1, 25, 22, 15),
(6, 2, 3, 15, 25, 20),
(7, 1, 1, 25, 10, 3),
(7, 2, 2, 13.5, 10, 4),
(7, 3, 3, 15, 10, 4),
(7, 4, 5, 30, 10, 1);

insert into 
produto (ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE) 
values
(1, 2, 2, 13.5, 3),
(1, 3, 3, 15, 2),
(1, 4, 4, 10, 1),
(1, 5, 5, 30, 1),
(2, 1, 3, 15, 4),
(2, 2, 4, 10, 5),
(2, 3, 5, 30, 7),
(3, 1, 1, 25, 5),
(3, 2, 4, 10, 4),
(3, 3, 5, 30, 5),
(3, 4, 2, 13.5, 7),
(5, 1, 3, 15, 3),
(2, 2, 2, 30, 6);

/*
a) Pesquise os itens que foram vendidos sem desconto. As colunas presentes no
resultado da consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT.
*/
select ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT from produto where DESCONTO is null;

/*
b) Pesquise os itens que foram vendidos com desconto. As colunas presentes no
resultado da consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR
VENDIDO. OBS: O valor vendido é igual ao VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)).
*/
select ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_UNIT - (VALOR_UNIT * (DESCONTO / 100)) as "VALOR VENDIDO" 
from produto where DESCONTO is not null;

/*
c) Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo.
*/
update produto set DESCONTO = 0 where DESCONTO is null and ID_NF != 0;

/*
d) Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta
são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO,
VALOR_VENDIDO. OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE *
VALOR_UNIT. O VALOR_VENDIDO é igual a VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)).
*/
select 
ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT,
VALOR_UNIT * QUANTIDADE as "VALOR_TOTAL", DESCONTO, 
VALOR_UNIT - (VALOR_UNIT * (DESCONTO / 100)) as "VALOR_VENDIDO" 
from produto;

/*
e) Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. OBS: O
VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF.
*/
select ID_NF, sum(QUANTIDADE * VALOR_UNIT) as "VALOR_TOTAL"
from produto 
group by ID_NF 
order by QUANTIDADE * VALOR_UNIT desc;

/*
f) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_VENDIDO. OBS: O
VALOR_VENDIDO é igual a ∑ VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)). Agrupe
o resultado da consulta por ID_NF.
*/
select ID_NF, sum(VALOR_UNIT - (VALOR_UNIT * (DESCONTO / 100))) as "VALOR_VENDIDO" from produto group by ID_NF;

/*
g) Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da
consulta são: COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por
COD_PROD.
*/
select COD_PROD, sum(QUANTIDADE) as "QUANTIDADE" from produto group by COD_PROD;

/*
h) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto.
As colunas presentes no resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE.
Agrupe o resultado da consulta por ID_NF, COD_PROD.
*/
select ID_NF, COD_PROD, QUANTIDADE from produto where QUANTIDADE >= 10 group by ID_NF, COD_PROD;

/*
i) Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o
resultado do maior valor para o menor. As colunas presentes no resultado da consulta
são: ID_NF, VALOR_TOT. OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE
* VALOR_UNIT. Agrupe o resultado da consulta por ID_NF.
*/
select ID_NF, sum(QUANTIDADE * VALOR_UNIT) as "VALOR_TOT" from produto 
group by ID_NF 
having VALOR_TOT > 500 
order by VALOR_TOT desc;

/*
j) Qual o valor médio dos descontos dados por produto. As colunas presentes no
resultado da consulta são: COD_PROD, MEDIA. Agrupe o resultado da consulta por
COD_PROD.
*/
select COD_PROD, avg(DESCONTO) as "MEDIA" from produto group by COD_PROD;

/*
k) Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas
presentes no resultado da consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe
o resultado da consulta por COD_PROD.
*/
select COD_PROD, min(DESCONTO) as "MENOR", 
max(DESCONTO) as "MAIOR", 
avg(DESCONTO) as "MEDIA" 
from produto group by COD_PROD;

/*
l) Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado
da consulta são: ID_NF, QTD_ITENS. OBS:: NÃO ESTÁ RELACIONADO A QUANTIDADE
VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA FISCAL. Agrupe o
resultado da consulta por ID_NF
*/
select ID_NF, count(ID_ITEM) as "QTD_ITENS" from produto 
group by ID_NF having QTD_ITENS > 3;