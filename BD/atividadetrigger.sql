EXEC SP_HELPDB;

create database lojainfo;

EXEC SP_HELPDB;

use lojainfo;
GO

create table tb_clientes(
id_cliente int identity(1,1) not null primary key,
nome varchar(50) not null,
endereco varchar(100),
fone char(15),
email varchar(70));
GO

create table tb_clientes_auditoria(
	id_auditoria int PRIMARY KEY identity(1,1),
	id_cliente int,
	nome nvarchar(50) not null,
	endereco nvarchar(100),
	fone nvarchar(15),
	email nvarchar(70),
	acao_de_auditoria nvarchar(255),
	data_de_auditoria datetime
)

create table tb_hardware(
id_hardware int identity(1,1) not null primary key,
descricao varchar(50) not null,
preco_unit decimal,
qtd_atual int,
qtd_minima int,
imagem_do_produto image DEFAULT NULL
);
GO

create table tb_vendas(
id_venda int identity(1,1) not null primary key,
id_cliente int not null,
data datetime not null,
vlr_total decimal(8,2) not null,
desconto decimal(8,2),
vlr_pago decimal(8,2),
);
GO

create table tb_itens_vendas(
id_item int identity(1,1) not null primary key,
id_venda int not null,
id_hardware int not null,
qtd_itens int not null,
total_item decimal(8,2) not null
);
GO

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%'

alter table tb_vendas
      ADD CONSTRAINT fk_vda_cli
      FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente);

alter table tb_itens_vendas
      ADD CONSTRAINT fk_itens_vda
      FOREIGN KEY (id_venda) REFERENCES tb_vendas(id_venda);

EXEC sp_help  'tb_vendas'
EXEC sp_help  'tb_itens_vendas'

PRINT '###CRIANDO NOSSA PRIMEIRA TRIGGER'
GO

CREATE TRIGGER trgAfterInsertCliente ON tb_clientes
FOR INSERT
AS
declare @cliid int;
declare @clinome varchar(100);
declare @cliend varchar(100);
declare @clifone varchar(100);
declare @cliemail varchar(100);

declare @audit_action varchar(100);

select @cliid=i.id_cliente from inserted i;
select @clinome=i.nome from inserted i;
select @cliend=i.endereco from inserted i;
select @clifone=i.fone from inserted i;
select @cliemail=i.email from inserted i;

set @audit_action='Registro Inserido -- [Trigger do tipo After Insert na tb_clientes].';

insert into tb_clientes_auditoria (id_cliente,nome,endereco,fone,email,acao_de_auditoria,data_de_auditoria)
values(@cliid,@clinome,@cliend,@clifone,@cliemail,@audit_action,GETDATE());

PRINT 'FIM DA EXECUCAO DA TRIGUER after insert cliente.'
GO

insert into tb_clientes values ('Jeferson','Aguia Haia 123','11-99999-9999','jef@dom.com'),
 ('Carlos','Aguia Haia 456','11-99999-9999','carlos@dom.com'),
 ('Ralf','Aguia Haia 789','11-99999-9999','ralf@dom.com');
GO
select * from tb_clientes;

insert into tb_hardware values
('gabinete',     60.50, 100, 10, NULL),
('processador', 300.50, 100, 10, NULL),
('placa mãe',   100.50, 100, 10, NULL),
('Dico Rígido',  80.90, 100, 10, NULL),
('Monitor',     300.20, 100, 10, NULL);
GO

select * from tb_hardware;

insert into tb_vendas values (1,'2018-02-10', 8471, 100, 8371),
 (3,'2018-02-10',1086,0,1086);
GO
select * from tb_vendas;

insert into tb_itens_vendas values (2,4,10, 600.50),
(2,5,10,3005),
(2,6,10,1050),
(2,7,10,809),
(2,8,10,3002);

insert into tb_itens_vendas values (3,4,1,60.50),
(3,5,1,300.50),
(3,6,1,105),
(3,7,1,80.9),
(3,8,1,3002);

select * from tb_itens_vendas;

select * from tb_clientes c join tb_vendas v on c.id_cliente = v.id_cliente;

select c.id_cliente as IdClienteDaTblCliente,
       v.id_cliente as IdClienteDaTblVendas,
       c.nome from
       tb_clientes c
       left join tb_vendas v
       on c.id_cliente = v.id_cliente;


select c.id_cliente as IdClienteDaTblCliente,
       v.id_cliente as IdClienteDaTblVendas,
       c.nome as nomeCliente,
       v.id_venda as IdVendaDaTblVendas
       from
       tb_clientes c
       left join tb_vendas v
              on c.id_cliente = v.id_cliente;

select c.id_cliente as IdClienteDaTblCliente,
       v.id_cliente as IdClienteDaTblVendas,
       c.nome as nomeCliente,
       v.id_venda as IdVendaDaTblVendas,
       i.id_item as idItem,
       i.id_hardware as idHardware,
       i.qtd_itens as qtde,
       i.total_item as vlrTotItem
       from
       tb_clientes c
       left join tb_vendas v
              on c.id_cliente = v.id_cliente
       join tb_itens_vendas as i
              on v.id_venda = i.id_venda;

select c.id_cliente as IdClienteDaTblCliente,
       v.id_cliente as IdClienteDaTblVendas,
       c.nome as nomeCliente,
       v.id_venda as IdVendaDaTblVendas,
       i.id_item as idItem,
       i.id_hardware as idHardware
       from
       tb_clientes c
       left join tb_vendas v
              on c.id_cliente = v.id_cliente
       left join tb_itens_vendas as i
              on v.id_venda = i.id_venda;

select v.id_venda as IdVendaDaTblVendas,
       c.nome as nomeCliente,
       sum(i.total_item) as VlrDaVenda
       from
       tb_clientes c
       join tb_vendas v
              on c.id_cliente = v.id_cliente
       join tb_itens_vendas as i
              on v.id_venda = i.id_venda
       group by v.id_venda, c.nome;