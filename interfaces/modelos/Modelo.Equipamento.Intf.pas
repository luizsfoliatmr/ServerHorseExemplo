unit Modelo.Equipamento.Intf;

interface

uses
  System.SysUtils,
  Modelo.Intf;

type

  IModeloEquipamento = interface(IModelo)
    ['{2E0FBF5B-6B42-4515-A202-345679387F26}']

    function GetModelo: string;
    function GetPartNumber: string;
    function GetQuantidade: Double;
    function GetSerial: string;
    function GetSku: string;
    function GetCaixa: string;
    function GetChaveNf: string;
    function GetCnpjCliente: string;
    function GetCodigoCategoria: Integer;
    function GetNumeroNf: Integer;

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

    property Serial : string read GetSerial write SetSerial;
    property Sku : string read GetSku write SetSku;
    property PartNumber : string read GetPartNumber write SetPartNumber;
    property Modelo : string read GetModelo write SetModelo;
    property Quantidade : Double read GetQuantidade write SetQuantidade;
    property CodigoCategoria : Integer read GetCodigoCategoria write SetCodigoCategoria;
    property NumeroNf : Integer read GetNumeroNf write SetNumeroNf;
    property ChaveNf : string read GetChaveNf write SetChaveNf;
    property CnpjCliente : string read GetCnpjCliente write SetCnpjCliente;
    property Caixa : string read GetCaixa write SetCaixa;
  end;

implementation


end.
