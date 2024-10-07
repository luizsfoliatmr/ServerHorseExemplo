unit Regra.Usuario.Intf;

interface

uses
  TFC.Collections.Intf,
  Regra.Modelo.Intf,
  Modelo.Usuario.Intf;

type
  IRegraUsuario = interface(IRegraModeloID<IModeloUsuario>)
    ['{731064C2-DF25-413E-B1A2-FD6F1AE73A0E}']

    function TryValidar(const pEmail, pSenha: string; out pUsuario: IModeloUsuario): Boolean;
  end;

implementation

end.
