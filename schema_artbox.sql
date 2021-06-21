--
-- Create Schema Script 
--   Database Version   : 11.2.0.1.0 
--   TOAD Version       : 9.0.1.8 
--   DB Connect String  : TESTE 
--   Schema             : ARTBOX 
--   Script Created by  : ARTBOX 
--   Script Created at  : 21/06/2021 15:02:17 
--   Physical Location  :  
--   Notes              :  
--

-- Object Counts: 
--   Indexes: 22        Columns: 34         
--   Packages: 4        Lines of Code: 75 
--   Package Bodies: 4  Lines of Code: 787 
--   Procedures: 2      Lines of Code: 169 
--   Sequences: 14 
--   Tables: 26         Columns: 156        Constraints: 52     
--   Triggers: 15 
--   Types: 1 
--   Views: 1           


CREATE OR REPLACE Type ot_lancamentos As Object
(
   seq_lancamento  Number,
   seq_material    Number(10),
   dat_lancamento  Date,
   tpo_lancamento  Varchar2(1),
   qtd_lancamento  Number(7, 2),
   val_lancamento  Number(10, 2),
   qtd_estoque     Number(7, 2),
   val_estoque     Number(10, 2),
   val_custo_medio Number(10, 2),
   num_requisicao  Number(7),
   num_item        Number(5),
   seq_fornecedor  Number(9),
   num_nota        Number(7),
   seq_item        Number(3),
   tpo_resultado   Number(1),

-- constructor para custo médio atual ATB_MATERIAIS
   Constructor Function ot_lancamentos(p_seq_material Number) Return Self As Result,

-- Constructor resultados (p_tpo_resultado (1-estoque Atual 2-verifica saldo negativo)      
   Constructor Function ot_lancamentos
   (
	  p_seq_material   Number,
	  p_dat_lancamento Date,
	  p_tpo_resultado  Number
   ) Return Self As Result,

-- constructor para Associar fornecedores e materiaicusto médio atual ATB_MATERIAIS
/*   Constructor Function ot_lancamentos
   (
	  p_seq_fornecedor Number,
	  p_seq_material   Number
   ) Return Self As Result,*/

   Member Procedure prc_associar_material
   (
	  p_seq_fornecedor Number,
	  p_seq_material   Number
   )

)
/

SHOW ERRORS;


CREATE SEQUENCE SQ_ATB_CLIENTES
  START WITH 8
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_FORNECEDOR
  START WITH 531
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_FORNECEDOR_MATERIAL
  START WITH 0
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_JOB
  START WITH 2
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_JOB_DET
  START WITH 52
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_LANCAMENTOS
  START WITH 521
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_MATERIAL
  START WITH 68
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_MATERIAL_SLA_DET
  START WITH 562
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_MATERIAL_SLA_EMAIL
  START WITH 58
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_NOTAS
  START WITH 40
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_NOTA_ENTRADA_ITEM
  START WITH 0
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_PRODUTOS
  START WITH 2
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_REQUISICOES
  START WITH 66
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_SERVICOS
  START WITH 6
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE TABLE ATB_NOTAS_ENT
(
  SEQ_FORNECEDOR  NUMBER(9)                     NOT NULL,
  NUM_NOTA        NUMBER(7)                     NOT NULL,
  DAT_COMPRA      DATE                          NOT NULL,
  VAL_COMPRA      NUMBER(10,2)                  NOT NULL,
  NOM_USUARIO     VARCHAR2(20 BYTE)             NOT NULL,
  STA_NOTA        VARCHAR2(1 BYTE)              NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_REQUISICOES_ITENS
(
  NUM_REQUISICAO  NUMBER(7)                     NOT NULL,
  NUM_ITEM        NUMBER(5)                     NOT NULL,
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  QTD_MATERIAL    NUMBER(7,2)                   NOT NULL,
  VAL_MATERIAL    NUMBER(10,2)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_MATERIAIS_SLA
(
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  VAL_NIVEL       NUMBER(1)                     NOT NULL,
  QTD_HORAS       NUMBER(3),
  NOM_COR_HTML    VARCHAR2(60 BYTE),
  NOM_TITULO_TAB  VARCHAR2(80 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_MATERIAIS_SLA_DET
(
  SEQ_SLA_DET     NUMBER(10)                    NOT NULL,
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  VAL_NIVEL       NUMBER(1)                     NOT NULL,
  NOM_COR_HTML    VARCHAR2(60 BYTE),
  DAT_LIMITE_SLA  DATE,
  STA_SLA         VARCHAR2(1 BYTE)              NOT NULL,
  DAT_EMISSAO     DATE
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON COLUMN ATB_MATERIAIS_SLA_DET.STA_SLA IS 'P-Pendente, E-Enviado, C-Cancelado';


CREATE TABLE ATB_SERVICOS_TARIFAS
(
  SEQ_SERVICO   NUMBER(10)                      NOT NULL,
  DAT_VIGENCIA  DATE                            NOT NULL,
  VAL_SERVICO   NUMBER(10,2)                    NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_LANCAMENTOS
(
  SEQ_LANCAMENTO   NUMBER                       NOT NULL,
  SEQ_MATERIAL     NUMBER(10)                   NOT NULL,
  DAT_LANCAMENTO   DATE                         NOT NULL,
  TPO_LANCAMENTO   VARCHAR2(1 BYTE)             DEFAULT 'E'                   NOT NULL,
  QTD_LANCAMENTO   NUMBER(7,2)                  NOT NULL,
  VAL_LANCAMENTO   NUMBER(10,2)                 NOT NULL,
  QTD_ESTOQUE      NUMBER(7,2),
  VAL_ESTOQUE      NUMBER(10,2),
  VAL_CUSTO_MEDIO  NUMBER(10,2),
  NUM_REQUISICAO   NUMBER(7),
  NUM_ITEM         NUMBER(5),
  SEQ_FORNECEDOR   NUMBER(9),
  NUM_NOTA         NUMBER(7),
  SEQ_ITEM         NUMBER(3)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_REQUISICOES
(
  NUM_REQUISICAO  NUMBER(7)                     NOT NULL,
  DSC_REQUISICAO  VARCHAR2(60 BYTE)             NOT NULL,
  DAT_REQUISICAO  DATE                          NOT NULL,
  NOM_USUARIO     VARCHAR2(30 BYTE),
  STA_REQUISICAO  VARCHAR2(1 BYTE)              NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_PRODUTOS_MAT
(
  SEQ_PRODUTO   NUMBER(10)                      NOT NULL,
  SEQ_MATERIAL  NUMBER(10)                      NOT NULL,
  QTD_MATERIAL  NUMBER(7,2)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE LOGRADOURO
(
  ZONA_LIGACAO       NUMBER(3)                  NOT NULL,
  COD_LOGR           NUMBER(7)                  NOT NULL,
  NOM_LOGR           VARCHAR2(60 BYTE)          NOT NULL,
  NOM_LOGR_FANTASIA  VARCHAR2(80 BYTE),
  NOM_LOGR_ANT       VARCHAR2(60 BYTE),
  REF_GUIA           VARCHAR2(10 BYTE),
  TPO_LOGR           VARCHAR2(5 BYTE),
  TIT_LOGR           VARCHAR2(7 BYTE),
  COD_RESERVATORIO   NUMBER(3)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_MATERIAIS_SALDOS
(
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  DAT_REFERENCIA  DATE                          NOT NULL,
  QTD_SALDO       NUMBER(7,2)                   NOT NULL,
  VAL_SALDO       NUMBER(10,2)                  NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_FORNECEDORES_ENDERECO
(
  SEQ_FORNECEDOR   NUMBER(9)                    NOT NULL,
  DM_TPO_ENDERECO  NUMBER(1)                    NOT NULL,
  SEQ_LOGRADOURO   NUMBER                       NOT NULL,
  NUM_ENDERECO     NUMBER(12)                   NOT NULL,
  NOM_COMPLEMENTO  VARCHAR2(20 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_PRODUTOS_SERV
(
  SEQ_PRODUTO  NUMBER(10)                       NOT NULL,
  SEQ_SERVICO  NUMBER(10)                       NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE LOGRADOURO1
(
  NOM_BAIRRO  VARCHAR2(100 BYTE),
  COD_LOGR    VARCHAR2(100 BYTE),
  TIT_LOGR    VARCHAR2(100 BYTE),
  NOM_LOGR    VARCHAR2(100 BYTE),
  TPO_LOGR    VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE BAIRRO
(
  ZONA_LIGACAO  NUMBER(3)                       NOT NULL,
  COD_BAIRRO    NUMBER(6)                       NOT NULL,
  NOM_BAIRRO    VARCHAR2(30 BYTE)               NOT NULL,
  COD_LOJA      VARCHAR2(6 BYTE)                NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_JOB
(
  SEQ_JOB  NUMBER                               NOT NULL,
  DSC_JOB  VARCHAR2(60 BYTE)                    NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_MATERIAIS
(
  SEQ_MATERIAL       NUMBER(10)                 NOT NULL,
  NOM_MATERIAL       VARCHAR2(40 BYTE)          NOT NULL,
  DM_UNIDADE_MEDIDA  VARCHAR2(2 BYTE)           NOT NULL,
  QTD_MINIMO         NUMBER(7,2)                NOT NULL,
  QTD_MAXIMO         NUMBER(7,2)                NOT NULL,
  QTD_ESTOQUE        NUMBER(7,2),
  VAL_ESTOQUE        NUMBER(10,2),
  VAL_UNITARIO       NUMBER(10,2),
  DAT_CADASTRO       DATE                       NOT NULL,
  DAT_SLA            DATE,
  NOM_USUARIO        VARCHAR2(20 BYTE)          NOT NULL,
  IMG_MATERIAL       VARCHAR2(40 BYTE),
  DMN_FL_BLOQ        VARCHAR2(1 BYTE)           NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_MATERIAIS_SLA_EMAIL
(
  SEQ_EMAIL    NUMBER                           NOT NULL,
  DSC_ASSUNTO  VARCHAR2(120 BYTE)               NOT NULL,
  DSC_CORPO    LONG,
  STA_EMAIL    VARCHAR2(1 BYTE)                 NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON COLUMN ATB_MATERIAIS_SLA_EMAIL.STA_EMAIL IS 'P-Pendente, E-Enviado,  C-Cancelado';


CREATE TABLE ATB_PRODUTOS
(
  SEQ_PRODUTO   NUMBER(10)                      NOT NULL,
  NOM_PRODUTO   VARCHAR2(40 BYTE)               NOT NULL,
  DAT_CADASTRO  DATE                            NOT NULL,
  VAL_CUSTO     NUMBER(10,2),
  VAL_SUGERIDO  NUMBER(10,2),
  VAL_VENDA     NUMBER(10,2)                    NOT NULL,
  QTD_MINIMO    NUMBER(4),
  QTD_MAXIMO    NUMBER(4),
  QTD_ESTOQUE   NUMBER(4)                       DEFAULT 0                     NOT NULL,
  NOM_USUARIO   VARCHAR2(20 BYTE),
  IMG_PRODUTO   VARCHAR2(40 BYTE),
  DMN_FL_BLOQ   VARCHAR2(1 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_CLIENTES
(
  SEQ_CLIENTE     NUMBER(8)                     NOT NULL,
  DM_TPO_PESSOA   VARCHAR2(1 BYTE)              NOT NULL,
  NUM_CPF         VARCHAR2(11 BYTE),
  NUM_CNPJ        VARCHAR2(14 BYTE),
  NOM_CLIENTE     VARCHAR2(40 BYTE)             NOT NULL,
  NOM_FANTASIA    VARCHAR2(25 BYTE),
  DM_TPO_CLIENTE  VARCHAR2(1 BYTE),
  DM_FL_BLOQ      VARCHAR2(1 BYTE)              DEFAULT 'N'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_FORNECEDORES
(
  SEQ_FORNECEDOR    NUMBER(9)                   NOT NULL,
  NUM_CNPJ          NUMBER(14)                  NOT NULL,
  NOM_RAZAO_SOCIAL  VARCHAR2(40 BYTE)           NOT NULL,
  NOM_FANTASIA      VARCHAR2(20 BYTE),
  NOM_CONTATO       VARCHAR2(40 BYTE),
  NUM_TELEFONE      NUMBER(11),
  NOM_USUARIO       VARCHAR2(20 BYTE)           NOT NULL,
  DAT_CADASTRO      DATE                        NOT NULL,
  DMN_FL_BLOQ       VARCHAR2(1 BYTE)            DEFAULT 'N'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE CARLOS
(
  NUM_DOC_1    VARCHAR2(25 BYTE),
  NOM_CLIENTE  VARCHAR2(50 BYTE)                NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_JOB_DET
(
  SEQ_JOB_DET  NUMBER                           NOT NULL,
  SEQ_JOB      NUMBER                           NOT NULL,
  DAT_CAD      DATE                             NOT NULL,
  NOM_USUARIO  VARCHAR2(20 BYTE)                DEFAULT user                  NOT NULL,
  NUM_JOB      NUMBER,
  DAT_EXEC     DATE                             NOT NULL,
  DAT_INI      DATE,
  DAT_FIM      DATE,
  STA_JOB      VARCHAR2(1 BYTE)                 NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON COLUMN ATB_JOB_DET.STA_JOB IS 'P-Programado, E-Executando, C-Cancelado, F-Feito';


CREATE TABLE ATB_CLIENTES_ENDERECOS
(
  SEQ_CLIENTE      NUMBER(8)                    NOT NULL,
  DM_TPO_ENDERECO  NUMBER(1)                    NOT NULL,
  SEQ_LOGRADOURO   NUMBER                       NOT NULL,
  NUM_ENDERECO     NUMBER                       NOT NULL,
  NOM_COMPLEMENTO  VARCHAR2(25 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_NOTAS_ENT_ITENS
(
  SEQ_FORNECEDOR  NUMBER(9)                     NOT NULL,
  NUM_NOTA        NUMBER(7)                     NOT NULL,
  SEQ_ITEM        NUMBER(3)                     NOT NULL,
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  QTD_ITEM        NUMBER(5,2)                   NOT NULL,
  VAL_ITEM        NUMBER(10,2)                  NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_FORNECEDORES_MAT
(
  SEQ_FORNECEDOR     NUMBER(9)                  NOT NULL,
  SEQ_MATERIAL       NUMBER(10)                 NOT NULL,
  DAT_CADASTRO       DATE                       NOT NULL,
  NOM_USUARIO        VARCHAR2(20 BYTE)          NOT NULL,
  QTD_MAXIMA_COMPRA  NUMBER(7,2)                NOT NULL,
  VAL_PRECO_MAXIMO   NUMBER(10,2)               NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_SERVICOS
(
  SEQ_SERVICO  NUMBER(10)                       NOT NULL,
  DSC_SERVICO  VARCHAR2(40 BYTE)                NOT NULL,
  DMN_FL_BLOQ  VARCHAR2(1 BYTE)                 NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX ATB_MATERIAL_SLA_EMAIL_PK ON ATB_MATERIAIS_SLA_EMAIL
(SEQ_EMAIL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_MATERIAL_SLA_PK ON ATB_MATERIAIS_SLA
(SEQ_MATERIAL, VAL_NIVEL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_JOB_DET_PK ON ATB_JOB_DET
(SEQ_JOB_DET)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_JOB_PK ON ATB_JOB
(SEQ_JOB)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_MATERIAL_SLA_DET_PK ON ATB_MATERIAIS_SLA_DET
(SEQ_SLA_DET)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_CLIENTES_END_PK ON ATB_CLIENTES_ENDERECOS
(SEQ_CLIENTE, DM_TPO_ENDERECO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_CLIENTES_PK ON ATB_CLIENTES
(SEQ_CLIENTE)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_SERVICOS_PK ON ATB_SERVICOS
(SEQ_SERVICO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_MATERIAL_SALDOS_PK ON ATB_MATERIAIS_SALDOS
(SEQ_MATERIAL, DAT_REFERENCIA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PRODUTOS_PK ON ATB_PRODUTOS
(SEQ_PRODUTO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_PRODUTOS_SERV_PK ON ATB_PRODUTOS_SERV
(SEQ_PRODUTO, SEQ_SERVICO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_PRODUTOS_MAT_PK ON ATB_PRODUTOS_MAT
(SEQ_PRODUTO, SEQ_MATERIAL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_SERVICOS_TAR_PK ON ATB_SERVICOS_TARIFAS
(SEQ_SERVICO, DAT_VIGENCIA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FORNECEDOR_MAT_PK ON ATB_FORNECEDORES_MAT
(SEQ_FORNECEDOR, SEQ_MATERIAL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FORNECEDOR_PK ON ATB_FORNECEDORES
(SEQ_FORNECEDOR)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX MATERIAL_PK ON ATB_MATERIAIS
(SEQ_MATERIAL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_REQUISICAO_PK ON ATB_REQUISICOES
(NUM_REQUISICAO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_NFE_ITEM_PK ON ATB_NOTAS_ENT_ITENS
(SEQ_FORNECEDOR, NUM_NOTA, SEQ_ITEM)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_NOTA_ENTRADA_PK ON ATB_NOTAS_ENT
(SEQ_FORNECEDOR, NUM_NOTA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_REQUISICAO_ITEM_PK ON ATB_REQUISICOES_ITENS
(NUM_REQUISICAO, NUM_ITEM)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_LANCAMENTOS_PK ON ATB_LANCAMENTOS
(SEQ_LANCAMENTO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FORNECEDOR_ENDERECO_PK ON ATB_FORNECEDORES_ENDERECO
(SEQ_FORNECEDOR, DM_TPO_ENDERECO)
LOGGING
NOPARALLEL;


CREATE OR REPLACE Package pkg_nota_entrada Is

   -- Author  : CARLOS
   -- Created : 05/02/2021
   -- Purpose : Encapsular os métodos da tabela NOTA_ENTRADA

   Procedure prc_acerta_item
   (
	  p_seq_fornecedor In atb_notas_ent.seq_fornecedor%Type,
	  p_num_nota       In atb_notas_ent.num_nota%Type
   );

   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_notas_ent.seq_fornecedor%Type,
	  p_num_nota       In atb_notas_ent.num_nota%Type
   );

End pkg_nota_entrada;
/

SHOW ERRORS;


CREATE OR REPLACE Package pkg_materiais Is

   -- Author  : CARLOS
   -- Created : 04/02/2021 16:21:11
   -- Purpose : Encapsular os métodos da tabel ATB_MATRIAL

   Procedure prc_calc_estoque
   (
	  p_seq_material   In atb_materiais.seq_material%Type,
	  p_dat_lancamento In atb_notas_ent.dat_compra%Type
   );

   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_notas_ent.seq_fornecedor%Type,
	  p_num_nota       In atb_notas_ent.num_nota%Type
   );

   Procedure prc_fecha_requisicao(p_num_requisicao In atb_requisicoes.num_requisicao%Type);

   Procedure prc_fechamento_estoque(p_dat_lancamento In atb_notas_ent.dat_compra%Type);

   Procedure prc_materiais_sla(p_dt_exec In Date);

End pkg_materiais;
/

SHOW ERRORS;


CREATE OR REPLACE Package pkg_jobs Is

   -- Author  : CARLOS
   -- Created : 13/01/2017 10:09:05
   -- Purpose : Administrar os JOBS do sistema Artbox

   --> Abrir arquivo para execução de JOBS
   Function fnc_cad_job
   (
	  p_seq_job In Number,
	  p_num_job  In Number,
	  p_dat_exec In Date
   ) Return Number;

   Procedure prc_ini_job(p_seq_job In Number);

   Procedure prc_fim_job(p_seq_job In Number);

End pkg_jobs;
/

SHOW ERRORS;


CREATE OR REPLACE Package pkg_fornecedor Is

	-- Author  : CARLOS
	-- Created : 21/01/2021
	-- Purpose : Encapsular os métodos da tabela fornecedor

	Function fnc_digito_cpf_cnpj(p_cpf_cnpj   In Varchar2,
								 p_dv_calculo In Out Varchar2) Return Boolean;

	Function fnc_formata_cpf_cnpj(p_cpf_cnpj In Varchar2) Return Varchar2;

End pkg_fornecedor;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_nota_entrada Is

   -- Author  : CARLOS
   -- Created : 05/02/2021
   -- Purpose : Encapsular os métodos da tabela NOTA_ENTRADA

   Procedure prc_acerta_item
   (
	  p_seq_fornecedor In atb_notas_ent.seq_fornecedor%Type,
	  p_num_nota       In atb_notas_ent.num_nota%Type
   ) Is
   
	  v_seq_item atb_notas_ent_itens.seq_item%Type;
   
	  Type rg_item Is Record(
		 seq_item     Number(3),
		 seq_material Number(10),
		 qtd_item     Number(5, 2),
		 val_item     Number(10, 2));
	  Type tb_item Is Table Of rg_item Index By Binary_Integer;
	  v_itens tb_item;
   
	  Cursor c_item Is
		 Select seq_item, seq_material, qtd_item, val_item
		 From   atb_notas_ent_itens
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota;
   
   Begin
   
	  v_seq_item := 0;
	  For rec In c_item Loop
	  
		 v_seq_item := v_seq_item + 1;
		 v_itens(v_seq_item).seq_material := rec.seq_material;
		 v_itens(v_seq_item).qtd_item := rec.qtd_item;
		 v_itens(v_seq_item).val_item := rec.val_item;
	  
	  End Loop;
   
	  Delete atb_notas_ent_itens
	  Where  seq_fornecedor = p_seq_fornecedor And
			 num_nota = p_num_nota;
   
	  For vetor In v_itens.First .. v_itens.Count Loop
		 Insert Into atb_notas_ent_itens
			(seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item)
		 Values
			(p_seq_fornecedor, p_num_nota, vetor, v_itens(vetor).seq_material,
			 v_itens(vetor).qtd_item, v_itens(vetor).val_item);
	  
	  End Loop;
   
	  Commit;
   
   End;

   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_notas_ent.seq_fornecedor%Type,
	  p_num_nota       In atb_notas_ent.num_nota%Type
   ) Is
   
	  v_dat_compra atb_notas_ent.dat_compra%Type;
	  v_val_compra atb_notas_ent.val_compra%Type;
	  v_sta_nota   atb_notas_ent.sta_nota%Type;
   
	  Cursor c_itens Is
		 Select seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item
		 From   atb_notas_ent_itens
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota
		 Order  By seq_item;
   
   Begin
   
	  Begin
		 Select dat_compra, val_compra, sta_nota
		 Into   v_dat_compra, v_val_compra, v_sta_nota
		 From   atb_notas_ent
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota;
	  
	  Exception
		 When Others Then
			raise_application_error(-20101,
									'Erro ao selecionar nota de entrada: ' || p_num_nota);
	  End;
   
	  For rec In c_itens Loop
	  
		 Begin
			pkg_materiais.prc_calc_estoque(p_seq_material => rec.seq_material,
										  p_dat_lancamento => v_dat_compra);
		 Exception
			When Others Then
			   raise_application_error(-20102, 'Erro ao calcular saldos: ' || rec.seq_material);
		 End;
	  
	  End Loop;
   
	  Update atb_notas_ent
	  Set    sta_nota = 'F'
	  Where  seq_fornecedor = p_seq_fornecedor And
			 num_nota = p_num_nota;
	  
	   Commit;
   
   Exception
	  When Others Then
		 raise_application_error(-20103,
								 'Erro ao fechar nota de entrada: ' || p_num_nota);
	  
   End;

End pkg_nota_entrada;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_materiais Is

   -- Author  : CARLOS
   -- Created : 04/02/2021 16:21:11
   -- Purpose : Encapsular os métodos da tabel ATB_MATRIAL

   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   -- Recalcula custo médio e saldos mensais do material
   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   Procedure prc_calc_estoque
   (
	  p_seq_material   In atb_materiais.seq_material%Type,
	  p_dat_lancamento In atb_notas_ent.dat_compra%Type
   ) Is
   
	  v_custo_medio    Number;
	  v_dat_referencia atb_materiais_saldos.dat_referencia%Type;
	  v_qtd_saldo      atb_materiais_saldos.qtd_saldo%Type;
	  v_val_saldo      atb_materiais_saldos.val_saldo%Type;
   
	  Cursor c_lcto Is
		 Select seq_lancamento, seq_material, dat_lancamento, tpo_lancamento, qtd_lancamento,
				val_lancamento, qtd_estoque, val_estoque, val_custo_medio
		 From   atb_lancamentos
		 Where  seq_material = p_seq_material And
				dat_lancamento > v_dat_referencia
		 Order  By dat_lancamento, decode(tpo_lancamento, 'E', 1, 2), seq_lancamento;
   
   Begin
   
	  Begin
		 -- Seleciona o ultimo mes ref (ultimo dia do mes)
		 Select dat_referencia, qtd_saldo, val_saldo
		 Into   v_dat_referencia, v_qtd_saldo, v_val_saldo
		 From   atb_materiais_saldos sl,
				(Select Max(dat_referencia) maximo
				  From   atb_materiais_saldos
				  Where  seq_material = p_seq_material And
						 dat_referencia < p_dat_lancamento) x
		 Where  seq_material = p_seq_material And
				dat_referencia = x.maximo;
	  
		 v_custo_medio := 0;
		 If v_val_saldo > 0 Then
			v_custo_medio := round(v_val_saldo / v_qtd_saldo, 2);
		 End If;
	  
	  Exception
		 When no_data_found Then
			-- se não existir cria com valor zeraso.
			v_dat_referencia := last_day(add_months(p_dat_lancamento, -1));
			Insert Into atb_materiais_saldos
			   (seq_material, dat_referencia, qtd_saldo, val_saldo)
			Values
			   (p_seq_material, v_dat_referencia, 0, 0);
			v_custo_medio := 0;
		 
		 When Others Then
			Rollback;
			raise_application_error(-20001, 'Erro ao selcionar saldo inicial ' || Sqlerrm);
	  End;
   
	  For r_lcto In c_lcto Loop
	  
		 If months_between(r_lcto.dat_lancamento, v_dat_referencia) > 1 Then
			While months_between(r_lcto.dat_lancamento, v_dat_referencia) > 1 Loop
			   v_dat_referencia := last_day(add_months(v_dat_referencia, 1));
			   Delete atb_materiais_saldos
			   Where  seq_material = p_seq_material And
					  dat_referencia = v_dat_referencia;
			   Insert Into atb_materiais_saldos
				  (seq_material, dat_referencia, qtd_saldo, val_saldo)
			   Values
				  (p_seq_material, v_dat_referencia, v_qtd_saldo, v_val_saldo);
			
			End Loop;
		 
		 End If;
	  
		 -- Entrada altera CUSTO MÉDIO
		 If r_lcto.tpo_lancamento = 'E' Then
		 
			v_qtd_saldo   := nvl(v_qtd_saldo, 0) + r_lcto.qtd_lancamento;
			v_val_saldo   := nvl(v_val_saldo, 0) + r_lcto.val_lancamento;
			v_custo_medio := 0;
			If v_val_saldo > 0 Then
			   v_custo_medio := round(v_val_saldo / v_qtd_saldo, 2);
			End If;
		 
		 Else
		 
			v_qtd_saldo           := nvl(v_qtd_saldo, 0) - r_lcto.qtd_lancamento;
			r_lcto.val_lancamento := r_lcto.qtd_lancamento * v_custo_medio;
			v_val_saldo           := nvl(v_val_saldo, 0) - r_lcto.val_lancamento;
		 
		 End If;
	  
		 Update atb_lancamentos
		 Set    val_lancamento  = r_lcto.val_lancamento,
				qtd_estoque     = v_qtd_saldo,
				val_estoque     = v_val_saldo,
				val_custo_medio = v_custo_medio
		 Where  seq_lancamento = r_lcto.seq_lancamento;
	  
	  End Loop;
   
	  If months_between(p_dat_lancamento, v_dat_referencia) > 1 Then
		 While months_between(p_dat_lancamento, v_dat_referencia) > 1 Loop
			v_dat_referencia := last_day(add_months(v_dat_referencia, 1));
			Delete atb_materiais_saldos
			Where  seq_material = p_seq_material And
				   dat_referencia = v_dat_referencia;
			Insert Into atb_materiais_saldos
			   (seq_material, dat_referencia, qtd_saldo, val_saldo)
			Values
			   (p_seq_material, v_dat_referencia, v_qtd_saldo, v_val_saldo);
		 
		 End Loop;
	  
	  End If;
   
	  --alterar saldos atb_materiais
	  Update atb_materiais
	  Set    qtd_estoque  = v_qtd_saldo,
			 val_estoque  = v_val_saldo,
			 val_unitario = v_custo_medio
	  Where  seq_material = p_seq_material;
   
	  --Commit;
   
   Exception
	  When Others Then
		 raise_application_error(-20003, 'Erro: Calcular saldos, Material: ' || Sqlerrm);
	  
   End prc_calc_estoque;

   --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
   -- Acerta Sequência dos itens no nota Fiscal                                                                                                                                                                      
   --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_notas_ent.seq_fornecedor%Type,
	  p_num_nota       In atb_notas_ent.num_nota%Type
   ) Is
   
	  Cursor c_itens Is
		 Select seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item
		 From   atb_notas_ent_itens
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota
		 Order  By seq_item;
   
	  r_itens      c_itens%Rowtype;
	  v_dat_compra atb_notas_ent.dat_compra%Type;
   
   Begin
	  Select dat_compra
	  Into   v_dat_compra
	  From   atb_notas_ent
	  Where  seq_fornecedor = p_seq_fornecedor And
			 num_nota = p_num_nota;
   
	  For r_itens In c_itens Loop
		 Begin
			-- Call the procedure
			pkg_materiais.prc_calc_estoque(p_seq_material => r_itens.seq_material,
										   p_dat_lancamento => v_dat_compra);
		 Exception
			When Others Then
			   raise_application_error(-20003,
									   'Erro ao calcular saldo do Material: ' ||
										r_itens.seq_material);
		 End;
	  
	  End Loop;
   
	  Update atb_notas_ent ne
	  Set    ne.sta_nota = 'F'
	  Where  ne.seq_fornecedor = p_seq_fornecedor And
			 ne.num_nota = p_num_nota;
	  Commit;
   
   End prc_fecha_nota;

   Procedure prc_fecha_requisicao(p_num_requisicao In atb_requisicoes.num_requisicao%Type) Is
   
	  Cursor c_itens Is
		 Select rq.dat_requisicao, ri.num_item, ri.seq_material, ri.qtd_material
		 From   atb_requisicoes rq, atb_requisicoes_itens ri
		 Where  rq.num_requisicao = ri.num_requisicao And
				ri.num_requisicao = p_num_requisicao
		 Order  By ri.num_item;
   
	  r_itens c_itens%Rowtype;
   
   Begin
   
	  For r_itens In c_itens Loop
		 Begin
			-- Call the procedure
			pkg_materiais.prc_calc_estoque(p_seq_material => r_itens.seq_material,
										   p_dat_lancamento => r_itens.dat_requisicao);
		 Exception
			When Others Then
			   raise_application_error(-20003,
									   'Erro ao calcular saldo do Material: ' ||
										r_itens.seq_material);
		 End;
	  
	  End Loop;
   
	  Update atb_requisicoes re
	  Set    re.sta_requisicao = 'F'
	  Where  re.num_requisicao = p_num_requisicao;
	  Commit;
   
   End prc_fecha_requisicao;

   Procedure prc_fechamento_estoque(p_dat_lancamento In atb_notas_ent.dat_compra%Type) Is
   
	  Cursor c_mat Is
		 Select seq_material
		 From   atb_materiais;
   
   Begin
   
	  For r_mat In c_mat Loop
	  
		 Begin
			pkg_materiais.prc_calc_estoque(p_seq_material => r_mat.seq_material,
										   p_dat_lancamento => p_dat_lancamento);
		 Exception
			When Others Then
			   raise_application_error(-210005,
									   'Erroo no Fechamento mensal, ' || r_mat.seq_material);
		 End;
	  
	  End Loop;
   
   End;

   Procedure prc_materiais_sla(p_dt_exec In Date) Is
   
	  v_aux         Number;
	  v_tabela      Number := 0;
	  v_seq_sla_det atb_materiais_sla_det.seq_sla_det%Type;
   
	  v_data_exec   Varchar2(20) := to_char(p_dt_exec, 'DD/MM/YYYY HH24:MI:SS');
	  v_data_sla    Varchar2(20);
	  v_data_limite Varchar2(20);
   
	  e_saida Exception;
	  e_prox_nivel Exception;
   
	  v_prox_nivel Number := 0;
   
	  v_val_nivel    atb_materiais_sla.val_nivel%Type;
	  v_qtd_horas    atb_materiais_sla.qtd_horas%Type;
	  v_nom_cor_html atb_materiais_sla.nom_cor_html%Type;
   
	  corpo Long;
   
   Begin
   
	  Select Count(*)
	  Into   v_aux
	  From   atb_materiais_sla_det
	  Where  sta_sla = 'P' And
			 p_dt_exec > dat_limite_sla;
   
	  If v_aux = 0 Then
		 -- Não Tem materiais criticos a serem enviados email
		 Raise e_saida;
	  
	  End If;
	  -- Inicio do processo de envio de email (SLA)
   
	  --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
	  -- Corpo email
	  --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
	  Begin
		 corpo := '<HTML>';
		 corpo := corpo || '<BODY>';
	  
		 corpo := corpo ||
				  '<div align="center"><img src = "C:\Desenv\Oracle\artbox\Imagens\logo_artbox.bmp" width = "100" height = "100"></div>';
		 corpo := corpo ||
				  '<h1 align = "center" ><b>Relação de Materiais com Estoque Abaixo do Mínimo</b></h1>';
	  
		 corpo := corpo || '<hr>';
	  
		 corpo := corpo || '<h3 ><b> Data      :</b>' ||
				  to_char(p_dt_exec, 'DD/MM/YYYY hh24:mi:ss') || '</h3>';
		 corpo := corpo || '<BR>';
		 corpo := corpo || '<hr>';
		 corpo := corpo || '<BR>';
		 corpo := corpo || '<BR>';
		 corpo := corpo || '<BR>';
	  
		 -- Relação de niveis de sla, vai trazer a cor produtos
	  
		 For i In (Select Distinct a.val_nivel, a.nom_titulo_tab sla, a.nom_cor_html
				   From   atb_materiais_sla a
				   Where  Exists (Select 1
						   From   atb_materiais_sla_det b
						   Where  a.val_nivel = b.val_nivel And
								  a.nom_cor_html = b.nom_cor_html And
								  b.sta_sla = 'P')
				   Order  By a.val_nivel, a.nom_cor_html) Loop
		 
			corpo := corpo || '<table border="6" bordercolor=' || i.nom_cor_html;
			corpo := corpo || ' cellspacing="5" ';
			corpo := corpo || ' cellpadding="5" ';
			corpo := corpo || ' align="center" ';
			corpo := corpo || ' width="600" ';
			corpo := corpo || ' bgcolor=Azure >';
		 
			v_tabela := v_tabela + 1;
		 
			corpo := corpo || '<caption align=bottom>  Tabela ' || v_tabela || '  </caption>';
		 
			corpo := corpo || '<th colspan="7" >' || i.sla || ' </th>';
		 
			--  <!-- Tr Table row (LINHA) -->
			--  <!-- Td Table data (CELULA) -->
			corpo := corpo || '<tr>';
			corpo := corpo || '<td width=50 align = center> Código</td>';
			corpo := corpo || '<td width=200 align = center> Material</td>';
			corpo := corpo || '<td width=100 align = center> Unidade medida</td>';
			corpo := corpo || '<td width=60 align = center> Qtde Mínima</td>';
			corpo := corpo || '<td width=60 align = center> Qtde máximo</td>';
			corpo := corpo || '<td width=60 align = center> Qtde Estoque</td>';
			corpo := corpo || '<td width=60 align = center> Valor</td>';
			corpo := corpo || '</tr>';
		 
			-- Montar tabela de Relação de materiais deste nivel e cor
			For j In (Select b.seq_material, b.dat_sla, a.seq_sla_det, a.val_nivel, a.dat_limite_sla,
							 nom_material, dm_unidade_medida aua_un, qtd_minimo, qtd_maximo,
							 qtd_estoque, val_estoque
					  From   atb_materiais_sla_det a, atb_materiais b
					  Where  a.seq_material = b.seq_material And
							 a.sta_sla = 'P' And
							 a.val_nivel = i.val_nivel And
							 a.nom_cor_html = i.nom_cor_html) Loop
			
			   corpo := corpo || '<tr height = 30>';
			   corpo := corpo || '<td width=50 align = center>' || j.seq_material || '</td>';
			   corpo := corpo || '<td width=200 align = center>' || j.nom_material || '</td>';
			   corpo := corpo || '<td width=60 align = center>' || j.aua_un || '</td>';
			   corpo := corpo || '<td width=60 align = center>' || j.qtd_minimo || '</td>';
			   corpo := corpo || '<td width=60 align = center>' || j.qtd_maximo || '</td>';
			   corpo := corpo || '<td width=60 align = center>' || j.qtd_estoque || '</td>';
			   corpo := corpo || '<td width=60 align = center>' || j.val_estoque || '</td>';
			
			   corpo := corpo || '</tr>';
			
			   v_data_sla    := to_char(j.dat_sla, 'DD/MM/YYYY HH24:MI:SS');
			   v_data_limite := to_char(j.dat_limite_sla, 'DD/MM/YYYY HH24:MI:SS');
			
			   -- Verifica nivel do SLA
			   If p_dt_exec > j.dat_limite_sla Then
			   
				  Begin
					 Begin
						-- Le proximo nivel se não existir usa o proprio (Ultimo SLA)
						Select val_nivel, qtd_horas, nom_cor_html
						Into   v_val_nivel, v_qtd_horas, v_nom_cor_html
						From   atb_materiais_sla,
							   (Select Min(val_nivel) prox_nivel
								 From   atb_materiais_sla
								 Where  seq_material = j.seq_material And
										(p_dt_exec - j.dat_sla) * 24 < qtd_horas) pr
						Where  seq_material = j.seq_material And
							   val_nivel = pr.prox_nivel;
					 
					 Exception
						When no_data_found Then
						   Select val_nivel, qtd_horas, nom_cor_html
						   Into   v_val_nivel, v_qtd_horas, v_nom_cor_html
						   From   atb_materiais_sla,
								  (Select Max(val_nivel) ult_nivel
									From   atb_materiais_sla
									Where  seq_material = j.seq_material) pr
						   Where  seq_material = j.seq_material And
								  val_nivel = pr.ult_nivel;
					 End;
				  
					 Update atb_materiais_sla_det
					 Set    sta_sla     = 'E',
							dat_emissao = Sysdate
					 Where  seq_sla_det = j.seq_sla_det;
				  
					 Insert Into atb_materiais_sla_det
						(seq_sla_det, seq_material, val_nivel, nom_cor_html, dat_limite_sla,
						 sta_sla, dat_emissao)
					 Values
						(Null, j.seq_material, v_val_nivel, v_nom_cor_html,
						 p_dt_exec + (v_qtd_horas / 24), 'P', Null);
				  
				  Exception
					 When Others Then
						raise_application_error(-20003, 'Erro ao selecionar próximo nivel');
				  End;
			   
			   Else
				  -- mantem o mesmo nivel 
			   
				  Begin
					 Update atb_materiais_sla_det
					 Set    sta_sla     = 'E',
							dat_emissao = Sysdate
					 Where  seq_sla_det = j.seq_sla_det;
				  
					 Insert Into atb_materiais_sla_det
						(seq_sla_det, seq_material, val_nivel, nom_cor_html, dat_limite_sla,
						 sta_sla, dat_emissao)
					 Values
						(Null, j.seq_material, j.val_nivel, i.nom_cor_html, j.dat_limite_sla, 'P',
						 Null);
				  Exception
					 When Others Then
						raise_application_error(-20003, 'Erro ao inserir mesmo nível');
				  End;
			   
			   End If;
			
			End Loop;
			corpo := corpo || '</table>';
			corpo := corpo || '<BR>  <BR><BR>     <BR>';
		 End Loop;
	  
		 corpo := corpo || '<BR>';
	  
		 corpo := corpo || '</BODY>';
		 corpo := corpo || '</HTML>';
	  
	  Exception
	  
		 When e_prox_nivel Then
			raise_application_error(-20017, 'Erro: Gerar próximo nível do e-mail ' || Sqlerrm);
		 
		 When Others Then
			raise_application_error(-20017, 'Erro: Gerar corpo do e-mail ' || Sqlerrm);
		 
	  End;
   
	  --Delete ab_email_sla_manual;
   
	  Insert Into atb_materiais_sla_email
		 (seq_email, dsc_assunto, dsc_corpo, sta_email)
	  Values
		 (Null, 'SLA', corpo, 'P');
   
	  Commit;
   
	  /*        ret_ := pkg_send_email.envia_email(p_origem,  p_destino, p_assunto, corpo_, p_arquivo, erro_);
      If Not ret_ Then
          raise_application_error(-20018,
                                  'Problema no envio de Emails.');
      End If;*/
   
   Exception
	  When e_saida Then
		 Null;
	  
   End prc_materiais_sla;

End pkg_materiais;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_jobs Is

  -- Author  : CARLOS
  -- Created : 13/01/2017 10:09:05
  -- Purpose : Administrar os JOBS do sistema Artbox

   Function fnc_cad_job
   (
	  p_seq_job In Number,
	  p_num_job  In Number,
	  p_dat_exec In Date
   ) Return Number Is
  
    v_seq_job_det Number := 0;
  
  Begin
  
    Select sq_atb_job_det.Nextval Into v_seq_job_det From dual;
  
  insert into atb_job_det
    (seq_job_det, seq_job, dat_cad, nom_usuario, num_job, dat_exec, dat_ini, dat_fim, sta_job)
  values
    (v_seq_job_det, p_seq_job, sysdate, user, p_num_job, nvl(p_dat_exec, sysdate), null, null, 'P');

    Commit;
  
    Return(v_seq_job_det);
  
  Exception
    When Others Then
      Return(0);
    
  End;
	
	   Procedure prc_ini_job(p_seq_job In Number) Is

   Begin

      Update atb_job_det
      Set    dat_ini = Sysdate, sta_job = 'E'
      Where  seq_job_det = p_seq_job;

      Commit;

   End;

   Procedure prc_fim_job(p_seq_job In Number) Is

   Begin

      Update atb_job_det
      Set    dat_fim = Sysdate, sta_job = 'F'
      Where  seq_job_det = p_seq_job;

      Commit;

   End;



End pkg_jobs;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_fornecedor Is

	-- Author  : CARLOS
	-- Created : 21/01/2021
	-- Purpose : Encapsular os métodos da tabela fornecedor

	Function fnc_digito_cpf_cnpj(p_cpf_cnpj   In Varchar2,
								 p_dv_calculo In Out Varchar2) Return Boolean Is
	
		--Declare
	
		cgc_cpf_temp Varchar2(18);
	
	Begin
		cgc_cpf_temp := Replace(p_cpf_cnpj, '.', Null);
		cgc_cpf_temp := Replace(cgc_cpf_temp, '-', Null);
		cgc_cpf_temp := Replace(cgc_cpf_temp, '/', Null);
		cgc_cpf_temp := Replace(cgc_cpf_temp, ',', Null);
		cgc_cpf_temp := Replace(cgc_cpf_temp, ';', Null);
	
		If p_cpf_cnpj Is Null Then
			Return(False);
		Elsif length(cgc_cpf_temp) > 14 Then
			Return(False);
		Elsif length(cgc_cpf_temp) > 11 Then
		
			-- CNPJ --
		
			Declare
				cgc_    Varchar2(14);
				digito_ Number;
				dig1_   Number;
				dig2_   Number;
				calc_   Number;
			Begin
				cgc_  := lpad(cgc_cpf_temp, 14, '0');
				calc_ := (to_number(substr(cgc_, 1, 1)) * 5) + (to_number(substr(cgc_, 2, 1)) * 4) +
						 (to_number(substr(cgc_, 3, 1)) * 3) + (to_number(substr(cgc_, 4, 1)) * 2) +
						 (to_number(substr(cgc_, 5, 1)) * 9) + (to_number(substr(cgc_, 6, 1)) * 8) +
						 (to_number(substr(cgc_, 7, 1)) * 7) + (to_number(substr(cgc_, 8, 1)) * 6) +
						 (to_number(substr(cgc_, 9, 1)) * 5) + (to_number(substr(cgc_, 10, 1)) * 4) +
						 (to_number(substr(cgc_, 11, 1)) * 3) + (to_number(substr(cgc_, 12, 1)) * 2);
				dig1_ := 11 - Mod(calc_, 11);
				If dig1_ > 9 Then
					dig1_ := 0;
				End If;
				calc_ := (to_number(substr(cgc_, 1, 1)) * 6) + (to_number(substr(cgc_, 2, 1)) * 5) +
						 (to_number(substr(cgc_, 3, 1)) * 4) + (to_number(substr(cgc_, 4, 1)) * 3) +
						 (to_number(substr(cgc_, 5, 1)) * 2) + (to_number(substr(cgc_, 6, 1)) * 9) +
						 (to_number(substr(cgc_, 7, 1)) * 8) + (to_number(substr(cgc_, 8, 1)) * 7) +
						 (to_number(substr(cgc_, 9, 1)) * 6) + (to_number(substr(cgc_, 10, 1)) * 5) +
						 (to_number(substr(cgc_, 11, 1)) * 4) + (to_number(substr(cgc_, 12, 1)) * 3);
				calc_ := calc_ + (dig1_ * 2);
				dig2_ := 11 - Mod(calc_, 11);
				If dig2_ > 9 Then
					dig2_ := 0;
				End If;
				digito_ := to_number(to_char(dig1_) || to_char(dig2_));
			
				------------------------
				-- VERIFICA DIGITO CGC
				------------------------
				If lpad(to_char(digito_), 2, '0') <> substr(lpad(cgc_cpf_temp, 14, '0'), 13, 2) Then
					p_dv_calculo := lpad(to_char(digito_), 2, '0');
					Return(False);
				Else
					p_dv_calculo := lpad(to_char(digito_), 2, '0');
					Return(True);
				End If;
			End;
		Else
			-- CPF
			Declare
				cpf_    Varchar2(11);
				digito_ Number;
				dig1_   Number;
				dig2_   Number;
				calc_   Number;
			Begin
				cpf_  := lpad(cgc_cpf_temp, 11, '0');
				calc_ := (to_number(substr(cpf_, 1, 1)) * 10) + (to_number(substr(cpf_, 2, 1)) * 9) +
						 (to_number(substr(cpf_, 3, 1)) * 8) + (to_number(substr(cpf_, 4, 1)) * 7) +
						 (to_number(substr(cpf_, 5, 1)) * 6) + (to_number(substr(cpf_, 6, 1)) * 5) +
						 (to_number(substr(cpf_, 7, 1)) * 4) + (to_number(substr(cpf_, 8, 1)) * 3) +
						 (to_number(substr(cpf_, 9, 1)) * 2);
				dig1_ := 11 - Mod(calc_, 11);
				If dig1_ > 9 Then
					dig1_ := 0;
				End If;
				calc_ := (to_number(substr(cpf_, 1, 1)) * 11) + (to_number(substr(cpf_, 2, 1)) * 10) +
						 (to_number(substr(cpf_, 3, 1)) * 9) + (to_number(substr(cpf_, 4, 1)) * 8) +
						 (to_number(substr(cpf_, 5, 1)) * 7) + (to_number(substr(cpf_, 6, 1)) * 6) +
						 (to_number(substr(cpf_, 7, 1)) * 5) + (to_number(substr(cpf_, 8, 1)) * 4) +
						 (to_number(substr(cpf_, 9, 1)) * 3);
				calc_ := calc_ + (dig1_ * 2);
				dig2_ := 11 - Mod(calc_, 11);
				If dig2_ > 9 Then
					dig2_ := 0;
				End If;
				digito_ := to_number(to_char(dig1_) || to_char(dig2_));
				-------------------------
				-- VERIFICA DIGITO CPF
				-------------------------
				If lpad(to_char(digito_), 2, '0') <> substr(lpad(cgc_cpf_temp, 11, '0'), 10, 2) Then
					p_dv_calculo := lpad(to_char(digito_), 2, '0');
					Return(False);
				Else
				
					--p_cpf_cnpj  := cgc_cpf_temp;
					p_dv_calculo := lpad(to_char(digito_), 2, '0');
					Return(True);
				End If;
			End;
		End If;
	Exception
		When Others Then
			Return(False);
	End;

	Function fnc_formata_cpf_cnpj(p_cpf_cnpj In Varchar2) Return Varchar2 Is
	
		v_cpf_cnpj Varchar2(18) := Null;
	
	Begin
	
		If length(p_cpf_cnpj) = 11 Then
			v_cpf_cnpj := substr(p_cpf_cnpj, 1, 3) || '.' || substr(p_cpf_cnpj, 4, 3) || '.' ||
						  substr(p_cpf_cnpj, 7, 3) || '-' || substr(p_cpf_cnpj, 10, 2);
		
		Elsif length(p_cpf_cnpj) = 14 Then
		
			v_cpf_cnpj := substr(p_cpf_cnpj, 1, 2) || '.' || substr(p_cpf_cnpj, 3, 3) || '.' ||
						  substr(p_cpf_cnpj, 6, 3) || '/' || substr(p_cpf_cnpj, 9, 4) || '-' ||
						  substr(p_cpf_cnpj, 13, 2);
		
		End If;
	
		Return(v_cpf_cnpj);
	
	End fnc_formata_cpf_cnpj;

End pkg_fornecedor;
/

SHOW ERRORS;


CREATE OR REPLACE Procedure teste Is

   v_ot_lancamentos ot_lancamentos;

   v_ot_lancamentos1 ot_lancamentos := ot_lancamentos(Null, Null, Null, Null, Null, Null, Null,
													  Null, Null, Null, Null, Null, Null, Null, Null);

   v_ot_lancamentos2 ot_lancamentos := ot_lancamentos(50);

   v_qtd_estoque    Number;
   v_val_estoque    Number;
   v_val_customedio Number;

Begin

   v_ot_lancamentos := New ot_lancamentos(50);

   v_qtd_estoque    := v_ot_lancamentos.qtd_estoque;
   v_val_estoque    := v_ot_lancamentos.val_estoque;
   v_val_customedio := v_ot_lancamentos.val_custo_medio;

   v_val_customedio := v_val_customedio;

   v_ot_lancamentos := New ot_lancamentos(Null, Null, Null, Null, Null, Null, Null, Null, Null,
										  Null, Null, Null, Null, Null, Null);

   v_ot_lancamentos.prc_associar_material(1, 11);

   /*  update atb_requisicoes_itens a
   set a.qtd_material = 23
   where a.num_requisicao = 14 and 
           a.num_item = 1;*/

End teste;
/

SHOW ERRORS;


CREATE OR REPLACE Procedure gerar_lancamntos Is

   --type de calculos dos lancamentos
   --v_ot_lancamentos ot_lancamentos;

   v_num_nota        atb_notas_ent.num_nota%Type;
   v_val_compra      atb_notas_ent.val_compra%Type;
   v_seq_item        atb_notas_ent_itens.seq_item%Type;
   v_qtd_item        atb_notas_ent_itens.qtd_item%Type;
   v_val_unitario    atb_notas_ent_itens.val_item%Type;
   v_val_item        atb_notas_ent_itens.val_item%Type;
   v_qtd_lancamentos Number(1);

   v_num_requisicao atb_requisicoes.num_requisicao%Type;
   v_qtd_material   atb_requisicoes_itens.qtd_material%Type;

   Cursor c_forn Is
	  Select seq_fornecedor
	  From   (Select *
			   From   artbox.atb_fornecedores
			   Order  By dbms_random.random)
	  Where  rownum <= v_qtd_lancamentos;

   Cursor c_itens Is
	  Select seq_material
	  From   (Select *
			   From   artbox.atb_materiais
			   Order  By dbms_random.random)
	  Where  rownum <= v_qtd_item;

Begin

   Select trunc(dbms_random.Value(1, 10)) num
   Into   v_qtd_lancamentos
   From   dual;

   For r_forn In c_forn Loop
   
	  v_num_nota := sq_atb_notas.Nextval;
	  -- Quantidade de Itens de 1 a 10 
	  Select trunc(dbms_random.Value(1, 10)) num
	  Into   v_qtd_item
	  From   dual;
   
	  -- Valor Unitário de 1 a 4
	  Select trunc(dbms_random.Value(1, 4)) num
	  Into   v_val_unitario
	  From   dual;
   
	  v_val_item   := v_qtd_item * v_val_unitario;
	  v_val_compra := v_val_item * v_qtd_item;
   
	  Insert Into atb_notas_ent
		 (seq_fornecedor, num_nota, dat_compra, val_compra, nom_usuario, sta_nota)
	  Values
		 (r_forn.seq_fornecedor, v_num_nota, Sysdate - 2, v_val_compra, 'ARTBOX', 'F');
   
	  v_seq_item := 0;
   
	  For r_itens In c_itens Loop
	  
		 -- v_ot_lancamentos := New ot_lancamentos(50, Sysdate - 2, 2);
	  
		 -- If v_ot_lancamentos.qtd_estoque >= 0 Then
	  
		 v_seq_item := v_seq_item + 1;
	  
		 Insert Into atb_notas_ent_itens
			(seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item)
		 Values
			(r_forn.seq_fornecedor, v_num_nota, v_seq_item, r_itens.seq_material, v_qtd_item,
			 v_val_item);
	  
	  -- End If;
	  
	  End Loop;
   
   End Loop;

   For i In 1 .. v_qtd_lancamentos Loop
   
	  v_num_requisicao := sq_atb_requisicoes.Nextval;
   
	  -- Quantidade de Itens de 1 a 10 
	  Select trunc(dbms_random.Value(1, 10)) num
	  Into   v_qtd_item
	  From   dual;
   
	  -- Valor Unitário de 1 a 4
	  Select trunc(dbms_random.Value(1, 4)) num
	  Into   v_val_unitario
	  From   dual;
   
	  v_seq_item     := 0;
	  v_qtd_material := v_qtd_item * v_val_unitario;
   
	  Insert Into atb_requisicoes
		 (num_requisicao, dsc_requisicao, dat_requisicao, nom_usuario, sta_requisicao)
	  Values
		 (v_num_requisicao, 'Lançamento aut.', Sysdate - 2, 'ARTBOX', 'F');
   
	  For r_itens In c_itens Loop
	  
		 -- v_ot_lancamentos := New ot_lancamentos(r_itens.seq_material, Sysdate - 2, 2);
	  
		 --If v_ot_lancamentos.qtd_estoque >= 0 Then
	  
		 v_seq_item := v_seq_item + 1;
	  
		 Begin
		 
			--Savepoint estoque_negativo;
			Insert Into atb_requisicoes_itens
			   (num_requisicao, num_item, seq_material, qtd_material, val_material)
			Values
			   (v_num_requisicao, v_seq_item, r_itens.seq_material, v_qtd_material, 0);
		 Exception
			When Others Then
			   v_seq_item := v_seq_item - 1;
			   --Rollback To estoque_negativo;
		 
		 End;
	  
	  -- End If;
	  
	  End Loop;
   
	  If v_seq_item = 0 Then
		 Delete atb_requisicoes
		 Where  num_requisicao = v_num_requisicao;
	  End If;
   
   End Loop;

End gerar_lancamntos;
/

SHOW ERRORS;


CREATE OR REPLACE VIEW VW_ENDERECOS
AS 
SELECT LG.SEQ_LOGRADOURO, LG.DMN_TPO_LOGRADOURO, LG.NOM_LOGRADOURO, LG.COD_CEP,
       BR.NOM_BAIRRO , CD.NOM_CIDADE,  CD.DMN_UF
    FROM PORTAL.LOGRADOURO LG,  PORTAL.BAIRRO BR,  PORTAL.CIDADE CD
   WHERE LG.SEQ_BAIRRO = BR.SEQ_BAIRRO AND
     LG.SEQ_CIDADE = CD.SEQ_CIDADE
		 WITH READ ONLY;


CREATE OR REPLACE TRIGGER TRG_ATB_FORNECEDOR_BIU
   BEFORE INSERT OR UPDATE ON ATB_FORNECEDORES
   FOR EACH ROW
BEGIN

	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 -- Sequência
	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 IF :NEW.SEQ_FORNECEDOR IS NULL THEN
			SELECT SQ_ATB_FORNECEDOR.NEXTVAL INTO :NEW.SEQ_FORNECEDOR FROM DUAL;
	 END IF;

EXCEPTION
	 WHEN OTHERS THEN
			RAISE_APPLICATION_ERROR(-20000, 'Erro ao inserir sequence. TRG_ATB_FORNECEDOR_BIU' || SQLERRM);
	 
END TRG_ATB_FORNECEDOR_BIU;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trg_atb_material_BIU
   Before Insert or update On ATB_MATERIAIS
   For Each Row
Begin

	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 -- Sequência
	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 If :New.seq_material Is Null Then
			Select sq_atb_material.Nextval Into :New.seq_material From dual;
	 End If;

	 :New.nom_usuario := upper(User);

Exception
	 When Others Then
			raise_application_error(-20000, 'Erro ao inserir sequence. TRG_PT_DOMINIOS_biu' || Sqlerrm);
	 
End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER ATB_JOB_DET_BI
   before insert on ATB_JOB_DET
   for each row
begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- recuperar sequence
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    if :new.SEQ_JOB_DET is null then
       select SQ_ATB_JOB_DET.nextval into :new.SEQ_JOB_DET
            from dual;
    end if;

end;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER ATB_JOB_bi
    before insert on ATB_JOB
    for each row
Begin

    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- recuperar sequence
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    If :New.SEQ_JOB Is Null Then
    Select SQ_ATB_JOB.Nextval
    Into   :New.SEQ_JOB
    From   dual;
    End If;

 End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trg_atb_clientes_biu
   Before Insert or update On atb_clientes
   For Each Row
Begin

	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 -- Sequência
	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 If :New.seq_cliente Is Null Then
			Select sq_atb_clientes.Nextval Into :New.seq_cliente From dual;
	 End If;

Exception
	 When Others Then
			raise_application_error(-20000, 'Erro ao inserir sequence. trg_atb_clientes_biu' || Sqlerrm);
	 
End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER ATB_SERVICOS_BI
 BEFORE INSERT
 ON ATB_SERVICOS
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
Begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Recuperar Sequence
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  If :New.SEQ_SERVICO Is Null Then
    Select SQ_ATB_SERVICOS.Nextval Into :New.SEQ_SERVICO From dual;
  End If;

End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trg_atb_produtos_BIU
   Before Insert or update On ATB_PRODUTOS
   For Each Row
Begin

	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 -- Sequência
	 --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	 If :New.seq_produto Is Null Then
			Select sq_atb_produtos.Nextval Into :New.seq_produto From dual;
	 End If;

	 :New.nom_usuario := upper(User);

Exception
	 When Others Then
			raise_application_error(-20000, 'Erro ao inserir sequence. trg_atb_produtos_BIU' || Sqlerrm);
	 
End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER atb_materiais_biu
   before Insert or update  of qtd_estoque,  qtd_minimo
	  On ATB_MATERIAIS
   For Each Row
Declare

   v_aux          Number := 0;
   v_val_nivel    atb_materiais_sla.val_nivel%Type;
   v_qtd_horas    atb_materiais_sla.qtd_horas%Type;
   v_nom_cor_html atb_materiais_sla.nom_cor_html%Type;

Begin

   -- Verificar se estoque esta abaixo do minimo
   If :New.qtd_estoque < :New.qtd_minimo And
	  :New.dat_sla Is Null Then
   
	  :New.dat_sla := Sysdate;
   
	  -- Incluir material em lista de pendencia
	  Select val_nivel, qtd_horas, nom_cor_html
	  Into   v_val_nivel, v_qtd_horas, v_nom_cor_html
	  From   atb_materiais_sla a
	  Where  a.seq_material = :New.seq_material And
			 val_nivel = (Select Min(val_nivel) minimo
						  From   atb_materiais_sla b
						  Where  a.seq_material = b.seq_material);
   
	  Insert Into atb_materiais_sla_det
		 (seq_sla_det, seq_material, val_nivel, nom_cor_html, dat_LIMITE_SLA, sta_sla)
	  Values
		 (Null, :New.seq_material, v_val_nivel, v_nom_cor_html, Sysdate + (v_qtd_horas / 24), 'P');
   
	  -- Estoque acima do minimo
   Elsif :New.qtd_estoque >= :New.qtd_minimo And
		 :New.dat_sla Is Not Null Then
   
	  :New.dat_sla := null;
   
	  -- Ver se material já esta em SLA
	  Select Count(*)
	  Into   v_aux
	  From   atb_materiais_sla_det
	  Where  seq_material = :New.seq_material And
			 sta_sla = 'P';
   
	  If v_aux > 0 Then
	  
		 -- Retirar material de lista de pendencias
	  
		 Update atb_materiais_sla_det
		 Set    sta_sla = 'C'
		 Where  seq_material = :New.seq_material And
				sta_sla = 'P';
	  
	  End If;
   
   End If;

End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trg_ATB_FORNECEDOR_MAT_biu
   before insert or update on ATB_FORNECEDORES_MAT
   for each row
declare
	 
	 v_dat_cadastro		atb_materiais.dat_cadastro%type;

Begin

	Select dat_cadastro
	  Into v_dat_cadastro
	  From atb_materiais
	 Where seq_material = :New.seq_material;

	--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	-- Verificar se data de Associação é maior que a data de cadastro
	--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	If :New.dat_cadastro < v_dat_cadastro Then
		raise_application_error (-20001, 'Atenção Data de associação menor que data de cadastro do Material!');
	End If;

	
End trg_atb_fornecedor_biu;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER ATB_MATERIAIS_SLA_DET_BI
 BEFORE INSERT
 ON ATB_MATERIAIS_SLA_DET
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
Begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Recuperar Sequence
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  If :New.SEQ_SLA_DET Is Null Then
    Select SQ_ATB_MATERIAL_SLA_DET.Nextval Into :New.SEQ_SLA_DET From dual;
  End If;

End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER ATB_MATERIAIS_SLA_EMAIL_bi
   before insert on ATB_MATERIAIS_SLA_EMAIL
   for each row
begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Recuperar Sequence
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

    if :new.SEQ_EMAIL is null then
       select SQ_ATB_MATERIAL_SLA_EMAIL.nextval into :new.SEQ_EMAIL
            from dual;
    end if;

End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trg_atb_nota_entrada_item_biu
   before insert or update on ATB_NOTAS_ENT_ITENS
   for each row
declare
	 
	 v_dat_cadastro		atb_materiais.dat_cadastro%type;
	 v_dat_compra		atb_notas_ent.dat_compra%type;

Begin
	-- Le data de cadastro do material
	Select dat_cadastro
	  Into v_dat_cadastro
	  From atb_materiais
	 Where seq_material = :New.seq_material;
	 
	 -- Le a data da compra do material
	  select ne.dat_compra into v_dat_compra
	   from atb_notas_ent ne
	   where ne.seq_fornecedor = :new.seq_fornecedor
	   and ne.num_nota = :new.num_nota;
	 
	 

	--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	-- Verificar se data de Compra  é maior que a data de cadastro
	--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	If v_dat_compra < v_dat_cadastro Then
		raise_application_error (-20001, 'Atenção Data de Compra menor que data de cadastro do Material!');
	End If;

	
End trg_atb_fornecedor_biu;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER TRG_ATB_REQUISICOES_ITENS_AIU
   After insert or update on ATB_REQUISICOES_ITENS
   for each row
Declare

   v_dat_lancamento atb_notas_ent.dat_compra%Type;

   v_ot_lanamentos ot_lancamentos;

Begin

   Select re.dat_requisicao
   Into   v_dat_lancamento
   From   atb_requisicoes re
   Where  num_requisicao = :New.num_requisicao;

   If inserting Then
   
	  Insert Into atb_lancamentos
		 (seq_lancamento, seq_material, dat_lancamento, tpo_lancamento, qtd_lancamento,
		  val_lancamento, qtd_estoque, val_estoque, val_custo_medio, num_requisicao, num_item,
		  seq_fornecedor, num_nota, seq_item)
	  Values
		 (sq_atb_lancamentos.Nextval, :New.seq_material, v_dat_lancamento, 'S', :New.qtd_material,
		  :New.val_material, 0, 0, 0, :New.num_requisicao, :New.num_item, Null, Null, Null);
   End If;

   If updating Then
	  If :Old.qtd_material <> :New.qtd_material Or
		 :Old.val_material <> :New.val_material Then
		 Update atb_lancamentos
		 Set    qtd_lancamento = :New.qtd_material,
				val_lancamento = :New.val_material
		 Where  num_requisicao = :New.num_requisicao And
				num_item = :New.num_item;
	  End If;
   End If;

   Begin
	  -- Call the procedure
	  pkg_materiais.prc_calc_estoque(p_seq_material => :New.seq_material,
									 p_dat_lancamento => v_dat_lancamento);
   Exception
	  When Others Then
		 raise_application_error(-20003,
								 'Erro ao calcular saldo do Material: ' || :New.qtd_material);
   End;

   v_ot_lanamentos := New ot_lancamentos(:New.seq_material, v_dat_lancamento, 2);
   If v_ot_lanamentos.qtd_estoque < 0 Then
	  raise_application_error(-20201, 'Erro: Saldo Negativo para este Material');
   End If;

End trg_atb_requisicoes_itens_aiu;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER TRG_ATB_REQUISICOES_ITENS_BI
   before insert on ATB_REQUISICOES_ITENS
   for each row
Declare

   --type de calculos dos lancamentos
   v_ot_lancamentos ot_lancamentos;

Begin

   v_ot_lancamentos := New ot_lancamentos(:New.seq_material);

   -- If v_ot_lancamentos.qtd_estoque >= 0 Then
   :New.val_material := v_ot_lancamentos.val_custo_medio * :New.qtd_material;

End trg_atb_requisicoes_itens_aiu;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER TRG_ATB_NOTAS_ENT_ITENS_AIU
   after insert or update on ATB_NOTAS_ENT_ITENS
   for each row
Declare

   v_dat_lancamento atb_notas_ent.dat_compra%Type;

Begin

   Select ne.dat_compra
   Into   v_dat_lancamento
   From   atb_notas_ent ne
   Where  seq_fornecedor = :New.seq_fornecedor And
		  num_nota = :New.num_nota;

   If inserting Then
	  Insert Into atb_lancamentos
		 (seq_lancamento, seq_material, dat_lancamento, tpo_lancamento, qtd_lancamento,
		  val_lancamento, qtd_estoque, val_estoque, val_custo_medio, num_requisicao, num_item,
		  seq_fornecedor, num_nota, seq_item)
	  Values
		 (sq_atb_lancamentos.Nextval, :New.seq_material, v_dat_lancamento, 'E', :New.qtd_item,
		  :New.val_item, 0, 0, 0, Null, Null, :New.seq_fornecedor, :New.num_nota, :New.seq_item);
   End If;

   If updating Then
	  If :Old.qtd_item <> :New.qtd_item Or
		 :Old.val_item <> :New.val_item Then
		 Update atb_lancamentos
		 Set    qtd_lancamento = :New.qtd_item,
				val_lancamento = :New.val_item
		 Where  seq_fornecedor = :New.seq_fornecedor And
				num_nota = :New.num_nota And
				seq_item = :New.seq_item;
	  End If;
   End If;
   
   Begin
	  -- Call the procedure
	  pkg_materiais.prc_calc_estoque(p_seq_material => :New.seq_material,
									 p_dat_lancamento => v_dat_lancamento);
   Exception
	  When Others Then
		 raise_application_error(-20003,
								 'Erro ao recalcular Material: ' || :New.seq_material);
   End;   
   

End TRG_ATB_NOTAS_ENT_ITENS_AIU;
/
SHOW ERRORS;



ALTER TABLE ATB_NOTAS_ENT ADD (
  CONSTRAINT ATB_NOTA_ENTRADA_CK01
 CHECK (sta_nota in ('A', 'F')),
  CONSTRAINT ATB_NOTA_ENTRADA_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, NUM_NOTA));

ALTER TABLE ATB_REQUISICOES_ITENS ADD (
  CONSTRAINT ATB_REQUISICAO_ITEM_PK
 PRIMARY KEY
 (NUM_REQUISICAO, NUM_ITEM));

ALTER TABLE ATB_MATERIAIS_SLA ADD (
  CONSTRAINT ATB_MATERIAL_SLA_PK
 PRIMARY KEY
 (SEQ_MATERIAL, VAL_NIVEL));

ALTER TABLE ATB_MATERIAIS_SLA_DET ADD (
  CONSTRAINT ATB_MATERIAL_SLA_DET_CK01
 CHECK ("STA_SLA"='P' OR "STA_SLA"='E' OR "STA_SLA"='C'),
  CONSTRAINT ATB_MATERIAL_SLA_DET_PK
 PRIMARY KEY
 (SEQ_SLA_DET));

ALTER TABLE ATB_SERVICOS_TARIFAS ADD (
  CONSTRAINT ATB_SERVICOS_TAR_PK
 PRIMARY KEY
 (SEQ_SERVICO, DAT_VIGENCIA));

ALTER TABLE ATB_LANCAMENTOS ADD (
  CONSTRAINT ATB_LANCAMENTOS_PK
 PRIMARY KEY
 (SEQ_LANCAMENTO));

ALTER TABLE ATB_REQUISICOES ADD (
  CONSTRAINT ATB_REQUISICAO_CK01
 CHECK (STA_REQUISICAO in ('A', 'F')),
  CONSTRAINT ATB_REQUISICAO_PK
 PRIMARY KEY
 (NUM_REQUISICAO));

ALTER TABLE ATB_PRODUTOS_MAT ADD (
  CONSTRAINT ATB_PRODUTOS_MAT_PK
 PRIMARY KEY
 (SEQ_PRODUTO, SEQ_MATERIAL));

ALTER TABLE ATB_MATERIAIS_SALDOS ADD (
  CONSTRAINT ATB_MATERIAL_SALDOS_PK
 PRIMARY KEY
 (SEQ_MATERIAL, DAT_REFERENCIA));

ALTER TABLE ATB_FORNECEDORES_ENDERECO ADD (
  CONSTRAINT FORNECEDOR_ENDERECO_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, DM_TPO_ENDERECO));

ALTER TABLE ATB_PRODUTOS_SERV ADD (
  CONSTRAINT ATB_PRODUTOS_SERV_PK
 PRIMARY KEY
 (SEQ_PRODUTO, SEQ_SERVICO));

ALTER TABLE ATB_JOB ADD (
  CONSTRAINT ATB_JOB_PK
 PRIMARY KEY
 (SEQ_JOB));

ALTER TABLE ATB_MATERIAIS ADD (
  CONSTRAINT ATB_MATERIAL_CK01
 CHECK (DMN_FL_BLOQ in ('S', 'N')),
  CONSTRAINT MATERIAL_PK
 PRIMARY KEY
 (SEQ_MATERIAL));

ALTER TABLE ATB_MATERIAIS_SLA_EMAIL ADD (
  CONSTRAINT ATB_MATERIAL_SLA_EMAIL_PK
 PRIMARY KEY
 (SEQ_EMAIL));

ALTER TABLE ATB_PRODUTOS ADD (
  CONSTRAINT DMN_FL_BLOQ_CK01
 CHECK (dmn_fl_bloq in ('S', 'N')),
  CONSTRAINT PRODUTOS_PK
 PRIMARY KEY
 (SEQ_PRODUTO));

ALTER TABLE ATB_CLIENTES ADD (
  CONSTRAINT ATB_CLIENTES_CK01
 CHECK (DM_FL_BLOQ IN ('N', 'S')),
  CONSTRAINT ATB_CLIENTES_PK
 PRIMARY KEY
 (SEQ_CLIENTE));

ALTER TABLE ATB_FORNECEDORES ADD (
  CONSTRAINT FORNECEDOR_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR));

ALTER TABLE ATB_JOB_DET ADD (
  CONSTRAINT ATB_JOB_DET_CK01
 CHECK (STA_JOB in ('P', 'E', 'C', 'F')),
  CONSTRAINT ATB_JOB_DET_PK
 PRIMARY KEY
 (SEQ_JOB_DET));

ALTER TABLE ATB_CLIENTES_ENDERECOS ADD (
  CONSTRAINT ATB_CLIENTES_END_PK
 PRIMARY KEY
 (SEQ_CLIENTE, DM_TPO_ENDERECO));

ALTER TABLE ATB_NOTAS_ENT_ITENS ADD (
  CONSTRAINT ATB_NFE_ITEM_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, NUM_NOTA, SEQ_ITEM));

ALTER TABLE ATB_FORNECEDORES_MAT ADD (
  CONSTRAINT FORNECEDOR_MAT_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, SEQ_MATERIAL));

ALTER TABLE ATB_SERVICOS ADD (
  CONSTRAINT ATB_PRODUTOS_MAT_CK01
 CHECK (dmn_fl_bloq in ('S', 'N')),
  CONSTRAINT ATB_SERVICOS_PK
 PRIMARY KEY
 (SEQ_SERVICO));

ALTER TABLE ATB_NOTAS_ENT ADD (
  CONSTRAINT ANA_FRN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR) 
 REFERENCES);

ALTER TABLE ATB_REQUISICOES_ITENS ADD (
  CONSTRAINT ARM_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES,
  CONSTRAINT ARM_ARO_FK 
 FOREIGN KEY (NUM_REQUISICAO) 
 REFERENCES 
    ON DELETE CASCADE);

ALTER TABLE ATB_MATERIAIS_SLA ADD (
  CONSTRAINT ATB_MATERIAL_SLA_FK01 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES 
    ON DELETE CASCADE);

ALTER TABLE ATB_MATERIAIS_SLA_DET ADD (
  CONSTRAINT ATB_MATERIAL_SLA_DET_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES,
  CONSTRAINT ATB_MATERIAL_SLA_DET_FK01 
 FOREIGN KEY (SEQ_MATERIAL, VAL_NIVEL) 
 REFERENCES);

ALTER TABLE ATB_SERVICOS_TARIFAS ADD (
  CONSTRAINT ATB_SERVICOS_TAR_FK01 
 FOREIGN KEY (SEQ_SERVICO) 
 REFERENCES);

ALTER TABLE ATB_LANCAMENTOS ADD (
  CONSTRAINT ALO_ANN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR, NUM_NOTA, SEQ_ITEM) 
 REFERENCES 
    ON DELETE CASCADE,
  CONSTRAINT ATB_LANCAMENTOS_FK01 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES,
  CONSTRAINT ALO_ARN_FK 
 FOREIGN KEY (NUM_REQUISICAO, NUM_ITEM) 
 REFERENCES 
    ON DELETE CASCADE);

ALTER TABLE ATB_PRODUTOS_MAT ADD (
  CONSTRAINT ATB_PRODUTOS_MAT_FK01 
 FOREIGN KEY (SEQ_PRODUTO) 
 REFERENCES,
  CONSTRAINT ATB_PRODUTOS_MAT_FK02 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_MATERIAIS_SALDOS ADD (
  CONSTRAINT AMO_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_FORNECEDORES_ENDERECO ADD (
  CONSTRAINT FEO_FRN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR) 
 REFERENCES 
    ON DELETE CASCADE);

ALTER TABLE ATB_PRODUTOS_SERV ADD (
  CONSTRAINT APO_ASO_FK 
 FOREIGN KEY (SEQ_SERVICO) 
 REFERENCES,
  CONSTRAINT ATB_PRODUTOS_SERV_FK01 
 FOREIGN KEY (SEQ_PRODUTO) 
 REFERENCES);

ALTER TABLE ATB_JOB_DET ADD (
  CONSTRAINT ATB_JOB_DET_FK 
 FOREIGN KEY (SEQ_JOB) 
 REFERENCES);

ALTER TABLE ATB_CLIENTES_ENDERECOS ADD (
  CONSTRAINT ACO_ACE_FK 
 FOREIGN KEY (SEQ_CLIENTE) 
 REFERENCES 
    ON DELETE CASCADE);

ALTER TABLE ATB_NOTAS_ENT_ITENS ADD (
  CONSTRAINT ANM_ANA_FK 
 FOREIGN KEY (SEQ_FORNECEDOR, NUM_NOTA) 
 REFERENCES,
  CONSTRAINT ANM_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_FORNECEDORES_MAT ADD (
  CONSTRAINT FML_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES,
  CONSTRAINT FML_FRN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR) 
 REFERENCES);

