unit Modelo.NotaFiscal.Intf;

interface

uses
  TFC.Collections.Intf,
  Modelo.Intf;

type

  IModeloItemNotaFiscal = interface(IModelo)
    ['{A5B58722-A644-4ECA-9464-C25FB1DAA4BB}']

    function GetNomeProduto : string;
    function GetQuantidade : Double;

    procedure SetNomeProduto(const pValue : string);
    procedure SetQuantidade(const pValue : Double);

    property NomeProduto : string read GetNomeProduto write SetNomeProduto;
    property Quantidade : Double read GetQuantidade write SetQuantidade;
  end;

  IModeloNotaFiscal = interface(IModelo)
    ['{DED7B619-2B3A-4C28-809C-A410D3FEEA53}']

    function GetChaveNotaFiscal : string;
    function GetItens : ITfCList<IModeloItemNotaFiscal>;

    procedure SetChaveNotaFiscal(const pValue : string);

    property ChaveNotaFiscal : string read GetChaveNotaFiscal write SetChaveNotaFiscal;
    property Itens : ITfCList<IModeloItemNotaFiscal> read GetItens;
  end;


implementation

end.
