-- Schema: erp

-- DROP SCHEMA erp;

CREATE SCHEMA erp
  AUTHORIZATION postgres;


-- Table: erp.cidade

-- DROP TABLE erp.cidade;

CREATE TABLE erp.cidade
(
  cod_ibge serial NOT NULL,
  nom_cidade character varying(50),
  nom_estado character varying(30),
  nom_regiao character varying(50),
  nom_pais character varying(50),
  CONSTRAINT cidade_pk PRIMARY KEY (cod_ibge)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.cidade
  OWNER TO postgres;
GRANT ALL ON TABLE erp.cidade TO postgres;
GRANT SELECT ON TABLE erp.cidade TO unifor;


insert into erp.cidade values (1,'fortaleza','ceara','nordeste','brasil');



-- Table: erp.setor

-- DROP TABLE erp.setor;

CREATE TABLE erp.setor
(
  cod_setor serial NOT NULL,
  nom_setor character varying(30),
  CONSTRAINT setor_pk PRIMARY KEY (cod_setor)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.setor
  OWNER TO postgres;
GRANT ALL ON TABLE erp.setor TO postgres;
GRANT SELECT ON TABLE erp.setor TO unifor;



insert into erp.setor values (1,'CARNE');
insert into erp.setor values (2,'FRUTAS');
insert into erp.setor values (3,'ENLATADOS');
insert into erp.setor values (4,'HIGIENE');
insert into erp.setor values (5,'GERAL');


-- Table: erp.unidade

-- DROP TABLE erp.unidade;

CREATE TABLE erp.unidade
(
  cod_unidade serial NOT NULL,
  nom_unidade character varying(30),
  CONSTRAINT unidade_pk PRIMARY KEY (cod_unidade)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.unidade
  OWNER TO postgres;
GRANT ALL ON TABLE erp.unidade TO postgres;
GRANT SELECT ON TABLE erp.unidade TO unifor;


insert into erp.unidade values (1,'LATA');
insert into erp.unidade values (2,'CAIXA');
insert into erp.unidade values (3,'PACOTE');
insert into erp.unidade values (4,'UNIDADE');
insert into erp.unidade values (5,'KG');


-- Table: erp.fornecedor

-- DROP TABLE erp.fornecedor;

CREATE TABLE erp.fornecedor
(
  cod_fornecedor serial NOT NULL,
  nom_fornecedor character varying(50),
  flg_fatura character varying(1),
  num_dias_fatura numeric(3,0),
  CONSTRAINT fornecedor_pk PRIMARY KEY (cod_fornecedor)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.fornecedor
  OWNER TO postgres;
GRANT ALL ON TABLE erp.fornecedor TO postgres;
GRANT SELECT ON TABLE erp.fornecedor TO unifor;



insert into erp.fornecedor values (1,'CEASA','S',30);
insert into erp.fornecedor values (2,'CESAR','S',30);
insert into erp.fornecedor values (3,'DONIVEL','S',30);


-- Table: erp.endereco

-- DROP TABLE erp.endereco;

CREATE TABLE erp.endereco
(
  cod_endereco serial NOT NULL,
  nom_logradouro character varying(50),
  num_logradouro character varying(10),
  cod_cep numeric(8,0),
  cod_ibge integer NOT NULL,
  flg_exterior character varying(1),
  tip_logradouro character varying(3),
  CONSTRAINT endereco_pk PRIMARY KEY (cod_endereco),
  CONSTRAINT endereco_cidade_fk FOREIGN KEY (cod_ibge)
      REFERENCES erp.cidade (cod_ibge) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.endereco
  OWNER TO postgres;
GRANT ALL ON TABLE erp.endereco TO postgres;
GRANT SELECT ON TABLE erp.endereco TO unifor;



insert into erp.endereco values (1,'rua um',1010,60000000,1,'n','n');


-- Table: erp.cliente

-- DROP TABLE erp.cliente;

CREATE TABLE erp.cliente
(
  cod_cliente serial NOT NULL,
  nom_cliente character varying(50),
  flg_fidelizado character varying(1),
  cod_endereco integer NOT NULL,
  CONSTRAINT cliente_pk PRIMARY KEY (cod_cliente),
  CONSTRAINT cliente_endereco_fk FOREIGN KEY (cod_endereco)
      REFERENCES erp.endereco (cod_endereco) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.cliente
  OWNER TO postgres;
GRANT ALL ON TABLE erp.cliente TO postgres;
GRANT SELECT ON TABLE erp.cliente TO unifor;


insert into erp.cliente values (1,'Pedro','S',1);
insert into erp.cliente values (2,'Santos','S',1);
insert into erp.cliente values (3,'Marcos','S',1);
insert into erp.cliente values (4,'Chico','S',1);
insert into erp.cliente values (5,'Pedro marcos','S',1);
insert into erp.cliente values (6,'Francisco','S',1);


-- Table: erp.loja

-- DROP TABLE erp.loja;

CREATE TABLE erp.loja
(
  cod_loja serial NOT NULL,
  nom_loja character varying(50),
  cod_endereco integer NOT NULL,
  flg_matriz character varying(1),
  CONSTRAINT loja_pk PRIMARY KEY (cod_loja),
  CONSTRAINT loja_endereco_fk FOREIGN KEY (cod_endereco)
      REFERENCES erp.endereco (cod_endereco) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.loja
  OWNER TO postgres;
GRANT ALL ON TABLE erp.loja TO postgres;
GRANT SELECT ON TABLE erp.loja TO unifor;


insert into erp.loja values (1,'CENTRO',1,'S');
insert into erp.loja values (2,'ALDEOTA',1,'N');
insert into erp.loja values (3,'MONTESE',1,'N');


-- Table: erp.caixa

-- DROP TABLE erp.caixa;

CREATE TABLE erp.caixa
(
  cod_caixa serial NOT NULL,
  nom_caixa character varying(50),
  cod_loja integer,
  flg_ferias character varying(1),
  CONSTRAINT caixa_pk PRIMARY KEY (cod_caixa),
  CONSTRAINT caixa_loja_fk FOREIGN KEY (cod_loja)
      REFERENCES erp.loja (cod_loja) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.caixa
  OWNER TO postgres;
GRANT ALL ON TABLE erp.caixa TO postgres;
GRANT SELECT ON TABLE erp.caixa TO unifor;


insert into erp.caixa values (1,'Sandra',1,'N');
insert into erp.caixa values (2,'Maria',2,'N');
insert into erp.caixa values (3,'Regina',3,'N');
insert into erp.caixa values (4,'Ana',1,'N');


-- Table: erp.promocao

-- DROP TABLE erp.promocao;

CREATE TABLE erp.promocao
(
  cod_promocao serial NOT NULL,
  nom_promocao character varying(50),
  dat_inicio_vigencia date,
  dat_fim_vigencia date,
  cod_loja integer,
  CONSTRAINT promocao_pk PRIMARY KEY (cod_promocao),
  CONSTRAINT promocao_loja_fk FOREIGN KEY (cod_loja)
      REFERENCES erp.loja (cod_loja) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.promocao
  OWNER TO postgres;
GRANT ALL ON TABLE erp.promocao TO postgres;
GRANT SELECT ON TABLE erp.promocao TO unifor;


-- Table: erp.pdv

-- DROP TABLE erp.pdv;

CREATE TABLE erp.pdv
(
  cod_pdv serial NOT NULL,
  num_registro numeric(10,0),
  dat_inicio_vigencia date,
  dat_fim_vigencia date,
  num_nota_inicial numeric(10,0),
  num_nota_final numeric(10,0),
  cod_loja integer NOT NULL,
  num_pdv_loja numeric(2,0),
  CONSTRAINT pdv_pk PRIMARY KEY (cod_pdv),
  CONSTRAINT pdv_loja_fk FOREIGN KEY (cod_loja)
      REFERENCES erp.loja (cod_loja) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.pdv
  OWNER TO postgres;
GRANT ALL ON TABLE erp.pdv TO postgres;
GRANT SELECT ON TABLE erp.pdv TO unifor;


insert into erp.pdv values (1,1010,'2013-01-01','2017-12-31',1,10000,1,1);
insert into erp.pdv values (2,1011,'2013-01-01','2017-12-31',1,10000,2,2);
insert into erp.pdv values (3,1012,'2013-01-01','2017-12-31',1,10000,3,3);


-- Table: erp.produto

-- DROP TABLE erp.produto;

CREATE TABLE erp.produto
(
  cod_produto serial NOT NULL,
  nom_produto character varying(50),
  cod_fornecedor integer NOT NULL,
  cod_setor integer NOT NULL,
  cod_unidade integer NOT NULL,
  flg_fracionado character varying(1),
  vlr_venda numeric(8,2),
  vlr_custo numeric(8,2),
  vlr_medio numeric(8,2),
  cod_promocao integer,
  vlr_promocao numeric(8,2),
  CONSTRAINT produto_pk PRIMARY KEY (cod_produto),
  CONSTRAINT produto_fornecedor_fk FOREIGN KEY (cod_fornecedor)
      REFERENCES erp.fornecedor (cod_fornecedor) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT produto_promocao_fk FOREIGN KEY (cod_promocao)
      REFERENCES erp.promocao (cod_promocao) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT produto_setor_fk FOREIGN KEY (cod_setor)
      REFERENCES erp.setor (cod_setor) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT produto_unidade_fk FOREIGN KEY (cod_unidade)
      REFERENCES erp.unidade (cod_unidade) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.produto
  OWNER TO postgres;
GRANT ALL ON TABLE erp.produto TO postgres;
GRANT SELECT ON TABLE erp.produto TO unifor;


insert into erp.produto values (1,'PASTA',3,4,4,'N',10.00,5.00,8.00,null,null);
insert into erp.produto values (2,'ESCOVA',3,4,4,'N',15.00,8.00,12.00,null,null);
insert into erp.produto values (3,'LISTERINE',3,4,4,'N',24.90,12.60,18.00,null,null);
insert into erp.produto values (4,'CAREFREE',3,4,3,'N',10.99,7.60,8.90,null,null);
insert into erp.produto values (5,'CANETA',3,5,4,'N',2.00,0.70,1.20,null,null);
insert into erp.produto values (6,'LAPIS',3,5,4,'N',2.00,0.70,1.20,null,null);
insert into erp.produto values (7,'CADERNO',3,5,4,'N',19.00,12.00,13.00,null,null);
insert into erp.produto values (8,'MACA',1,2,5,'N',10.00,5.00,8.00,null,null);
insert into erp.produto values (9,'PERA',1,2,5,'N',15.00,8.00,12.00,null,null);
insert into erp.produto values (10,'MELANCIA',1,2,5,'N',24.90,12.60,18.00,null,null);
insert into erp.produto values (11,'BANANA',1,2,5,'N',10.99,7.60,8.90,null,null);
insert into erp.produto values (12,'FILE',2,2,5,'N',35.00,27.00,31.00,null,null);
insert into erp.produto values (13,'PATINHO',2,2,5,'N',38.00,29.00,34.00,null,null);
insert into erp.produto values (14,'AZEITONA',2,3,3,'N',10.00,5.00,8.00,null,null);
insert into erp.produto values (15,'SARDINHA',2,3,4,'N',15.00,8.00,12.00,null,null);
insert into erp.produto values (16,'BORDON',2,3,4,'N',24.90,12.60,18.00,null,null);


-- Table: erp.nota_fiscal

-- DROP TABLE erp.nota_fiscal;

CREATE TABLE erp.nota_fiscal
(
  seq_nota serial NOT NULL,
  cod_pdv integer NOT NULL,
  cod_caixa integer NOT NULL,
  cod_cliente integer NOT NULL,
  num_nota numeric(10,0),
  dat_nota date,
  flg_entrega character varying(1),
  vlr_nota numeric(10,2),
  vlr_dinheiro numeric(10,2),
  vlr_tick numeric(10,2),
  vlr_cartao numeric(10,2),
  CONSTRAINT nota_fiacal_pk PRIMARY KEY (seq_nota),
  CONSTRAINT nota_fiscal_caixa_fk FOREIGN KEY (cod_caixa)
      REFERENCES erp.caixa (cod_caixa) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT nota_fiscal_cliente_fk FOREIGN KEY (cod_cliente)
      REFERENCES erp.cliente (cod_cliente) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT nota_fiscal_pdv_fk FOREIGN KEY (cod_pdv)
      REFERENCES erp.pdv (cod_pdv) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.nota_fiscal
  OWNER TO postgres;
GRANT ALL ON TABLE erp.nota_fiscal TO postgres;
GRANT SELECT ON TABLE erp.nota_fiscal TO unifor;

-- Index: erp.inx_nota_fiscal_dat

-- DROP INDEX erp.inx_nota_fiscal_dat;

CREATE INDEX inx_nota_fiscal_dat
  ON erp.nota_fiscal
  USING btree
  (dat_nota, seq_nota);

-- Index: erp.inx_nota_fiscal_seq

-- DROP INDEX erp.inx_nota_fiscal_seq;

CREATE INDEX inx_nota_fiscal_seq
  ON erp.nota_fiscal
  USING btree
  (seq_nota);


-- Table: erp.item_nota_fiscal

-- DROP TABLE erp.item_nota_fiscal;

CREATE TABLE erp.item_nota_fiscal
(
  seq_item_nota serial NOT NULL,
  seq_nota integer NOT NULL,
  cod_produto integer NOT NULL,
  qtd_produto numeric(5,2),
  vlr_venda numeric(10,2),
  vlr_custo numeric(10,2),
  vlr_medio numeric(10,2),
  vlr_promocao numeric(10,2),
  CONSTRAINT item_nota_fiscal_pk PRIMARY KEY (seq_item_nota),
  CONSTRAINT item_nota_fiscal_produto_fk FOREIGN KEY (cod_produto)
      REFERENCES erp.produto (cod_produto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT itemnotafiscal_notafiscal_fk FOREIGN KEY (seq_nota)
      REFERENCES erp.nota_fiscal (seq_nota) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE erp.item_nota_fiscal
  OWNER TO postgres;
GRANT ALL ON TABLE erp.item_nota_fiscal TO postgres;
GRANT SELECT ON TABLE erp.item_nota_fiscal TO unifor;

-- Index: erp.hhghgh

-- DROP INDEX erp.hhghgh;

CREATE INDEX hhghgh
  ON erp.item_nota_fiscal
  USING btree
  (seq_nota);

-- Index: erp.inx_item_nota_fiscal_seq

-- DROP INDEX erp.inx_item_nota_fiscal_seq;

CREATE INDEX inx_item_nota_fiscal_seq
  ON erp.item_nota_fiscal
  USING btree
  (seq_item_nota, seq_nota);


