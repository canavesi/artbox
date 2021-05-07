--
-- Create Schema Script 
--   Database Version   : 11.2.0.1.0 
--   TOAD Version       : 9.0.1.8 
--   DB Connect String  : TESTE 
--   Schema             : ARTBOX 
--   Script Created by  : ARTBOX 
--   Script Created at  : 07/05/2021 17:03:56 
--   Physical Location  :  
--   Notes              :  
--

-- Object Counts: 
--   Indexes: 22        Columns: 34         
--   Packages: 4        Lines of Code: 90 
--   Package Bodies: 4  Lines of Code: 880 
--   Procedures: 1      Lines of Code: 27 
--   Sequences: 12 
--   Tables: 21         Columns: 123        Constraints: 48     
--   Triggers: 11 
--   Views: 2           


CREATE SEQUENCE SQ_ATB_CLIENTE
  START WITH 0
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_FORNECEDOR
  START WITH 9
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
  START WITH 34
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_LANCAMENTOS
  START WITH 81
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_MATERIAL
  START WITH 8
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_MATERIAL_SLA_DET
  START WITH 285
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_ATB_MATERIAL_SLA_EMAIL
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


CREATE SEQUENCE SQ_ATB_SERVICOS
  START WITH 6
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE TABLE ATB_CLIENTES
(
  SEQ_CLIENTE     NUMBER(8)                     NOT NULL,
  CG_TPO_PESSOA   VARCHAR2(1 BYTE)              NOT NULL,
  NUM_CPF         VARCHAR2(11 BYTE),
  NUM_CNPJ        VARCHAR2(14 BYTE),
  NOM_CLIENTE     VARCHAR2(40 BYTE)             NOT NULL,
  NOM_FANTASIA    VARCHAR2(25 BYTE),
  CG_TPO_CLIENTE  NUMBER(1),
  DM_FL_BLOQ      VARCHAR2(1 BYTE)              DEFAULT 'N'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_CLIENTES_ENDERECOS
(
  SEQ_CLIENTE      NUMBER                       NOT NULL,
  CG_TPO_ENDERECO  NUMBER(1)                    NOT NULL,
  SEQ_LOGRADOURO   NUMBER                       NOT NULL,
  NUM_ENDERECO     NUMBER                       NOT NULL,
  NOM_COMPLEMENTO  VARCHAR2(25 BYTE),
  ACE_SEQ_CLIENTE  NUMBER(8)                    NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_PRODUTOS_SERVICOS
(
  SEQ_PRODUTO  NUMBER(10)                       NOT NULL,
  SEQ_SERVICO  NUMBER(10)                       NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_NOTA_ENTRADA
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


CREATE TABLE ATB_REQUISICAO_ITEM
(
  NUM_REQUISICAO  NUMBER(7)                     NOT NULL,
  NUM_ITEM        NUMBER(5)                     NOT NULL,
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  QTD_MATERIAL    NUMBER(7,2)                   NOT NULL,
  VAL_MATERIAL    NUMBER(7,2)                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_MATERIAL_SLA
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


CREATE TABLE ATB_MATERIAL_SLA_DET
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

COMMENT ON COLUMN ATB_MATERIAL_SLA_DET.STA_SLA IS 'P-Pendente, E-Enviado, C-Cancelado';


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


CREATE TABLE ATB_MATERIAL
(
  SEQ_MATERIAL       NUMBER(10)                 NOT NULL,
  NOM_MATERIAL       VARCHAR2(40 BYTE)          NOT NULL,
  DM_UNIDADE_MEDIDA  VARCHAR2(2 BYTE)           NOT NULL,
  QTD_MINIMO         NUMBER(7,2)                NOT NULL,
  QTD_MAXIMO         NUMBER(7,2)                NOT NULL,
  QTD_ESTOQUE        NUMBER(7,2),
  VAL_ESTOQUE        NUMBER(10,2),
  VAL_UNITARIO       NUMBER(7,2),
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


CREATE TABLE ATB_REQUISICAO
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


CREATE TABLE ATB_MATERIAL_SLA_EMAIL
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

COMMENT ON COLUMN ATB_MATERIAL_SLA_EMAIL.STA_EMAIL IS 'P-Pendente, E-Enviado,  C-Cancelado';


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


CREATE TABLE ATB_PRODUTOS_MATERIAIS
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


CREATE TABLE ATB_FORNECEDOR
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


CREATE TABLE ATB_MATERIAL_SALDOS
(
  SEQ_MATERIAL    NUMBER(10)                    NOT NULL,
  DAT_REFERENCIA  DATE                          NOT NULL,
  QTD_SALDO       NUMBER(10,2)                  NOT NULL,
  VAL_SALDO       NUMBER(10,2)                  NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE ATB_FORNECEDOR_ENDERECO
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


CREATE TABLE ATB_NOTA_ENTRADA_ITEM
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


CREATE TABLE ATB_FORNECEDOR_MATERIAL
(
  SEQ_FORNECEDOR     NUMBER(9)                  NOT NULL,
  SEQ_MATERIAL       NUMBER(10)                 NOT NULL,
  DAT_CADASTRO       DATE                       NOT NULL,
  NOM_USUARIO        VARCHAR2(20 BYTE)          NOT NULL,
  QTD_MAXIMA_COMPRA  NUMBER(5,2)                NOT NULL,
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


CREATE UNIQUE INDEX ATB_MATERIAL_SLA_EMAIL_PK ON ATB_MATERIAL_SLA_EMAIL
(SEQ_EMAIL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_MATERIAL_SLA_PK ON ATB_MATERIAL_SLA
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


CREATE UNIQUE INDEX ATB_MATERIAL_SLA_DET_PK ON ATB_MATERIAL_SLA_DET
(SEQ_SLA_DET)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_CLIENTES_END_PK ON ATB_CLIENTES_ENDERECOS
(SEQ_CLIENTE, CG_TPO_ENDERECO)
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


CREATE UNIQUE INDEX ATB_MATERIAL_SALDOS_PK ON ATB_MATERIAL_SALDOS
(SEQ_MATERIAL, DAT_REFERENCIA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PRODUTOS_PK ON ATB_PRODUTOS
(SEQ_PRODUTO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_PRODUTOS_SERV_PK ON ATB_PRODUTOS_SERVICOS
(SEQ_PRODUTO, SEQ_SERVICO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_PRODUTOS_MAT_PK ON ATB_PRODUTOS_MATERIAIS
(SEQ_PRODUTO, SEQ_MATERIAL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_SERVICOS_TAR_PK ON ATB_SERVICOS_TARIFAS
(SEQ_SERVICO, DAT_VIGENCIA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FORNECEDOR_MAT_PK ON ATB_FORNECEDOR_MATERIAL
(SEQ_FORNECEDOR, SEQ_MATERIAL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FORNECEDOR_PK ON ATB_FORNECEDOR
(SEQ_FORNECEDOR)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX MATERIAL_PK ON ATB_MATERIAL
(SEQ_MATERIAL)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_REQUISICAO_PK ON ATB_REQUISICAO
(NUM_REQUISICAO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_NFE_ITEM_PK ON ATB_NOTA_ENTRADA_ITEM
(SEQ_FORNECEDOR, NUM_NOTA, SEQ_ITEM)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_NOTA_ENTRADA_PK ON ATB_NOTA_ENTRADA
(SEQ_FORNECEDOR, NUM_NOTA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_REQUISICAO_ITEM_PK ON ATB_REQUISICAO_ITEM
(NUM_REQUISICAO, NUM_ITEM)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX ATB_FORNECEDOR_UK01 ON ATB_FORNECEDOR
(NUM_CNPJ)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FORNECEDOR_ENDERECO_PK ON ATB_FORNECEDOR_ENDERECO
(SEQ_FORNECEDOR, DM_TPO_ENDERECO)
LOGGING
NOPARALLEL;


CREATE OR REPLACE Package pkg_nota_entrada Is

   -- Author  : CARLOS
   -- Created : 05/02/2021
   -- Purpose : Encapsular os métodos da tabela NOTA_ENTRADA

   Procedure prc_acerta_item
   (
	  p_seq_fornecedor In atb_nota_entrada.seq_fornecedor%Type,
	  p_num_nota       In atb_nota_entrada.num_nota%Type
   );

   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_nota_entrada.seq_fornecedor%Type,
	  p_num_nota       In atb_nota_entrada.num_nota%Type
   );

End pkg_nota_entrada;
/

SHOW ERRORS;


CREATE OR REPLACE Package pkg_material Is

   -- Author  : CARLOS
   -- Created : 04/02/2021 16:21:11
   -- Purpose : Encapsular os métodos da tabel ATB_MATRIAL

   Procedure prc_associar_material
   (
	  p_seq_fornecedor    In atb_fornecedor.seq_fornecedor%Type,
	  p_seq_material      In atb_material.seq_material%Type,
	  p_qtd_maxima_compra In atb_fornecedor_material.qtd_maxima_compra%Type,
	  p_val_preco_maximo  In atb_fornecedor_material.val_preco_maximo%Type
   );

   Procedure prc_calc_estoque
   (
	  p_seq_material   In atb_material.seq_material%Type,
	  p_dat_lancamento In atb_nota_entrada.dat_compra%Type
   );

   Function fnc_rec_valores
   (
	  p_seq_material   In atb_material.seq_material%Type,
	  p_dat_lancamento In atb_nota_entrada.dat_compra%Type,
	  p_tpo_valor      In Number
   ) Return Number;

   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_nota_entrada.seq_fornecedor%Type,
	  p_num_nota       In atb_nota_entrada.num_nota%Type
   );

   Procedure prc_fecha_requisicao(p_num_requisicao In atb_requisicao.num_requisicao%Type);

   Procedure prc_fechamento_estoque(p_dat_lancamento In atb_nota_entrada.dat_compra%Type);

   Procedure prc_materiais_sla(p_dt_exec In Date);

End pkg_material;
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
	  p_seq_fornecedor In atb_nota_entrada.seq_fornecedor%Type,
	  p_num_nota       In atb_nota_entrada.num_nota%Type
   ) Is
   
	  v_seq_item atb_nota_entrada_item.seq_item%Type;
   
	  Type rg_item Is Record(
		 seq_item     Number(3),
		 seq_material Number(10),
		 qtd_item     Number(5, 2),
		 val_item     Number(10, 2));
	  Type tb_item Is Table Of rg_item Index By Binary_Integer;
	  v_itens tb_item;
   
	  Cursor c_item Is
		 Select seq_item, seq_material, qtd_item, val_item
		 From   atb_nota_entrada_item
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
   
	  Delete atb_nota_entrada_item
	  Where  seq_fornecedor = p_seq_fornecedor And
			 num_nota = p_num_nota;
   
	  For vetor In v_itens.First .. v_itens.Count Loop
		 Insert Into atb_nota_entrada_item
			(seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item)
		 Values
			(p_seq_fornecedor, p_num_nota, vetor, v_itens(vetor).seq_material,
			 v_itens(vetor).qtd_item, v_itens(vetor).val_item);
	  
	  End Loop;
   
	  Commit;
   
   End;

   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_nota_entrada.seq_fornecedor%Type,
	  p_num_nota       In atb_nota_entrada.num_nota%Type
   ) Is
   
	  v_dat_compra atb_nota_entrada.dat_compra%Type;
	  v_val_compra atb_nota_entrada.val_compra%Type;
	  v_sta_nota   atb_nota_entrada.sta_nota%Type;
   
	  Cursor c_itens Is
		 Select seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item
		 From   atb_nota_entrada_item
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota
		 Order  By seq_item;
   
   Begin
   
	  Begin
		 Select dat_compra, val_compra, sta_nota
		 Into   v_dat_compra, v_val_compra, v_sta_nota
		 From   atb_nota_entrada
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota;
	  
	  Exception
		 When Others Then
			raise_application_error(-20101,
									'Erro ao selecionar nota de entrada: ' || p_num_nota);
	  End;
   
	  For rec In c_itens Loop
	  
		 Begin
			pkg_material.prc_calc_estoque(p_seq_material => rec.seq_material,
										  p_dat_lancamento => v_dat_compra);
		 Exception
			When Others Then
			   raise_application_error(-20102, 'Erro ao calcular saldos: ' || rec.seq_material);
		 End;
	  
	  End Loop;
   
	  Update atb_nota_entrada
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


CREATE OR REPLACE Package Body pkg_material Is

   -- Author  : CARLOS
   -- Created : 04/02/2021 16:21:11
   -- Purpose : Encapsular os métodos da tabel ATB_MATRIAL

   Procedure prc_associar_material
   (
	  p_seq_fornecedor    In atb_fornecedor.seq_fornecedor%Type,
	  p_seq_material      In atb_material.seq_material%Type,
	  p_qtd_maxima_compra In atb_fornecedor_material.qtd_maxima_compra%Type,
	  p_val_preco_maximo  In atb_fornecedor_material.val_preco_maximo%Type
   ) Is
   Begin
	  Insert Into atb_fornecedor_material
		 (seq_fornecedor, seq_material, dat_cadastro, nom_usuario, qtd_maxima_compra,
		  val_preco_maximo)
	  Values
		 (p_seq_fornecedor, p_seq_material, Sysdate, User, nvl(p_qtd_maxima_compra, 1),
		  nvl(p_val_preco_maximo, 1));
   
	  Commit;
   
   Exception
	  When dup_val_on_index Then
		 raise_application_error(-20001, 'Material já associado!');
	  
   End prc_associar_material;

   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   -- Recalcula custo médio e saldos mensais do material
   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   Procedure prc_calc_estoque
   (
	  p_seq_material   In atb_material.seq_material%Type,
	  p_dat_lancamento In atb_nota_entrada.dat_compra%Type
   ) Is
   
	  v_custo_medio    Number;
	  v_dat_referencia atb_material_saldos.dat_referencia%Type;
	  v_qtd_saldo      atb_material_saldos.qtd_saldo%Type;
	  v_val_saldo      atb_material_saldos.val_saldo%Type;
   
	  Cursor c_lcto Is
		 Select seq_material, dat_lancto, tpo_lancto, qtd_lancto, val_lancto, num_requisicao,
				num_item
		 From   atb_vw_lancamentos
		 Where  seq_material = p_seq_material And
				dat_lancto > v_dat_referencia
		 Order  By dat_lancto, decode(tpo_lancto, 'E', 1, 2);
   
   Begin
   
	  Begin
		 -- Seleciona o ultimo mes ref (ultimo dia do mes)
		 Select dat_referencia, qtd_saldo, val_saldo
		 Into   v_dat_referencia, v_qtd_saldo, v_val_saldo
		 From   atb_material_saldos sl,
				(Select Max(dat_referencia) maximo
				  From   atb_material_saldos
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
			Insert Into atb_material_saldos
			   (seq_material, dat_referencia, qtd_saldo, val_saldo)
			Values
			   (p_seq_material, v_dat_referencia, 0, 0);
			v_custo_medio := 0;
		 
		 When Others Then
			Rollback;
			raise_application_error(-20001, 'Erro ao selcionar saldo inicial ' || Sqlerrm);
	  End;
   
	  For r_lcto In c_lcto Loop
	  
		 If months_between(r_lcto.dat_lancto, v_dat_referencia) > 1 Then
			While months_between(r_lcto.dat_lancto, v_dat_referencia) > 1 Loop
			   v_dat_referencia := last_day(add_months(v_dat_referencia, 1));
			   Delete atb_material_saldos
			   Where  seq_material = p_seq_material And
					  dat_referencia = v_dat_referencia;
			   Insert Into atb_material_saldos
				  (seq_material, dat_referencia, qtd_saldo, val_saldo)
			   Values
				  (p_seq_material, v_dat_referencia, v_qtd_saldo, v_val_saldo);
			
			End Loop;
		 
		 End If;
	  
		 -- Entrada altera CUSTO MÉDIO
		 If r_lcto.tpo_lancto = 'E' Then
		 
			v_qtd_saldo   := nvl(v_qtd_saldo, 0) + r_lcto.qtd_lancto;
			v_val_saldo   := nvl(v_val_saldo, 0) + r_lcto.val_lancto;
			v_custo_medio := 0;
			If v_val_saldo > 0 Then
			   v_custo_medio := round(v_val_saldo / v_qtd_saldo, 2);
			End If;
		 
		 Else
		 
			v_qtd_saldo       := nvl(v_qtd_saldo, 0) - r_lcto.qtd_lancto;
			r_lcto.val_lancto := r_lcto.qtd_lancto * v_custo_medio;
			v_val_saldo       := nvl(v_val_saldo, 0) - r_lcto.val_lancto;
		 
			Update atb_requisicao_item
			Set    val_material = r_lcto.val_lancto
			Where  num_requisicao = r_lcto.num_requisicao And
				   num_item = r_lcto.num_item;
		 
		 End If;
	  
	  End Loop;
   
	  If months_between(p_dat_lancamento, v_dat_referencia) > 1 Then
		 While months_between(p_dat_lancamento, v_dat_referencia) > 1 Loop
			v_dat_referencia := last_day(add_months(v_dat_referencia, 1));
			Delete atb_material_saldos
			Where  seq_material = p_seq_material And
				   dat_referencia = v_dat_referencia;
			Insert Into atb_material_saldos
			   (seq_material, dat_referencia, qtd_saldo, val_saldo)
			Values
			   (p_seq_material, v_dat_referencia, v_qtd_saldo, v_val_saldo);
		 
		 End Loop;
	  
	  End If;
   
	  --alterar saldos ATB_MATERIAL
	  Update atb_material
	  Set    qtd_estoque = v_qtd_saldo,
			 val_estoque = v_val_saldo,
			 val_unitario = v_custo_medio
	  Where  seq_material = p_seq_material;
   
	  Commit;
   
   Exception
	  When Others Then
		 raise_application_error(-20003, 'Erro: Calcular saldos, Material: ' || p_seq_material);
	  
   End prc_calc_estoque;

   Function fnc_rec_valores
   (
	  p_seq_material   In atb_material.seq_material%Type,
	  p_dat_lancamento In atb_nota_entrada.dat_compra%Type,
	  p_tpo_valor      In Number
   ) Return Number Is
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Função retorna P_TPO_VALOR (1-qtd_saldo, 2-val_saldo, 3-Custo médio 4-verifica saldo negativo 
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
   
	  v_custo_medio    Number;
	  v_dat_referencia atb_material_saldos.dat_referencia%Type;
	  v_qtd_saldo      atb_material_saldos.qtd_saldo%Type;
	  v_val_saldo      atb_material_saldos.val_saldo%Type;
   
	  Cursor c_lcto Is
		 Select seq_material, dat_lancto, tpo_lancto, qtd_lancto, val_lancto
		 From   atb_vw_lancamentos
		 Where  seq_material = p_seq_material And
				dat_lancto > v_dat_referencia And
				dat_lancto <= decode(p_tpo_valor, 4, dat_lancto, p_dat_lancamento)
		 Order  By dat_lancto, decode(tpo_lancto, 'E', 1, 2);
   
   Begin
   
	  Begin
		 -- Seleciona o ultimo mes ref (ultimo dia do mes)
		 Select dat_referencia, qtd_saldo, val_saldo
		 Into   v_dat_referencia, v_qtd_saldo, v_val_saldo
		 From   atb_material_saldos sl,
				(Select Max(dat_referencia) maximo
				  From   atb_material_saldos
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
			Insert Into atb_material_saldos
			   (seq_material, dat_referencia, qtd_saldo, val_saldo)
			Values
			   (p_seq_material, v_dat_referencia, 0, 0);
			v_custo_medio := 0;
		 
		 When Others Then
			Rollback;
			raise_application_error(-20001, 'Erro ao selcionar saldo inicial ' || Sqlerrm);
	  End;
   
	  For r_lcto In c_lcto Loop
	  
		 -- Entrada altera CUSTO MÉDIO
		 If r_lcto.tpo_lancto = 'E' Then
		 
			v_qtd_saldo   := nvl(v_qtd_saldo, 0) + r_lcto.qtd_lancto;
			v_val_saldo   := nvl(v_val_saldo, 0) + r_lcto.val_lancto;
			v_custo_medio := 0;
			If v_val_saldo > 0 Then
			   v_custo_medio := round(v_val_saldo / v_qtd_saldo, 2);
			End If;
		 
		 Else
		 
			v_qtd_saldo       := nvl(v_qtd_saldo, 0) - r_lcto.qtd_lancto;
			r_lcto.val_lancto := r_lcto.qtd_lancto * v_custo_medio;
			v_val_saldo       := nvl(v_val_saldo, 0) - r_lcto.val_lancto;
		 
			If v_qtd_saldo < 0 And
			   p_tpo_valor = 4 Then
			   Return(v_qtd_saldo);
			End If;
		 
		 End If;
	  
	  End Loop;
   
	  If p_tpo_valor = 1 Or
		 p_tpo_valor = 4 Then
		 Return(v_qtd_saldo);
	  Elsif p_tpo_valor = 2 Then
		 Return(v_val_saldo);
	  Elsif p_tpo_valor = 3 Then
		 Return(v_custo_medio);
	  End If;
   
   Exception
	  When Others Then
		 raise_application_error(-20003, 'Erro: Calcular saldos, Material: ' || Sqlerrm
								 /*p_seq_material*/);
	  
   End fnc_rec_valores;

   --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
   -- Acerta Sequência dos itens no nota Fiscal                                                                                                                                                                      
   --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
   Procedure prc_fecha_nota
   (
	  p_seq_fornecedor In atb_nota_entrada.seq_fornecedor%Type,
	  p_num_nota       In atb_nota_entrada.num_nota%Type
   ) Is
   
	  Cursor c_itens Is
		 Select seq_fornecedor, num_nota, seq_item, seq_material, qtd_item, val_item
		 From   atb_nota_entrada_item
		 Where  seq_fornecedor = p_seq_fornecedor And
				num_nota = p_num_nota
		 Order  By seq_item;
   
	  r_itens      c_itens%Rowtype;
	  v_dat_compra atb_nota_entrada.dat_compra%Type;
   
   Begin
	  Select dat_compra
	  Into   v_dat_compra
	  From   atb_nota_entrada
	  Where  seq_fornecedor = p_seq_fornecedor And
			 num_nota = p_num_nota;
   
	  Update atb_nota_entrada ne
	  Set    ne.sta_nota = 'F'
	  Where  ne.seq_fornecedor = p_seq_fornecedor And
			 ne.num_nota = p_num_nota;
	  Commit;
   
   End prc_fecha_nota;

   Procedure prc_fecha_requisicao(p_num_requisicao In atb_requisicao.num_requisicao%Type) Is
   
	  Cursor c_itens Is
		 Select rq.dat_requisicao, ri.num_item, ri.seq_material, ri.qtd_material
		 From   atb_requisicao rq, atb_requisicao_item ri
		 Where  rq.num_requisicao = ri.num_requisicao And
				ri.num_requisicao = p_num_requisicao
		 Order  By ri.num_item;
   
	  r_itens c_itens%Rowtype;
   
   Begin
   
	  Update atb_requisicao re
	  Set    re.sta_requisicao = 'F'
	  Where  re.num_requisicao = p_num_requisicao;
	  Commit;
   
   End prc_fecha_requisicao;

   Procedure prc_fechamento_estoque(p_dat_lancamento In atb_nota_entrada.dat_compra%Type) Is
   
	  Cursor c_mat Is
		 Select seq_material
		 From   atb_material;
   
   Begin
   
	  For r_mat In c_mat Loop
	  
		 Begin
			pkg_material.prc_calc_estoque(p_seq_material => r_mat.seq_material,
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
	  v_seq_sla_det atb_material_sla_det.seq_sla_det%Type;
   
	  v_data_exec   Varchar2(20) := to_char(p_dt_exec, 'DD/MM/YYYY HH24:MI:SS');
	  v_data_sla    Varchar2(20);
	  v_data_limite Varchar2(20);
   
	  e_saida Exception;
	  e_prox_nivel Exception;
   
	  v_prox_nivel Number := 0;
   
	  v_val_nivel    atb_material_sla.val_nivel%Type;
	  v_qtd_horas    atb_material_sla.qtd_horas%Type;
	  v_nom_cor_html atb_material_sla.nom_cor_html%Type;
   
	  corpo Long;
   
   Begin
   
	  Select Count(*)
	  Into   v_aux
	  From   atb_material_sla_det
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
				   From   atb_material_sla a
				   Where  Exists (Select 1
						   From   atb_material_sla_det b
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
					  From   atb_material_sla_det a, atb_material b
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
						From   atb_material_sla,
							   (Select Min(val_nivel) prox_nivel
								 From   atb_material_sla
								 Where  seq_material = j.seq_material And
										(p_dt_exec - j.dat_sla) * 24 < qtd_horas) pr
						Where  seq_material = j.seq_material And
							   val_nivel = pr.prox_nivel;
					 
					 Exception
						When no_data_found Then
						   Select val_nivel, qtd_horas, nom_cor_html
						   Into   v_val_nivel, v_qtd_horas, v_nom_cor_html
						   From   atb_material_sla,
								  (Select Max(val_nivel) ult_nivel
									From   atb_material_sla
									Where  seq_material = j.seq_material) pr
						   Where  seq_material = j.seq_material And
								  val_nivel = pr.ult_nivel;
					 End;
				  
					 Update atb_material_sla_det
					 Set    sta_sla     = 'E',
							dat_emissao = Sysdate
					 Where  seq_sla_det = j.seq_sla_det;
				  
					 Insert Into atb_material_sla_det
						(seq_sla_det, seq_material, val_nivel, nom_cor_html, dat_limite_sla,
						 sta_sla, dat_emissao)
					 Values
						(Null, j.seq_material, v_val_nivel, v_nom_cor_html,
						 p_dt_exec + (v_qtd_horas / 24), 'P', null);
				  
				  Exception
					 When Others Then
						raise_application_error(-20003, 'Erro ao selecionar próximo nivel');
				  End;
			   
			   Else
				  -- mantem o mesmo nivel 
			   
				  Begin
					 Update atb_material_sla_det
					 Set    sta_sla = 'E',
							dat_emissao = Sysdate
					 Where  seq_sla_det = j.seq_sla_det;
				  
					 Insert Into atb_material_sla_det
						(seq_sla_det, seq_material, val_nivel, nom_cor_html, dat_limite_sla,
						 sta_sla, dat_emissao)
					 Values
						(Null, j.seq_material, j.val_nivel, i.nom_cor_html, j.dat_limite_sla, 'P', null);
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
   
	  Insert Into atb_material_sla_email
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

End pkg_material;
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


CREATE OR REPLACE procedure teste is




   v_seq_job   Number := 0;
   v_data_base Number := 0;

Begin

   --******************************************************************************
   --) Criar registro na tabela ATB_JOB_DET (Tipo de job, Nr JOB)
   --) Traz sequence do registro cadastrado.
   --******************************************************************************

   v_seq_job := artbox.pkg_jobs.fnc_cad_job(p_seq_job => 1, p_num_job => 0, p_dat_exec => Null);

   artbox.pkg_jobs.prc_ini_job(p_seq_job => v_seq_job);

   -----------------------------------------------
   -- Fechamento mensal todo dia 1 de cada mes
   -----------------------------------------------
   artbox.pkg_material.prc_fechamento_estoque(p_dat_lancamento => trunc(last_day(add_months(Sysdate, -1))));

   artbox.pkg_jobs.prc_fim_job(p_seq_job => v_seq_job);

End;
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


CREATE OR REPLACE VIEW ATB_VW_LANCAMENTOS
AS 
Select   ni.seq_material,   mae.nom_material, mae.dm_unidade_medida,
            ne.dat_compra,    'E' tpo_lancamento,
     qtd_item,       val_item,
       pkg_material.fnc_rec_valores(p_seq_material => ni.seq_material,
                p_dat_lancamento => ne.dat_compra,
        p_tpo_valor => 1) qtd_saldo,
       pkg_material.fnc_rec_valores(p_seq_material => ni.seq_material,
                p_dat_lancamento => ne.dat_compra,
        p_tpo_valor => 2) val_saldo,
       pkg_material.fnc_rec_valores(p_seq_material => ni.seq_material,
                p_dat_lancamento => ne.dat_compra,
        p_tpo_valor => 3) custo_medio,
     ni.seq_fornecedor,   ni.num_nota,     ni.seq_item,
     null, null
From   artbox.atb_nota_entrada ne, artbox.atb_nota_entrada_item ni, artbox.atb_material mae
Where  ne.seq_fornecedor = ni.seq_fornecedor And
    ni.seq_material = mae.seq_material and
       ne.num_nota = ni.num_nota
Union all
Select   ri.seq_material,   mas.nom_material, mas.dm_unidade_medida,
       dat_requisicao,   'S' tpo_lancamento,
     qtd_material,      val_material,
       pkg_material.fnc_rec_valores(p_seq_material => ri.seq_material,
                p_dat_lancamento => re.dat_requisicao,
        p_tpo_valor => 1) qtd_saldo,
       pkg_material.fnc_rec_valores(p_seq_material => ri.seq_material,
                p_dat_lancamento => re.dat_requisicao,
        p_tpo_valor => 2) val_saldo,
       pkg_material.fnc_rec_valores(p_seq_material => ri.seq_material,
                p_dat_lancamento => re.dat_requisicao,
        p_tpo_valor => 3) custo_medio,
         null,       null,          null,
        ri.num_requisicao, ri.num_item
From   artbox.atb_requisicao re, artbox.atb_requisicao_item ri, artbox.atb_material mas
Where  re.num_requisicao = ri.num_requisicao and
    ri.seq_material = mas.seq_material
Order  By seq_material, dat_compra, tpo_lancamento
    With Read Only;


CREATE OR REPLACE TRIGGER TRG_ATB_FORNECEDOR_BIU
   BEFORE INSERT OR UPDATE ON ATB_FORNECEDOR
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



CREATE OR REPLACE TRIGGER trg_ATB_FORNECEDOR_MAT_biu
   before insert or update on ATB_FORNECEDOR_MATERIAL
   for each row
declare
	 
	 v_dat_cadastro		atb_material.dat_cadastro%type;

Begin

	Select dat_cadastro
	  Into v_dat_cadastro
	  From atb_material
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



CREATE OR REPLACE TRIGGER trg_atb_nota_entrada_item_biu
   before insert or update on atb_nota_entrada_item
   for each row
declare
	 
	 v_dat_cadastro		atb_material.dat_cadastro%type;
	 v_dat_compra		atb_nota_entrada.dat_compra%type;

Begin
	-- Le data de cadastro do material
	Select dat_cadastro
	  Into v_dat_cadastro
	  From atb_material
	 Where seq_material = :New.seq_material;
	 
	 -- Le a data da compra do material
	  select ne.dat_compra into v_dat_compra
	   from atb_nota_entrada ne
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



CREATE OR REPLACE TRIGGER trg_atb_material_BIU
   Before Insert or update On ATB_MATERIAL
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



CREATE OR REPLACE TRIGGER ATB_MATERIAL_SLA_DET_BI
 BEFORE INSERT
 ON ATB_MATERIAL_SLA_DET
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



CREATE OR REPLACE TRIGGER ATB_MATERIAL_SLA_EMAIL_bi
   before insert on ATB_MATERIAL_SLA_EMAIL
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



CREATE OR REPLACE TRIGGER atb_material_biu
   before Insert or update  of qtd_estoque,  qtd_minimo
	  On atb_material
   For Each Row
Declare

   v_aux          Number := 0;
   v_val_nivel    atb_material_sla.val_nivel%Type;
   v_qtd_horas    atb_material_sla.qtd_horas%Type;
   v_nom_cor_html atb_material_sla.nom_cor_html%Type;

Begin

   -- Verificar se estoque esta abaixo do minimo
   If :New.qtd_estoque < :New.qtd_minimo And
	  :New.dat_sla Is Null Then
   
	  :New.dat_sla := Sysdate;
   
	  -- Incluir material em lista de pendencia
	  Select val_nivel, qtd_horas, nom_cor_html
	  Into   v_val_nivel, v_qtd_horas, v_nom_cor_html
	  From   atb_material_sla a
	  Where  a.seq_material = :New.seq_material And
			 val_nivel = (Select Min(val_nivel) minimo
						  From   atb_material_sla b
						  Where  a.seq_material = b.seq_material);
   
	  Insert Into atb_material_sla_det
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
	  From   atb_material_sla_det
	  Where  seq_material = :New.seq_material And
			 sta_sla = 'P';
   
	  If v_aux > 0 Then
	  
		 -- Retirar material de lista de pendencias
	  
		 Update atb_material_sla_det
		 Set    sta_sla = 'C'
		 Where  seq_material = :New.seq_material And
				sta_sla = 'P';
	  
	  End If;
   
   End If;

End;
/
SHOW ERRORS;



ALTER TABLE ATB_CLIENTES ADD (
  CONSTRAINT AVCON_1619463871_DM_FL_000
 CHECK (DM_FL_BLOQ IN ('N', 'S')),
  CONSTRAINT ATB_CLIENTES_PK
 PRIMARY KEY
 (SEQ_CLIENTE));

ALTER TABLE ATB_CLIENTES_ENDERECOS ADD (
  CONSTRAINT ATB_CLIENTES_END_PK
 PRIMARY KEY
 (SEQ_CLIENTE, CG_TPO_ENDERECO));

ALTER TABLE ATB_PRODUTOS_SERVICOS ADD (
  CONSTRAINT ATB_PRODUTOS_SERV_PK
 PRIMARY KEY
 (SEQ_PRODUTO, SEQ_SERVICO));

ALTER TABLE ATB_NOTA_ENTRADA ADD (
  CONSTRAINT ATB_NOTA_ENTRADA_CK01
 CHECK (sta_nota in ('A', 'F')),
  CONSTRAINT ATB_NOTA_ENTRADA_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, NUM_NOTA));

ALTER TABLE ATB_REQUISICAO_ITEM ADD (
  CONSTRAINT ATB_REQUISICAO_ITEM_PK
 PRIMARY KEY
 (NUM_REQUISICAO, NUM_ITEM));

ALTER TABLE ATB_MATERIAL_SLA ADD (
  CONSTRAINT ATB_MATERIAL_SLA_PK
 PRIMARY KEY
 (SEQ_MATERIAL, VAL_NIVEL));

ALTER TABLE ATB_MATERIAL_SLA_DET ADD (
  CONSTRAINT ATB_MATERIAL_SLA_DET_CK01
 CHECK ("STA_SLA"='P' OR "STA_SLA"='E' OR "STA_SLA"='C'),
  CONSTRAINT ATB_MATERIAL_SLA_DET_PK
 PRIMARY KEY
 (SEQ_SLA_DET));

ALTER TABLE ATB_SERVICOS_TARIFAS ADD (
  CONSTRAINT ATB_SERVICOS_TAR_PK
 PRIMARY KEY
 (SEQ_SERVICO, DAT_VIGENCIA));

ALTER TABLE ATB_JOB ADD (
  CONSTRAINT ATB_JOB_PK
 PRIMARY KEY
 (SEQ_JOB));

ALTER TABLE ATB_MATERIAL ADD (
  CONSTRAINT ATB_MATERIAL_CK01
 CHECK (DMN_FL_BLOQ in ('S', 'N')),
  CONSTRAINT MATERIAL_PK
 PRIMARY KEY
 (SEQ_MATERIAL));

ALTER TABLE ATB_REQUISICAO ADD (
  CONSTRAINT ATB_REQUISICAO_CK01
 CHECK (STA_REQUISICAO in ('A', 'F')),
  CONSTRAINT ATB_REQUISICAO_PK
 PRIMARY KEY
 (NUM_REQUISICAO));

ALTER TABLE ATB_MATERIAL_SLA_EMAIL ADD (
  CONSTRAINT ATB_MATERIAL_SLA_EMAIL_PK
 PRIMARY KEY
 (SEQ_EMAIL));

ALTER TABLE ATB_PRODUTOS ADD (
  CONSTRAINT DMN_FL_BLOQ_CK01
 CHECK (dmn_fl_bloq in ('S', 'N')),
  CONSTRAINT PRODUTOS_PK
 PRIMARY KEY
 (SEQ_PRODUTO));

ALTER TABLE ATB_PRODUTOS_MATERIAIS ADD (
  CONSTRAINT ATB_PRODUTOS_MAT_PK
 PRIMARY KEY
 (SEQ_PRODUTO, SEQ_MATERIAL));

ALTER TABLE ATB_FORNECEDOR ADD (
  CONSTRAINT FORNECEDOR_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR));

ALTER TABLE ATB_JOB_DET ADD (
  CONSTRAINT ATB_JOB_DET_CK01
 CHECK (STA_JOB in ('P', 'E', 'C', 'F')),
  CONSTRAINT ATB_JOB_DET_PK
 PRIMARY KEY
 (SEQ_JOB_DET));

ALTER TABLE ATB_MATERIAL_SALDOS ADD (
  CONSTRAINT ATB_MATERIAL_SALDOS_PK
 PRIMARY KEY
 (SEQ_MATERIAL, DAT_REFERENCIA));

ALTER TABLE ATB_FORNECEDOR_ENDERECO ADD (
  CONSTRAINT FORNECEDOR_ENDERECO_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, DM_TPO_ENDERECO));

ALTER TABLE ATB_NOTA_ENTRADA_ITEM ADD (
  CONSTRAINT ATB_NFE_ITEM_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, NUM_NOTA, SEQ_ITEM));

ALTER TABLE ATB_FORNECEDOR_MATERIAL ADD (
  CONSTRAINT FORNECEDOR_MAT_PK
 PRIMARY KEY
 (SEQ_FORNECEDOR, SEQ_MATERIAL));

ALTER TABLE ATB_SERVICOS ADD (
  CONSTRAINT ATB_PRODUTOS_MAT_CK01
 CHECK (dmn_fl_bloq in ('S', 'N')),
  CONSTRAINT ATB_SERVICOS_PK
 PRIMARY KEY
 (SEQ_SERVICO));

ALTER TABLE ATB_CLIENTES_ENDERECOS ADD (
  CONSTRAINT ACO_ACE_FK 
 FOREIGN KEY (SEQ_CLIENTE) 
 REFERENCES);

ALTER TABLE ATB_PRODUTOS_SERVICOS ADD (
  CONSTRAINT APO_ASO_FK 
 FOREIGN KEY (SEQ_SERVICO) 
 REFERENCES,
  CONSTRAINT ATB_PRODUTOS_SERV_FK01 
 FOREIGN KEY (SEQ_PRODUTO) 
 REFERENCES);

ALTER TABLE ATB_NOTA_ENTRADA ADD (
  CONSTRAINT ANA_FRN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR) 
 REFERENCES);

ALTER TABLE ATB_REQUISICAO_ITEM ADD (
  CONSTRAINT ARM_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES,
  CONSTRAINT ARM_ARO_FK 
 FOREIGN KEY (NUM_REQUISICAO) 
 REFERENCES 
    ON DELETE CASCADE);

ALTER TABLE ATB_MATERIAL_SLA ADD (
  CONSTRAINT ATB_MATERIAL_SLA_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_MATERIAL_SLA_DET ADD (
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

ALTER TABLE ATB_PRODUTOS_MATERIAIS ADD (
  CONSTRAINT ATB_PRODUTOS_MAT_FK01 
 FOREIGN KEY (SEQ_PRODUTO) 
 REFERENCES,
  CONSTRAINT ATB_PRODUTOS_MAT_FK02 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_JOB_DET ADD (
  CONSTRAINT ATB_JOB_DET_FK 
 FOREIGN KEY (SEQ_JOB) 
 REFERENCES);

ALTER TABLE ATB_MATERIAL_SALDOS ADD (
  CONSTRAINT AMO_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_FORNECEDOR_ENDERECO ADD (
  CONSTRAINT FEO_FRN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR) 
 REFERENCES);

ALTER TABLE ATB_NOTA_ENTRADA_ITEM ADD (
  CONSTRAINT ANM_ANA_FK 
 FOREIGN KEY (SEQ_FORNECEDOR, NUM_NOTA) 
 REFERENCES,
  CONSTRAINT ANM_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES);

ALTER TABLE ATB_FORNECEDOR_MATERIAL ADD (
  CONSTRAINT FML_MAL_FK 
 FOREIGN KEY (SEQ_MATERIAL) 
 REFERENCES,
  CONSTRAINT FML_FRN_FK 
 FOREIGN KEY (SEQ_FORNECEDOR) 
 REFERENCES);

