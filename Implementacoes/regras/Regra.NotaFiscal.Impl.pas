unit Regra.NotaFiscal.Impl;

interface

uses
  Regra.NotaFiscal.Intf,
  Regra.impl,
  Modelo.NotaFiscal.Intf;

type

  TRegraNotaFiscal = class(TRegra, IRegraNotaFiscal)
  public
    function Get(const CodigoEmpresa: Integer; const pChave: string; out ANotaFiscal : IModeloNotaFiscal) : Boolean;
  end;

implementation

uses
  Repositorio.NotaFiscal.Intf;

{ TRegraNotaFiscal }

function TRegraNotaFiscal.Get(const CodigoEmpresa: Integer; const pChave: string; out ANotaFiscal : IModeloNotaFiscal) : Boolean;
begin
  var lRepositorio := Context.Implementations.Get<IRepositorioNotaFiscal>;
  Result := lRepositorio.Get(CodigoEmpresa, pChave, ANotaFiscal);
end;

end.
