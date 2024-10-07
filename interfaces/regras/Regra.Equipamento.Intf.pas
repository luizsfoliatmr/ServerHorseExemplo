unit Regra.Equipamento.Intf;

interface

uses
  TFC.Collections.Intf,
  Regra.Modelo.Intf,
  Modelo.Equipamento.Intf;

type
  IRegraEquipamento = interface(IRegraModelo<IModeloEquipamento>)
    ['{12001F33-2E0E-4A2B-A7AC-B84F34B0FEE6}']

    function TryGet(const pNumeroSerial : string; out pModelo: IModeloEquipamento): Boolean; overload;
    function Get(const pNumeroSerial : string): IModeloEquipamento;
  end;

implementation

end.
