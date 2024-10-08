unit Controller.NotaFiscal.Impl;

interface

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Gerenciador.Sessao,
  Gerenciador.Sessao.Identificador,
  Controller.Modelo.Impl,
  Modelo.Equipamento.Intf,
  Regra.Equipamento.Intf,
  Controller.Impl,
  TFC.Implementations,
  Regra.NotaFiscal.Intf,
  Modelo.NotaFiscal.Intf,
  TFC.Collections.Intf;

type
  TControllerNotaFiscal = class(TController)
  public
    function ToJsonObject(const pNotaFiscal : IModeloNotaFiscal) : TJSONObject; overload;
    function ToJsonObject(const pItemNotaFiscal : IModeloItemNotaFiscal) : TJSONObject; overload;
    function ToJsonArray(const pItensNotaFiscal : ITFCList<IModeloItemNotaFiscal>) : TJSONArray;

    procedure GetNotaFiscal(pRequest: THorseRequest; pResponse: THorseResponse);
    procedure GetItensNotaFiscal(pRequest: THorseRequest; pResponse: THorseResponse);
  public
    class procedure Registrar;
  end;


implementation

{ TControllerNotaFiscal }

procedure TControllerNotaFiscal.GetItensNotaFiscal(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  var lChave := pRequest.Params.Field('chave').AsString;
  var lCodEmpresa := TGerenciadorSessao.GetValor<string>(TGerenciadorSessaoIdentificador.GUID_EMPRESA);

  var lRegra : IRegraNotaFiscal := TTFCImplementations.Get<IRegraNotaFiscal>;

  var lNotaFiscal : IModeloNotaFiscal;

  if not lRegra.Get(lCodEmpresa.ToInteger, lChave, lNotaFiscal) then
    RaiseModeloNaoEncontrado;

  pResponse.Send<TJSONArray>(ToJsonArray(lNotaFiscal.Itens));
end;

procedure TControllerNotaFiscal.GetNotaFiscal(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  var lChave := pRequest.Params.Field('chave').AsString;
  var lCodEmpresa := TGerenciadorSessao.GetValor<string>(TGerenciadorSessaoIdentificador.GUID_EMPRESA);

  var lRegra : IRegraNotaFiscal := TTFCImplementations.Get<IRegraNotaFiscal>;

  var lNotaFiscal : IModeloNotaFiscal;

  if not lRegra.Get(lCodEmpresa.ToInteger, lChave, lNotaFiscal) then
    RaiseModeloNaoEncontrado;

  pResponse.Send<TJSONObject>(ToJsonObject(lNotaFiscal));
end;

class procedure TControllerNotaFiscal.Registrar;
begin
  THorse.Get('/notafiscal/:chave',
    procedure (pRequest: THorseRequest; pResponse: THorseResponse)
    begin
      var lController := Self.Create;
      try
        lController.GetNotaFiscal(pRequest, pResponse);
      finally
        lController.Free;
      end;
    end);

  THorse.Get('/notafiscal/:chave/itens',
    procedure (pRequest: THorseRequest; pResponse: THorseResponse)
    begin
      var lController := Self.Create;
      try
        lController.GetItensNotaFiscal(pRequest, pResponse);
      finally
        lController.Free;
      end;
    end);

end;

function TControllerNotaFiscal.ToJsonArray(const pItensNotaFiscal: ITFCList<IModeloItemNotaFiscal>): TJSONArray;
begin
  Result := TJSONArray.Create;

  for var lItem in pItensNotaFiscal do
  begin
    Result.AddElement(ToJsonObject(lItem));
  end;
end;

function TControllerNotaFiscal.ToJsonObject(const pItemNotaFiscal: IModeloItemNotaFiscal): TJSONObject;
begin
  Result := TJSONObject.Create;

  Result.AddPair('NomeProduto', pItemNotaFiscal.NomeProduto);
  Result.AddPair('Quantidade', TJSONNumber.Create(pItemNotaFiscal.Quantidade));
end;

function TControllerNotaFiscal.ToJsonObject(const pNotaFiscal: IModeloNotaFiscal): TJSONObject;
begin
  Result := TJSONObject.Create;

  Result.AddPair('chave', pNotaFiscal.ChaveNotaFiscal);
  Result.AddPair('itens', ToJsonArray(pNotaFiscal.Itens));
end;

end.
