 Declare
 
	v_seq_logradouro portal.logradouro.seq_logradouro%Type;
	v_numero         Number;
	v_complemento    Varchar2(20);
 
 Begin
 
	For j In (Select seq_fornecedor
			  From   artbox.atb_fornecedores) Loop
	
	   For k In 1 .. 3 Loop
	   
		  Select seq_logradouro
		  Into   v_seq_logradouro
		  From   (Select *
				   From   portal.logradouro
				   Order  By dbms_random.random)
		  Where  rownum < 2;
	   
		  v_numero := 'CNJ ' || trunc(dbms_random.Value(1, 25));
	   
		  If Mod(v_numero, 4) = 0 Then
			 v_complemento := '';
		  Elsif Mod(v_numero, 4) = 1 Then
			 v_complemento := 'APTO ' || (Mod(v_numero, 25) + 1);
		  Elsif Mod(v_numero, 4) = 2 Then
			 v_complemento := 'fundos';
		  Elsif Mod(v_numero, 4) = 3 Then
			 v_complemento := 'Sobrelo';
		  End If;
	   
		  Insert Into atb_fornecedores_endereco
			 (seq_fornecedor, dm_tpo_endereco, seq_logradouro, num_endereco, nom_complemento)
		  Values
			 (j.seq_fornecedor, k, v_seq_logradouro, v_numero, v_complemento);
	   
	   End Loop;
	
	End Loop;
 
 End;
