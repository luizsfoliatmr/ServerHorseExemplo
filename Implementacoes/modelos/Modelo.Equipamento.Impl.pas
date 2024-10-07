unit Modelo.Equipamento.Impl;

interface

uses
  Modelo.Impl,
  Modelo.Equipamento.Intf;

type
  TModeloEquipamento = class(TModelo, IModeloEquipamento)
  strict private
    FModelo: string;
    FPartNumber: string;
    FQuantidade: Double;
    FSerial: string;
    FSku: string;
    FCaixa: string;
    FChaveNf: string;
    FCnpjCliente: string;
    FCodigoCategoria: Integer;
    FNumeroNf: Integer;

  strict protected

    function GetCaixa: string;
    function GetChaveNf: string;
    function GetCnpjCliente: string;
    function GetCodigoCategoria: Integer;
    function GetNumeroNf: Integer;
    function GetModelo: string;
    function GetPartNumber: string;
    function GetQuantidade: Double;
    function GetSerial: string;
    function GetSku: string;

    procedure SetModelo(const Value: string);
    procedure SetPartNumber(const Value: string);
    procedure SetQuantidade(const Value: Double);
    procedure SetSerial(const Value: string);
    procedure SetSku(const Value: string);
    procedure SetCaixa(const Value: string);
    procedure SetChaveNf(const Value: string);
    procedure SetCnpjCliente(const Value: string);
    procedure SetCodigoCategoria(const Value: Integer);
    procedure SetNumeroNf(const Value: Integer);

  end;

implementation


{ TModeloEquipamento }

function TModeloEquipamento.GetCaixa: string;
begin
  Result := FCaixa;
end;

function TModeloEquipamento.GetChaveNf: string;
begin
  Result := FChaveNf;
end;

function TModeloEquipamento.GetCnpjCliente: string;
begin
  Result := FCnpjCliente;
end;

function TModeloEquipamento.GetCodigoCategoria: Integer;
begin
  Result := FCodigoCategoria;
end;

function TModeloEquipamento.GetModelo: string;
begin
  Result := FModelo;
end;

function TModeloEquipamento.GetNumeroNf: Integer;
begin
  Result := FNumeroNf;
end;

function TModeloEquipamento.GetPartNumber: string;
begin
  Result := FPartNumber;
end;

function TModeloEquipamento.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

function TModeloEquipamento.GetSerial: string;
begin
  Result := FSerial;
end;

function TModeloEquipamento.GetSku: string;
begin
  Result := FSku;
end;

procedure TModeloEquipamento.SetCaixa(const Value: string);
begin
  FCaixa := Value;
end;

procedure TModeloEquipamento.SetChaveNf(const Value: string);
begin
  FChaveNf := Value;
end;

procedure TModeloEquipamento.SetCnpjCliente(const Value: string);
begin
  FCnpjCliente := Value;
end;

procedure TModeloEquipamento.SetCodigoCategoria(const Value: Integer);
begin
  FCodigoCategoria := Value;
end;

procedure TModeloEquipamento.SetModelo(const Value: string);
begin
  FModelo := Value;
end;

procedure TModeloEquipamento.SetNumeroNf(const Value: Integer);
begin
  FNumeroNf := Value;
end;

procedure TModeloEquipamento.SetPartNumber(const Value: string);
begin
  FPartNumber := Value;
end;

procedure TModeloEquipamento.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TModeloEquipamento.SetSerial(const Value: string);
begin
  FSerial := Value;
end;

procedure TModeloEquipamento.SetSku(const Value: string);
begin
  FSku := Value;
end;

end.
