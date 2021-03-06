--Create DataBase TouroDB
--Drop Database TouroDB
--Use TouroDB

Delete from Tb_Reg
DBCC CHECKIDENT (Tb_Reg, RESEED,0)

Delete from Tb_Equipamento
DBCC CHECKIDENT (Tb_Equipamento,RESEED,0)

Delete from Tb_TipoConsumivel
DBCC CHECKIDENT (Tb_TipoConsumivel,RESEED,0)

Delete from Tb_Consumivel
DBCC CHECKIDENT (Tb_Consumivel,RESEED,0)
go

Delete from Tb_Msg
DBCC CHECKIDENT (Tb_Msg,RESEED,0)
go

Create Table Tb_Usuario
(
Id_Usuario Int Not Null Identity Primary Key,
Nome varchar(50) Not Null,
Username varchar(50) Not Null Unique,
)
go

--Drop Table Tb_Reg
Create Table Tb_Reg
(
Id_Reg BigInt Not Null Identity Primary Key,
Id_Usuario Int Not Null References Tb_Usuario (Id_Usuario),
Data Datetime Not Null Default GetDate(),
Reg varchar(1000) Not Null
)
go

Create Proc RegNewUser
@Id_Usuario Int,
@Username varchar(50)
as
Begin

Declare @Id_User varchar(10) = (Select Id_Usuario from Tb_Usuario Where Username = @Username)

Declare @Nome varchar(50) = (Select Nome from Tb_Usuario Where Username = @Username)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Cadastro do usuario: <a href="/Admin/GerirUsuarios.aspx?Id='+  @Id_User +'">'+@Nome+'</a>.')

Select Id_Usuario from Tb_Usuario Where Username = @Username

End
go

--------------------------------------------------------------------------------------------Mensagens-------------------------------------------------------------------------------
Create Table Tb_AreaMsg
(
Id_AreaMsg Int Not Null Identity Primary Key,
AreaMsg varchar(25)
)

Insert Into Tb_AreaMsg values ('Solicita��es') --ID 1
Insert Into Tb_AreaMsg values ('Patrimonio') --ID 2
Insert Into Tb_AreaMsg values ('Transportes') --ID 3
Insert Into Tb_AreaMsg values ('Area T�cnica') --ID 4
Insert Into Tb_AreaMsg values ('Administrador') --ID 5

Create Table Tb_TipoMsg
(
Id_TipoMsg Int Not Null Identity Primary Key,
Id_AreaMsg Int Not Null References Tb_AreaMsg(Id_AreaMsg),
TipoMsg varchar(25)
)

Insert Into Tb_TipoMsg values (3,'Revis�o de Viatura') -- ID 1

--Drop Table Tb_Msg
Create Table Tb_Msg
(
Id_Msg Int Not Null Identity Primary Key,
Id_TipoMsg Int Not Null References Tb_TipoMsg (Id_TipoMsg),
Data DateTime Not Null default GetDate(),
Asunto varchar(500) Not Null,
Texto varchar(2500) Not Null, 
DataRead Datetime
)

go

--Insert Into Tb_Msg(Id_TipoMsg,Asunto,Texto) values (1,'Teste','Texto do teste')

Alter Proc CargarMensagens
@Filtro varchar (25)
as
Begin

Declare @Texto varchar(25) = '%' +LTRIM(RTRIM(@Filtro)) + '%'

SELECT Tb_Msg.Id_Msg, Tb_TipoMsg.TipoMsg, Tb_Msg.Asunto, Tb_Msg.Data, Tb_Msg.DataRead FROM Tb_Msg INNER JOIN Tb_TipoMsg ON Tb_Msg.Id_TipoMsg = Tb_TipoMsg.Id_TipoMsg WHERE (Tb_TipoMsg.Id_AreaMsg = 3) and (Asunto like @Texto or Texto like @Texto ) ORDER BY Tb_Msg.Data DESC

End
go


--SELECT COUNT(Tb_Msg.Id_Msg) AS Total
--FROM            Tb_TipoMsg INNER JOIN
--                         Tb_Msg ON Tb_TipoMsg.Id_TipoMsg = Tb_Msg.Id_TipoMsg
--WHERE        (Tb_TipoMsg.Id_AreaMsg = 3) and (Tb_Msg.DataRead IS NULL)


--------------------------------------------------------------------------------------------------Patrimonio---------------------------------------------------------------------------

Create Table Tb_TipoEquip
(
Id_TipoEquip Int Not Null Identity Primary Key,
TipoEquip varchar(25) Not Null Unique
)

Insert Into Tb_TipoEquip values ('Impressora')
Insert Into Tb_TipoEquip values ('Fotocopiadora')
Insert Into Tb_TipoEquip values ('Monitor')
Insert Into Tb_TipoEquip values ('Computador')
Insert Into Tb_TipoEquip values ('Rato')
Insert Into Tb_TipoEquip values ('Teclado')
Insert Into Tb_TipoEquip values ('Servidor')
Insert Into Tb_TipoEquip values ('Telefone')
Insert Into Tb_TipoEquip values ('Camera')
Insert Into Tb_TipoEquip values ('WebCam')
Insert Into Tb_TipoEquip values ('Microfone')
Insert Into Tb_TipoEquip values ('Router')
Insert Into Tb_TipoEquip values ('Switch')
Insert Into Tb_TipoEquip values ('Portatil')
Insert Into Tb_TipoEquip values ('Televisor')
Insert Into Tb_TipoEquip values ('UPS')
Insert Into Tb_TipoEquip values ('Disco Externo')
Insert Into Tb_TipoEquip values ('Modem')
Insert Into Tb_TipoEquip values ('Telemovel')
go

Create Proc AddTipoEquip
@Id_Usuario Int,
@TipoEquip varchar(25)
as
Begin

Insert Into Tb_TipoEquip values (@TipoEquip)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Novo tipo de equipamento cadastrado: <a href="/Admin/DadosPatrimonio.aspx">'+@TipoEquip+'</a>.')

End

--Insert Into Tb_TipoEquip values ('')
go

Create Table Tb_MarcaEquip
(
Id_MarcaEquip Int Not Null Identity Primary Key,
MarcaEquip varchar(25) Not Null Unique
)
Insert Into Tb_MarcaEquip values ('LG')
Insert Into Tb_MarcaEquip values ('Dell')
Insert Into Tb_MarcaEquip values ('HP')
Insert Into Tb_MarcaEquip values ('Toshiba')
Insert Into Tb_MarcaEquip values ('Huawei')
Insert Into Tb_MarcaEquip values ('Acer')
Insert Into Tb_MarcaEquip values ('Planet')
Insert Into Tb_MarcaEquip values ('Sony')
Insert Into Tb_MarcaEquip values ('Sharp')
Insert Into Tb_MarcaEquip values ('Benq')
Insert Into Tb_MarcaEquip values ('Apple')
Insert Into Tb_MarcaEquip values ('HTC')
Insert Into Tb_MarcaEquip values ('Hisense')
Insert Into Tb_MarcaEquip values ('Razor')
Insert Into Tb_MarcaEquip values ('Samsung')
Insert Into Tb_MarcaEquip values ('Sanyo')
Insert Into Tb_MarcaEquip values ('JVC')
Insert Into Tb_MarcaEquip values ('Cisco')
Insert Into Tb_MarcaEquip values ('LinkSys')
Insert Into Tb_MarcaEquip values ('ZTE')
Insert Into Tb_MarcaEquip values ('Asus')
Insert Into Tb_MarcaEquip values ('Microsoft')
Insert Into Tb_MarcaEquip values ('Adobe')
Insert Into Tb_MarcaEquip values ('Brother')
Insert Into Tb_MarcaEquip values ('Canon')
Insert Into Tb_MarcaEquip values ('Kodak')
Insert Into Tb_MarcaEquip values ('Epson')
Insert Into Tb_MarcaEquip values ('Konica Minolta')
Insert Into Tb_MarcaEquip values ('OKI')

--Insert Into Tb_MarcaEquip values ('')

go

Create Proc AddMarcaEquip
@Id_Usuario Int,
@MarcaEquip varchar(25)
as
Begin

Insert Into Tb_MarcaEquip values (@MarcaEquip)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Nova marca de equipamento cadastrada: <a href="/Admin/DadosPatrimonio.aspx">'+@MarcaEquip+'</a>.')

End
go

Create Table Tb_ModeloEquip
(
Id_ModeloEquip Int Not Null Identity Primary Key,
Id_TipoEquip Int Not Null References Tb_TipoEquip (Id_TipoEquip),
Id_MarcaEquip Int Not Null References Tb_MarcaEquip (Id_MarcaEquip),
ModeloEquip varchar(50) Not Null 
)

go

Create Proc AddModeloEquip
@Id_Usuario Int,
@Id_TipoEquip Int,
@Id_MarcaEquip Int,
@ModeloEquip varchar(50) 
as
Begin

Declare @TipoEquip varchar(25) = (Select TipoEquip from Tb_TipoEquip Where  Id_TipoEquip = @Id_TipoEquip)

Declare @MarcaEquip varchar(25) = (Select MarcaEquip from Tb_MarcaEquip Where Id_MarcaEquip = @Id_MarcaEquip)

Insert Into Tb_ModeloEquip (Id_TipoEquip,Id_MarcaEquip,ModeloEquip) values (@Id_TipoEquip,@Id_MarcaEquip,@ModeloEquip)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Novo modelo de equipamento cadastrado: <a href="/Admin/ModeloEquipamentos.aspx">'+@TipoEquip + ' - ' + @MarcaEquip + ' - ' +@ModeloEquip +  '</a>.')

End
go

Create Proc PermicoesEditadas
@Id_Usuario Int,
@Id_User Int
as
Begin

Declare @Nome varchar(50) = (Select Nome from Tb_Usuario Where Id_Usuario = @Id_User)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Permi��es do usuario: <a href="/Admin/GerirUsuarios.aspx">'+ @Nome +'</a> modificadas.')

End
go

Create Proc ResetPass
@Id_Usuario Int,
@Id_User Int
as
Begin

Declare @Nome varchar(50) = (Select Nome from Tb_Usuario Where Id_Usuario = @Id_User)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Senha do usuario: <a href="/Admin/GerirUsuarios.aspx">'+ @Nome +'</a> modificada.')

End
go

Create Table Tb_Sala
(
Id_Sala Int Not Null Identity Primary Key,
Sala varchar(50) Not Null
)

Insert Into Tb_Sala values ('Stock')
go

Create Proc AddSala
@Id_Usuario Int,
@Sala varchar(50)
as
Begin

Insert Into Tb_Sala values (@Sala)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Criada nova sala: <a href="/Patrimonio/Salas.aspx">'+ @Sala +'</a>.')

End
go

Create Table Tb_EstadoEquip
(
Id_EstadoEquip Int Not Null Identity Primary Key,
EstadoEquip varchar(20) Not Null
)
Insert Into Tb_EstadoEquip values ('Funcional')
Insert Into Tb_EstadoEquip values ('Avariado')
Insert Into Tb_EstadoEquip values ('Em Repara��o')
Insert Into Tb_EstadoEquip values ('Fora de Uso')
go
--drop Table Tb_Equipamento

Create Table Tb_Equipamento
(
Id_Equipamento Int Not Null Identity Primary Key,
Id_ModeloEquip Int Not Null Foreign Key References Tb_ModeloEquip(Id_ModeloEquip),
Id_EstadoEquip Int Not Null Foreign Key References Tb_EstadoEquip(Id_EstadoEquip),
Id_Sala Int Not Null References Tb_Sala(Id_Sala),
NumSerie varchar(20),
Custo Money Not Null Default 0,
Fornecedor varchar(30) Not Null default 'Nenhuma Informa��o Disponivel',
COD varchar(7) Not Null,
Obs varchar(1000) Not Null,
DataReg Datetime Not Null Default GetDate()
)
go

Create Proc AddEquipamento
@Id_Usuario int,
@Id_ModeloEquip Int,
@Id_EstadoEquip Int,
@Id_Sala Int,
@NumSerie varchar(20),
@Custo Money,
@Fornecedor varchar(30),
@Obs varchar(1000),
@Id_Equipamento varchar(8) Output
as
Begin

Declare @Sala varchar(50) = (Select Sala from Tb_Sala Where Id_Sala = @Id_Sala)

Declare @COD Varchar(7) = 'E' + Right('000000'+ Convert(varchar(13) , IDENT_CURRENT('Tb_Equipamento') + 1 ) , 6 )

INSERT INTO [dbo].[Tb_Equipamento]
           (
		   [Id_ModeloEquip]
           ,[Id_EstadoEquip]
		   ,Id_Sala
		   ,[NumSerie]
           ,[Custo]
           ,[Fornecedor]
		   ,Obs
		   ,[COD])
     VALUES
           (@Id_ModeloEquip
           ,@Id_EstadoEquip
		   ,@Id_Sala
		   ,@NumSerie
		   ,@Custo
           ,@Fornecedor
		   ,@Obs
		   ,@COD)

Set @Id_Equipamento = (Select Id_Equipamento from Tb_Equipamento where COD = @COD)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Equipamento : <a href="/Patrimonio/Equipamento.aspx?Id=' + Convert(varchar(7),@Id_Equipamento) +'">'+ @COD +'</a> cadastrado.')

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Equipamento : <a href="/Patrimonio/Equipamento.aspx?Id=' + Convert(varchar(7),@Id_Equipamento) +'">'+ @COD +'</a> localizado em: <a href="/Patrimonio/Sala.aspx?Id='+Convert (varchar(50),@Id_Sala) +'">'+ @Sala +'</a>')

Return (Select Id_Equipamento from Tb_Equipamento where COD = @COD)

End
go

--Exec AddEquipamento 1,8,1,1,'555LJH5',200000,'NCR Talatona','Teste de Funcionamento.',0

--Select * From Tb_Equipamento
go


Create Proc FiltrarEquipamento
@Id_Sala int,
@Sala bit,
@Id_Tipo int,
@Tipo bit,
@Id_Estado int,
@Estado bit,
@COD varchar(8)
as
Begin

Declare @C varchar(8) = '%' +LTRIM(RTRIM(@COD)) + '%';

If @Sala = 1 and @Tipo = 1 and @Estado = 1 
	Begin
		SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.Id_Sala = @Id_Sala) AND (Tb_Equipamento.Id_EstadoEquip = @Id_Estado) AND (Tb_TipoEquip.Id_TipoEquip = @Id_Tipo) AND (Tb_Equipamento.COD like @C)
	End
else if @Sala = 1 and @Tipo = 1 and @Estado = 0
	Begin
		SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.Id_Sala = @Id_Sala) AND (Tb_TipoEquip.Id_TipoEquip = @Id_Tipo) AND (Tb_Equipamento.COD like @C)
	End
else if @Sala = 1 and @Tipo = 0 and @Estado = 1
	Begin
		SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.Id_Sala = @Id_Sala) AND (Tb_Equipamento.Id_EstadoEquip = @Id_Estado) AND (Tb_Equipamento.COD like @C)
	End
else if @Sala = 1 and @Tipo = 0 and @Estado = 0
	Begin
		SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.Id_Sala = @Id_Sala) AND (Tb_Equipamento.COD like @C)
	End
else if @Sala = 0 and @Tipo = 1 and @Estado = 1
Begin
	SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.Id_EstadoEquip = @Id_Estado) AND (Tb_TipoEquip.Id_TipoEquip = @Id_Tipo) AND (Tb_Equipamento.COD like @C)
End
else if @Sala = 0 and @Tipo = 1 and @Estado = 0
Begin
	SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE       (Tb_TipoEquip.Id_TipoEquip = @Id_Tipo) AND (Tb_Equipamento.COD like @C)
End
else if @Sala = 0 and @Tipo = 0 and @Estado = 1
Begin
	SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.Id_EstadoEquip = @Id_Estado) AND (Tb_Equipamento.COD like @C)
End
else if @Sala = 0 and @Tipo = 0 and @Estado = 0
Begin
	SELECT        Tb_Equipamento.Id_Equipamento, Tb_Equipamento.NumSerie, Tb_Equipamento.COD, Tb_TipoEquip.TipoEquip, Tb_TipoEquip.Id_TipoEquip
		FROM            Tb_Equipamento INNER JOIN
								 Tb_ModeloEquip ON Tb_Equipamento.Id_ModeloEquip = Tb_ModeloEquip.Id_ModeloEquip INNER JOIN
								 Tb_TipoEquip ON Tb_ModeloEquip.Id_TipoEquip = Tb_TipoEquip.Id_TipoEquip
		WHERE        (Tb_Equipamento.COD like @C)
End
End

--Exec FiltrarEquipamento 1,1,1,1,1,1,' '
go

Create Proc HistorialEquipamento
@Id_Equipamento Int
as
Begin

Declare @COD varchar(7) = (Select COD from Tb_Equipamento Where Id_Equipamento = @Id_Equipamento)

SELECT         Tb_Usuario.Nome, Tb_Reg.Data, Tb_Reg.Reg
FROM            Tb_Reg INNER JOIN
                         Tb_Usuario ON Tb_Reg.Id_Usuario = Tb_Usuario.Id_Usuario Where Reg like '%'+@COD+'%'
						 Order by Tb_Reg.Id_Reg Desc
End
go

--Exec HistorialEquipamento 2

Create Table Tb_TipoConsumivel
(
Id_TipoConsumivel Int Not NUll Identity Primary Key,
TipoConsumivel varchar(25) Not Null
)

Insert Into Tb_TipoConsumivel values ('Material Impress�o')
Insert Into Tb_TipoConsumivel values ('Material Escritorio')
Insert Into Tb_TipoConsumivel values ('Material de Limpeza')
Insert Into Tb_TipoConsumivel values ('Outros Materiais')

go

Create Table Tb_UnidadConsumivel
(
Id_UnidadConsumivel Int Not Null Identity Primary Key,
UnidadConsumivel varchar(25) Not Null
)

Insert Into Tb_UnidadConsumivel values ('Tinteiro')
Insert Into Tb_UnidadConsumivel values ('Item')
Insert Into Tb_UnidadConsumivel values ('Toner')
Insert Into Tb_UnidadConsumivel values ('Caixa')
Insert Into Tb_UnidadConsumivel values ('Resma')
Insert Into Tb_UnidadConsumivel values ('Bidon')
Insert Into Tb_UnidadConsumivel values ('Garrafa')
Insert Into Tb_UnidadConsumivel values ('Lata')
Insert Into Tb_UnidadConsumivel values ('Pacote')
Insert Into Tb_UnidadConsumivel values ('Embalagem')
Insert Into Tb_UnidadConsumivel values ('Rolo')
--Insert Into Tb_UnidadConsumivel values ('')
go

Create Table Tb_Consumivel
(
Id_Consumivel Int Not Null Identity Primary Key,
Id_TipoConsumivel Int Not Null References Tb_TipoConsumivel (Id_TipoConsumivel),
Id_UnidadConsumivel Int Not Null References Tb_UnidadConsumivel (Id_UnidadConsumivel),
Descr varchar(50) Not Null Unique,
Quantidade Int Not Null Default 0
)

go

--Select * from Tb_Consumivel

Create Proc AddConsumivel
@Id_Usuario Int,
@Id_TipoConsumivel Int,
@Id_UnidadConsumivel Int,
@Descr varchar(50)
as
Begin

Insert Into Tb_Consumivel(Id_TipoConsumivel,Id_UnidadConsumivel,Descr) values (@Id_TipoConsumivel,@Id_UnidadConsumivel,@Descr)

Declare @Unidad varchar(25) = (Select Tb_UnidadConsumivel.UnidadConsumivel from Tb_UnidadConsumivel Where Id_UnidadConsumivel = @Id_UnidadConsumivel)

Declare @Id_Consumivel Int = (Select Id_Consumivel from Tb_Consumivel where Descr = @Descr)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Consumivel : <a href="/Patrimonio/Consumivel.aspx?Id=' + Convert(varchar(7),@Id_Consumivel) +'">'+@Unidad +' - '+ @Descr +'</a> cadastrado.')

Return @Id_Consumivel
End
go

--drop Table Tb_EntradaStock
Create Table Tb_EntradaStock
(
Id_EntradaStock Int Not Null Identity Primary Key,
Id_Usuario Int Not Null References Tb_Usuario (Id_Usuario),
Id_Consumivel Int Not Null References Tb_Consumivel (Id_Consumivel),
CustoUnitario Money Not Null,
Quantidade Int Not Null,
Fornecedor varchar(30) Not Null,
Obs varchar(1000) Not Null,
DataEntrada DateTime Not Null Default GetDate()
)
go
--select * from Tb_EntradaStock
Alter Proc AddEntradaStock
@Id_Usuario Int,
@Id_Consumivel Int,
@CustoUnitario Money,
@Quantidade Int,
@Fornecedor varchar(30),
@Obs varchar(1000)
as
Begin

Insert Into Tb_EntradaStock(Id_Consumivel,Id_Usuario,CustoUnitario,Quantidade,Fornecedor,Obs) values (@Id_Consumivel,@Id_Usuario,@CustoUnitario,@Quantidade,@Fornecedor,@Obs)

Declare @Exist Int = (Select Quantidade from Tb_Consumivel where Id_Consumivel = @Id_Consumivel)

Update Tb_Consumivel set Quantidade = @Exist + @Quantidade Where Id_Consumivel = @Id_Consumivel

Declare @Descr varchar(50) = (Select Descr from Tb_Consumivel Where Id_Consumivel = @Id_Consumivel)

Declare @Unidad varchar(25) = (SELECT        Tb_UnidadConsumivel.UnidadConsumivel
FROM            Tb_Consumivel INNER JOIN
                         Tb_UnidadConsumivel ON Tb_Consumivel.Id_UnidadConsumivel = Tb_UnidadConsumivel.Id_UnidadConsumivel
WHERE        (Tb_Consumivel.Id_Consumivel = @Id_Consumivel))

Declare @Id_EntradaStock varchar(15) = (Select IDENT_CURRENT('Tb_EntradaStock')) 

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Consumivel : <a href="/Patrimonio/Consumivel.aspx?Id=' + Convert(varchar(7),@Id_Consumivel) +'">'+@Unidad +' - '+ @Descr +'</a> inserido en <a href="/Patrimonio/ExistenciasConsumiveis.aspx?Id='+@Id_EntradaStock+' ">Stock.</a>')

Return @Id_EntradaStock
End
go

--Drop
Create Table Tb_Solicitantes
(
Id_Solicitante Int Not Null Identity Primary Key,
Id_Usuario Int Not Null References Tb_Usuario (Id_Usuario),
Id_Sala Int Not Null References Tb_Sala (Id_Sala)
)
go

Create Proc AddSolicitante
@Id_Usuario Int,
@Id_Sala Int,
@Id_Solicitante Int
as
Begin

Insert Into Tb_Solicitantes values (@Id_Solicitante,@Id_Sala)

Declare @Solicitante varchar(50) = (Select Tb_Usuario.Nome from Tb_Usuario where Id_Usuario = @Id_Solicitante)

Declare @Sala varchar(50) = (Select Sala from Tb_Sala Where Id_Sala = @Id_Sala)

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Solicitante <b>' + @Solicitante +'</b> adicionado a sala : <a href="/Patrimonio/Sala.aspx?Id=' + Convert(varchar(10),@Id_Sala) +'">'+@Sala +'</a>.')

Return (Select IDENT_CURRENT('Tb_Solicitante')) 

End
go

Create Proc DelSolicitante
@Id_Usuario Int,
@Id_Solicitante Int
as
Begin

Declare @Solicitante varchar(50) = (Select Tb_Usuario.Nome from Tb_Usuario where Id_Usuario = @Id_Solicitante)

Declare @Sala varchar(50) = (Select Sala from Tb_Sala inner join Tb_Solicitantes on Tb_Sala.Id_Sala = Tb_Solicitantes.Id_Sala Where Tb_Solicitantes.Id_Solicitante = @Id_Solicitante)

Declare @Id_Sala Int = (Select Id_Sala from Tb_Sala where Sala = @Sala)

Delete from Tb_Solicitantes where Id_Solicitante = @Id_Solicitante

Insert Into Tb_Reg (Id_Usuario,Reg) values (@Id_Usuario,'Solicitante <b>' + @Solicitante +'</b> eliminado da sala : <a href="/Patrimonio/Sala.aspx?Id=' + Convert(varchar(10),@Id_Sala) +'">'+@Sala +'</a>.')

Return (Select IDENT_CURRENT('Tb_Solicitante')) 

End
go



--Exec AddSolicitante 1,2,1

Create Table Tb_SaidaStock
(
Id_SaidaStock Int Not Null Identity Primary Key,
Id_Usuario Int Not Null References Tb_Usuario (Id_Usuario),
Id_Consumivel Int Not Null References Tb_Consumivel (Id_Consumivel),
Id_Sala Int Not Null References Tb_Sala (Id_Sala),
Data Datetime default GetDate(),
Quantidade Int Not Null
)
go

--Select AVG(CustoUnitario) from Tb_EntradaStock Where Id_Consumivel = 1


SELECT        SUM (Tb_EntradaStock.Quantidade ) as Entradas
FROM            Tb_EntradaStock INNER JOIN
                         Tb_Consumivel ON Tb_EntradaStock.Id_Consumivel = Tb_Consumivel.Id_Consumivel
WHERE        (Tb_Consumivel.Id_Consumivel = 2)

SELECT        SUM(Tb_EntradaStock.Quantidade) AS Entrada, SUM(Tb_SaidaStock.Quantidade) AS Saida
FROM            Tb_EntradaStock CROSS JOIN
                         Tb_SaidaStock
GROUP BY Tb_SaidaStock.Quantidade
go

---------------------------------------------------------------------------------------------------------Transportes--------------------------------------------------------------------------------------------
------------------------------Viaturas-------------------
Create Table Tb_Combustivel
(
Id_Combustivel Int Not Null Identity Primary Key,
Combustivel varchar(10) 
)
Insert Into Tb_Combustivel values ('Gasolina')
Insert Into Tb_Combustivel values ('Gas�leo')
go

--Drop Table Tb_Viatura
Create Table Tb_Viatura
(
Id_Viatura Int Not Null Identity Primary Key,
Marca varchar(25) Not Null,
Modelo varchar(25) Not Null,
Matricula varchar(11) Not Null,
Km Int Not Null Default 0,
NumMotor varchar(20) Not Null,
Pneus varchar(10) Not Null,
Id_Combustivel Int Not Null References Tb_Combustivel (Id_Combustivel),
KmCheck Int Not Null Default 5000
)
go

--Alter Table Tb_Viatura Add KmCheck Int Not Null Default 5000
--go

Create Proc AddViatura
@Id_Usuario Int,
@Marca varchar(25),
@Modelo varchar(25),
@Matricula varchar(11),
@Km Int,
@NumMotor varchar(20),
@Pneus varchar(10),
@Id_Combustivel Int
as
Begin
Insert Into Tb_Viatura(Marca,Modelo,Matricula,Km,NumMotor,Pneus,Id_Combustivel) values (@Marca,@Modelo,@Matricula,@Km,@NumMotor,@Pneus,@Id_Combustivel)

Insert Into Tb_Reg(Id_Usuario,Reg) values (@Id_Usuario,'Cadastro da viatura <a>'+@Matricula+'</a>.')

End
go
------------------------------Revis�es-------------------
Create Table Tb_CheckViatura
(
Id_CheckViatura Int Not Null Identity Primary Key,
Id_Viatura Int Not Null References Tb_Viatura (Id_Viatura),
Entidade varchar(50) Not Null,
Data Date Not Null,
Km Int Not Null,
Custo Money Not Null,
Obs varchar(1000) Not Null
)
go

Create Proc AddCheckViatura
@Id_Usuario Int,
@Id_Viatura Int,
@Entidade varchar(50),
@Data Date,
@Km Int,
@Custo Money,
@Obs varchar(1000)
as
Begin

Insert Into Tb_CheckViatura(Id_Viatura,Entidade,Data,Km,Custo,Obs) values (@Id_Viatura,@Entidade,@Data,@Km,@Custo,@Obs)

declare @Id_CheckViatura varchar(10) = (Select IDENT_CURRENT('Tb_CheckViatura'))

Insert into Tb_Reg(Id_Usuario,Reg) values (@Id_Usuario,'Registo N�: '+@Id_CheckViatura +' de <b>Manuten��o a Viatura</b>')

End

------------------------------Motoristas-------------------
Create Table Tb_Motorista
(
Id_Motorista Int Not Null Identity Primary Key,
Nome varchar(50) Not Null,
DataNasc Date Not Null,
BI varchar(15) Not Null,
Carta varchar(15) Not Null,
Activo Bit Not Null Default 1
)
go


Create Proc AddMotorista
@Id_Usuario Int,
@Nome varchar(50),
@DataNasc Date,
@BI varchar(15),
@Carta varchar(15)
as
Begin

Insert Into Tb_Motorista(Nome,DataNasc, BI, Carta) values (@Nome,@DataNasc,@BI,@Carta)

Insert Into Tb_Reg(Id_Usuario,Reg) values (@Id_Usuario,'Cadastro do motorista <a>'+@Nome+'</a>.')

End
go

------------------------------Saidas-------------------
--Drop table Tb_Saida 
Create Table Tb_Saida
(
Id_Saida Int Not Null Identity Primary Key,
Id_Viatura Int Not Null References Tb_Viatura (Id_Viatura),
Id_Motorista Int Not Null References Tb_Motorista (Id_Motorista),
Data Date Not Null Default GetDate(),
HoraSaida Time Not Null,
HoraEntrada Time Not Null,
KmSaida Int Not Null,
KmEntrada Int Not Null,
Rota varchar(100) Not Null,
Obs varchar(1000) Not Null
)
go

Create Proc AddSaida
@Id_Usuario Int,
@Id_Viatura Int,
@Id_Motorista Int,
@Data Date,
@HoraSaida time,
@HoraEntrada time,
@KmEntrada Int,
@Rota varchar(100),
@Obs varchar(1000)
as
Begin

Declare @KmSaida int = (Select Km from Tb_Viatura Where Id_Viatura = @Id_Viatura)

Insert Into Tb_Saida
(Id_Viatura,Id_Motorista, Data,HoraSaida,HoraEntrada,KmSaida,KmEntrada,Rota,Obs)
values
(@Id_Viatura,@Id_Motorista, @Data, @HoraSaida,@HoraEntrada,@KmSaida,@KmEntrada,@Rota,@Obs)

Update Tb_Viatura Set Km = @KmEntrada where Id_Viatura = @Id_Viatura

Declare @LastCheck Int = IsNull((Select Max(Km) from Tb_CheckViatura Where Id_Viatura = @Id_Viatura),0)

Declare @Matricula varchar(11) = (Select Matricula from Tb_Viatura where Id_Viatura = @Id_Viatura)

Declare @Marca varchar(25) = (Select Marca from Tb_Viatura Where Id_Viatura = @Id_Viatura)

Declare @Modelo varchar(25) = (Select Modelo from Tb_Viatura Where Id_Viatura = @Id_Viatura)

Declare @KmCheck Int = (Select KmCheck from Tb_Viatura where Id_Viatura = @Id_Viatura)


If (@KmCheck < (@KmEntrada - @LastCheck))
begin
INSERT INTO [dbo].[Tb_Msg]
           ([Id_TipoMsg]
           ,[Asunto]
           ,[Texto])
     VALUES
           (1
           ,'Revis�o viatura <a>'+@Matricula+'</a>'
           ,'A viatura de Marca: '+@Marca+ ' e Modelo: '+@Modelo+' com matricula <a>' + @Matricula + '</a>, atingiu a kilometragem m�xima sem revis�o por mais de '+ CONVERT(varchar(6),((@KmEntrada - @LastCheck)- @KmCheck )) +' quilometros.</br></br> Efectue a revis�o e insira no sistema para deixar de receber esta mensagem.')


    --Insert Into Tb_Msg(Id_TipoMsg,Asunto,Texto) values (1,'Revis�o viatura <a>'+@Matricula+'</a>','A viatura de Marca: '+@Marca+ ' e Modelo: '+@Modelo+' com matricula <a>' + @Matricula + '</a>, atingiu a kilometragem m�xima sem revis�o.</br> Efectue a revis�o e insira no sistema para deixar de receber esta mensagem.')
	End

Insert Into Tb_Reg(Id_Usuario,Reg) values (@Id_Usuario,'Lanzamento de Saida N� '+ CONVERT(varchar(16), IDENT_CURRENT('Tb_Saida')))

End

Exec AddSaida 1,2,1,'2015-10-31','16:30','22:00','75901','Teste de manuten��o','Sem novidade'