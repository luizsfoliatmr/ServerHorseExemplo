unit Repositorio.Usuario.Intf;

interface

uses
  TFC.Collections.Intf,
  Repositorio.Intf,
  Modelo.Usuario.Intf;

type
  IRepositorioUsuario = interface(IRepositorioID<IModeloUsuario>)
    ['{AFB161B9-148F-4B0B-AF75-FEB8C9AA0350}']
    function TryValidar(const pEmail, pSenha: string; out pUsuario: IModeloUsuario): Boolean;
  end;

implementation

end.
