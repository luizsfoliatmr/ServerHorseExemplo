unit Modelo.NotaFiscal.Impl;

interface

uses
  TFC.Collections.Intf,
  TFC.Collections.Impl,
  Modelo.Impl,
  Modelo.NotaFiscal.Intf;

type

  TModeloItemNotaFiscal = class(TModelo, IModeloItemNotaFiscal)
  strict private
    FNomeProduto : string;
    FQuantidade : Double;

    function GetNomeProduto : string;
    function GetQuantidade : Double;

    procedure SetNomeProduto(const pValue : string);
    procedure SetQuantidade(const pValue : Double);
  end;

  TModeloNotaFiscal = class(TModelo, IModeloNotaFiscal)
  strict private
    FChaveNotaFiscal : string;
    FItens : ITfCList<IModeloItemNotaFiscal>;

    function GetChaveNotaFiscal : string;
    function GetItens : ITfCList<IModeloItemNotaFiscal>;

    procedure SetChaveNotaFiscal(const pValue : string);
  end;

implementation

{ TModeloNotaFiscal }

function TModeloNotaFiscal.GetChaveNotaFiscal: string;
begin
  Result := FChaveNotaFiscal;
end;

function TModeloNotaFiscal.GetItens: ITfCList<IModeloItemNotaFiscal>;
begin
  if FItens = nil then
    FItens := TTFCList<IModeloItemNotaFiscal>.Create;

  Result := FItens;
end;

procedure TModeloNotaFiscal.SetChaveNotaFiscal(const pValue: string);
begin
  FChaveNotaFiscal := pValue;
end;

{ TModeloItemNotaFiscal }

function TModeloItemNotaFiscal.GetNomeProduto: string;
begin
  Result := FNomeProduto;
end;

function TModeloItemNotaFiscal.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TModeloItemNotaFiscal.SetNomeProduto(const pValue: string);
begin
  FNomeProduto := pValue;
end;

procedure TModeloItemNotaFiscal.SetQuantidade(const pValue: Double);
begin
  FQuantidade := pValue;
end;

end.
