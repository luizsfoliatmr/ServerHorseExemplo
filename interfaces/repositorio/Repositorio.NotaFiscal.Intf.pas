unit Repositorio.NotaFiscal.Intf;

interface

uses
  Repositorio.Intf,
  Modelo.NotaFiscal.Intf;

type

  IRepositorioNotaFiscal = interface(IRepositorio)
    ['{F3B44525-67D4-447D-952B-9395D2467EDC}']

    function Get(const CodigoEmpresa: Integer; const pChave: string; out ANotaFiscal : IModeloNotaFiscal) : Boolean;
  end;

implementation

end.
