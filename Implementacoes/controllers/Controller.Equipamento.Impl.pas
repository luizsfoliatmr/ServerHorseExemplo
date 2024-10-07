unit Controller.Equipamento.Impl;

interface

uses
  System.JSON,
  Horse,
  Gerenciador.Sessao,
  Gerenciador.Sessao.Identificador,
  Controller.Modelo.Impl,
  Modelo.Equipamento.Intf,
  Regra.Equipamento.Intf;

type
  TControllerEquipamento = class(TControllerModelo<IModeloEquipamento, IRegraEquipamento>)
  strict protected
    function GetRegra: IRegraEquipamento; override;

    procedure CarregarModeloComJSON(pModelo: IModeloEquipamento; const pJSON: TJSONObject); override;
    procedure CarregarJSONComModelo(const pJSON: TJSONObject; pModelo: IModeloEquipamento); override;

    procedure DoGet(pRequest: THorseRequest; pResponse: THorseResponse); override;
    procedure DoPost(pRequest: THorseRequest; pResponse: THorseResponse); override;
    procedure DoPut(pRequest: THorseRequest; pResponse: THorseResponse); override;
    procedure DoDelete(pRequest: THorseRequest; pResponse: THorseResponse); override;
  public
    class procedure Registrar;
  end;

implementation

uses
  System.SysUtils,
  TFC.Helpers,
  TFC.Helpers.Exception,
  TFC.Collections.Impl,
  TFC.Collections.Intf;

{ TControllerEquipamento }

procedure TControllerEquipamento.CarregarJSONComModelo(const pJSON: TJSONObject; pModelo: IModeloEquipamento);
begin
  inherited;

  pJSON.AddPair('serial', pModelo.Serial);
  pJSON.AddPair('sku', pModelo.Sku);
  pJSON.AddPair('partNumber', pModelo.PartNumber);

end;

procedure TControllerEquipamento.CarregarModeloComJSON(pModelo: IModeloEquipamento; const pJSON: TJSONObject);
begin
  inherited;

end;

procedure TControllerEquipamento.DoDelete(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  inherited;
end;

procedure TControllerEquipamento.DoGet(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  inherited;

  var lSerial := pRequest.Params.Field('numero_serial').AsString;
  var lModelo : IModeloEquipamento;

  if not Regra.TryGet(lSerial, lModelo) then
    RaiseModeloNaoEncontrado;

  var lResposta := TJSONObject.Create;
  CarregarJSONComModelo(lResposta, lModelo);

  pResponse.Send<TJSONObject>(lResposta);
end;

procedure TControllerEquipamento.DoPost(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  inherited;

end;

procedure TControllerEquipamento.DoPut(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  inherited;
end;

function TControllerEquipamento.GetRegra: IRegraEquipamento;
begin
  Result := inherited;
end;

class procedure TControllerEquipamento.Registrar;
begin
  THorse.Get('/equipamentos/:numero_serial', Self.Get);
end;


end.
