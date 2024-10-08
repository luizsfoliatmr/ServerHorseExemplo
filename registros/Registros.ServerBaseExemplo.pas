unit Registros.ServerBaseExemplo;

interface

uses
  TFC.Contexts.Intf;

type

  TRegistradorImplementacoesServerBaseExemplo = class
  strict private
    class procedure RegistrarImplementacoesUsuario(pContexto: ITFCContext);
    class procedure RegistrarImplementacoesEquipamento(pContexto: ITFCContext);
    class procedure RegistrarImplementacoesNotaFiscal(pContexto: ITFCContext);
    class procedure RegistrarControllers;
  public
    class procedure Registrar;
  end;

implementation

uses
  System.IOUtils,
  TFC.Implementations,
  Horse,
  Horse.Jhonson,
  Horse.JWT,
  Registros.ServerBase,
  Repositorio.Equipamento.Intf,
  Regra.Equipamento.Intf,
  BD.Repositorio.Equipamento.Impl,
  Regra.Equipamento.Impl,
  Controller.Equipamento.Impl,
  Repositorio.NotaFiscal.Intf,
  Regra.NotaFiscal.Intf,
  BD.Repositorio.NotaFiscal.Impl,
  Regra.NotaFiscal.Impl,
  Controller.NotaFiscal.Impl,
  Repositorio.Usuario.Intf,
  Regra.Usuario.Intf,
  BD.Repositorio.Usuario.Impl,
  Regra.Usuario.Impl,
  Controller.Usuario.Impl;

{ TRegistradorImplementacoesServerBaseExemplo }

class procedure TRegistradorImplementacoesServerBaseExemplo.Registrar;
begin
  var lContextoPrincipal := TTFCImplementations.MainContext;
  TRegistradorImplementacoesServerBase.Registrar(lContextoPrincipal,
    'chave_temporaria',
    ['/usuario/login', '/ping', '/echo']);
  RegistrarImplementacoesUsuario(lContextoPrincipal);
  RegistrarImplementacoesEquipamento(lContextoPrincipal);
  RegistrarImplementacoesNotaFiscal(lContextoPrincipal);

  RegistrarControllers;

end;

class procedure TRegistradorImplementacoesServerBaseExemplo.RegistrarControllers;
begin
  TControllerUsuario.Registrar;
  TControllerEquipamento.Registrar;
  TControllerNotaFiscal.Registrar;
end;

class procedure TRegistradorImplementacoesServerBaseExemplo.RegistrarImplementacoesEquipamento(pContexto: ITFCContext);
begin
  //Exemplo de consulta em tabela (precisa de um database com uma tabela Equipamento, DDL abaixo)
  pContexto.Implementations.RegisterGetterDedicated<IRepositorioEquipamento>(
    function(pContext: ITFCContext): IRepositorioEquipamento
    begin
      Result := TBDRepositorioEquipamento.Create(pContext);
    end);
  pContexto.Implementations.RegisterGetterDedicated<IRegraEquipamento>(
    function(pContext: ITFCContext): IRegraEquipamento
    begin
      Result := TRegraEquipamento.Create(pContext);
    end);
  {
    CREATE TABLE EQUIPAMENTO (
    SERIAL VARCHAR(100),
    SKU VARCHAR(100),
    PARTNUMBER VARCHAR(100)
  );
  }
end;

class procedure TRegistradorImplementacoesServerBaseExemplo.RegistrarImplementacoesNotaFiscal(pContexto: ITFCContext);
begin
  //Exemplo de consulta em tabela (precisa de um database com uma tabela Equipamento, DDL abaixo)

  pContexto.Implementations.RegisterGetterDedicated<IRepositorioNotaFiscal>(
    function(pContext: ITFCContext): IRepositorioNotaFiscal
    begin
      Result := TBDRepositorioNotaFiscal.Create(pContext);
    end);
  pContexto.Implementations.RegisterGetterDedicated<IRegraNotaFiscal>(
    function(pContext: ITFCContext): IRegraNotaFiscal
    begin
      Result := TRegraNotaFiscal.Create(pContext);
    end);
  {
   CREATE TABLE NOTAFISCAL (
	ID INTEGER,
	NUMERO INTEGER,
	CHAVE VARCHAR(45),
	EMPRESA INTEGER,
	CONSTRAINT NOTAFISCAL_PK PRIMARY KEY (EMPRESA,ID)
);

CREATE TABLE ITEMNOTAFISCAL (
	ID INTEGER,
	NOTAFISCAL INTEGER,
	NOMEPRODUTO VARCHAR(100),
	QUANTIDADE DECIMAL,
	EMPRESA INTEGER,
	CONSTRAINT ITEMNOTAFISCAL_PK PRIMARY KEY (ID),
	CONSTRAINT ITEMNOTAFISCAL_NOTAFISCAL_FK FOREIGN KEY (EMPRESA,NOTAFISCAL) REFERENCES NOTAFISCAL(EMPRESA,ID);
);
  );
  }
end;

class procedure TRegistradorImplementacoesServerBaseExemplo.RegistrarImplementacoesUsuario(pContexto: ITFCContext);
begin
  //Exemplo de uso de autenticação, com geração de Token (precisa de um database com uma tabela usuario)
  pContexto.Implementations.RegisterGetterDedicated<IRepositorioUsuario>(
    function(pContext: ITFCContext): IRepositorioUsuario
    begin
      Result := TBDRepositorioUsuario.Create(pContext);
    end);
  pContexto.Implementations.RegisterGetterDedicated<IRegraUsuario>(
    function(pContext: ITFCContext): IRegraUsuario
    begin
      Result := TRegraUsuario.Create(pContext);
    end);

  {
    CREATE TABLE USUARIO (
    NOME VARCHAR(100),
    EMAIL VARCHAR(100),
    SENHA VARCHAR(100),
    ID INTEGER NOT NULL
    );
  }
end;

end.
