unit BD.Repositorio.Usuario.Impl;

interface

uses
  System.SysUtils,
  TFC.Collections.Intf,
  BD.Repositorio.Impl,
  Modelo.Usuario.Intf,
  Repositorio.Usuario.Intf;

type
  TBDRepositorioUsuario = class(TBDRepositorioID<IModeloUsuario>, IRepositorioUsuario)
  strict private const
    PLACE_HOLDER_FIELDS = ' /*ph_fields*/ ';
    QUERY_BASE =
      'select ' +
      '  usuario.id ' +
      ' ,usuario.nome ' +
      ' ,usuario.email ' +
     // ' ,usuario.ativo ' +
      PLACE_HOLDER_FIELDS +
      'from ' +
      '  usuario ';
  strict protected
    procedure CarregarParametrosComModelo(pParametros: IBDParametros; pModelo: IModeloUsuario); override;
    procedure CarregarModeloComDataset(pModelo: IModeloUsuario; pDataset: IBDDataset); override;

    function GetNomeTabela: string; override;

    function CriarModelo: IModeloUsuario; override;

    function DoTryGet(const pID: UInt32; out pModelo: IModeloUsuario): Boolean; override;

    function TryValidar(const pEmail, pSenha: string; out pUsuario: IModeloUsuario): Boolean;

    function DoGetAll: ITFCList<IModeloUsuario>; override;

    procedure DoIncluir(pModelo: IModeloUsuario); override;
    procedure DoAlterar(pModelo: IModeloUsuario); override;
    procedure DoExcluir(pModelo: IModeloUsuario); override;

  end;

implementation

uses
  System.Rtti,
  TFC.Helpers,
  TFC.Guard,
  TFC.Collections.Impl,
  BD.Repositorio.Intf,
  Modelo.Usuario.Impl,
  Base.Excecoes.Impl,
  Base.Excecoes.Modelo.Impl;

{ TBDRepositorioUsuario }

procedure TBDRepositorioUsuario.CarregarModeloComDataset(pModelo: IModeloUsuario; pDataset: IBDDataset);
begin
  inherited;

  pModelo.Nome := pDataset['nome'].AsString;
  pModelo.Email := pDataset['email'].AsString;
end;

procedure TBDRepositorioUsuario.CarregarParametrosComModelo(pParametros: IBDParametros; pModelo: IModeloUsuario);
begin
  inherited;

  pParametros.TrySetAsString('nome', pModelo.Nome);
  pParametros.TrySetAsString('email', pModelo.Email);
  pParametros.TrySetAsString('senha', pModelo.Senha);
end;

function TBDRepositorioUsuario.CriarModelo: IModeloUsuario;
begin
  Result := TModeloUsuario.Create;
end;

procedure TBDRepositorioUsuario.DoAlterar(pModelo: IModeloUsuario);
begin
  inherited;
  raise EModeloNaoEncontrado.Create(Self.ClassName + 'Não implementado');
end;

procedure TBDRepositorioUsuario.DoExcluir(pModelo: IModeloUsuario);
begin
  inherited;
  raise EModeloNaoEncontrado.Create(Self.ClassName + 'Não implementado');
end;

function TBDRepositorioUsuario.DoGetAll: ITFCList<IModeloUsuario>;
begin
  raise EModeloNaoEncontrado.Create(Self.ClassName + 'Não implementado');
end;

procedure TBDRepositorioUsuario.DoIncluir(pModelo: IModeloUsuario);
begin
  inherited;
  raise EModeloNaoEncontrado.Create(Self.ClassName + 'Não implementado');
end;

function TBDRepositorioUsuario.DoTryGet(const pID: UInt32; out pModelo: IModeloUsuario): Boolean;
begin
  var lSQL := QUERY_BASE + 'where usuario.id = :id';

  Result := TryAbrirQueryECarregarModelo(lSQL, pModelo,
    procedure(pParametros: IBDParametros)
    begin
      pParametros['id'].AsUInt32 := pID;
    end);
end;

function TBDRepositorioUsuario.GetNomeTabela: string;
begin
  Result := 'usuario';
end;

function TBDRepositorioUsuario.TryValidar(const pEmail, pSenha: string; out pUsuario: IModeloUsuario): Boolean;
begin
  var lSQL := QUERY_BASE.Replace(PLACE_HOLDER_FIELDS, ', usuario.senha ') + ' where email = :email';
  var lQuery := Conexao.AbrirQuery(lSQL,
    procedure(pParametros: IBDParametros)
    begin
      pParametros['email'].AsString := pEmail;
    end);

  Result := lQuery.Next and (lQuery['senha'].AsString = pSenha);
  if Result then
  begin
    pUsuario := CriarModelo;
    CarregarModeloComDataset(pUsuario, lQuery);
  end;
end;

end.
