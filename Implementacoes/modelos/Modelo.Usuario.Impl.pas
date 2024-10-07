unit Modelo.Usuario.Impl;

interface

uses
  TFC.InterfacedObject,
  Modelo.Impl,
  Modelo.Usuario.Intf;

type
  TModeloUsuario = class(TModeloID, IModeloUsuario)
  strict private
    FNome: string;
    FEmail: string;
    FSenha: string;
    FAtivo: Boolean;
  strict protected
    function GetNome: string;
    procedure SetNome(const pValor: string);

    function GetEmail: string;
    procedure SetEmail(const pValor: string);

    function GetSenha: string;
    procedure SetSenha(const pValor: string);

    function GetAtivo: Boolean;
    procedure SetAtivo(const pValor: Boolean);
  end;

implementation

{ TModeloUsuario }

function TModeloUsuario.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TModeloUsuario.GetEmail: string;
begin
  Result := FEmail;
end;

function TModeloUsuario.GetNome: string;
begin
  Result := FNome;
end;

function TModeloUsuario.GetSenha: string;
begin
  Result := FSenha;
end;

procedure TModeloUsuario.SetAtivo(const pValor: Boolean);
begin
  FAtivo := pValor;
end;

procedure TModeloUsuario.SetEmail(const pValor: string);
begin
  FEmail := pValor;
end;

procedure TModeloUsuario.SetNome(const pValor: string);
begin
  FNome := pValor;
end;

procedure TModeloUsuario.SetSenha(const pValor: string);
begin
  FSenha := pValor;
end;

end.
