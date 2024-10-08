unit Regra.NotaFiscal.Intf;

interface

uses
  Regra.Intf,
  Modelo.NotaFiscal.Intf;

type

  IRegraNotaFiscal = interface(IRegra)
    ['{C40E3039-FC99-47D1-97D7-567EDB0206A2}']
    function Get(const CodigoEmpresa: Integer; const pChave: string; out ANotaFiscal : IModeloNotaFiscal) : Boolean;
  end;

implementation

end.
