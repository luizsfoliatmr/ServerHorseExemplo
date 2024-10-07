unit Regra.Usuario.Impl;

interface

uses
  TFC.Collections.Intf,
  Regra.Modelo.Impl,
  Modelo.Usuario.Intf,
  Repositorio.Usuario.Intf,
  Regra.Usuario.Intf;

type
  TRegraUsuario = class(TRegraModeloID<IModeloUsuario, IRepositorioUsuario>, IRegraUsuario)
  strict protected
    function TryValidar(const pEmail, pSenha: string; out pUsuario: IModeloUsuario): Boolean;
  end;

implementation

{ TRegraUsuario }

function TRegraUsuario.TryValidar(const pEmail, pSenha: string; out pUsuario: IModeloUsuario): Boolean;
begin
  Result := Repositorio.TryValidar(pEmail, pSenha, pUsuario);
end;

end.
