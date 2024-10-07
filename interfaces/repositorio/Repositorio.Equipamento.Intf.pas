unit Repositorio.Equipamento.Intf;

interface

uses
  TFC.Collections.Intf,
  Repositorio.Intf,
  Modelo.Equipamento.Intf;

type
  IRepositorioEquipamento = interface(IRepositorio<IModeloEquipamento>)
    ['{D1241756-11FB-49BE-B867-75893B1C2ED9}']

    function TryGet(const pNumeroSerial : string; out pModelo: IModeloEquipamento): Boolean; overload;
    function Get(const pNumeroSerial : string): IModeloEquipamento; overload;
  end;

implementation

end.
