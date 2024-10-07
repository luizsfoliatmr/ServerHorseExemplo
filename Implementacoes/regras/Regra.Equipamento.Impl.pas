unit Regra.Equipamento.Impl;

interface

uses
  TFC.Collections.Intf,
  Regra.Modelo.Impl,
  Modelo.Equipamento.Intf,
  Repositorio.Equipamento.Intf,
  Regra.Equipamento.Intf;

type
  TRegraEquipamento = class(TRegraModelo<IModeloEquipamento, IRepositorioEquipamento>, IRegraEquipamento)
  strict protected
    function TryGet(const pNumeroSerial : string; out pModelo: IModeloEquipamento): Boolean; reintroduce; overload;
    function Get(const pNumeroSerial : string): IModeloEquipamento; reintroduce; overload;
  end;

implementation

uses
  System.SysUtils,
  TFC.Collections.Impl;

{ TRegraEquipamento }

function TRegraEquipamento.Get(const pNumeroSerial : string): IModeloEquipamento;
begin
  Result := Repositorio.Get(pNumeroSerial);
end;

function TRegraEquipamento.TryGet(const pNumeroSerial : string; out pModelo: IModeloEquipamento): Boolean;
begin
  Result := Repositorio.TryGet(pNumeroSerial, pModelo);
end;

end.
