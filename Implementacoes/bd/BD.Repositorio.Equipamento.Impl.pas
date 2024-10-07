unit BD.Repositorio.Equipamento.Impl;

interface

uses
  System.SysUtils,
  System.DateUtils,
  TFC.Collections.Intf,
  BD.Repositorio.Impl,
  Modelo.Equipamento.Intf,
  Repositorio.Equipamento.Intf;

type

  TBDRepositorioEquipamento = class(TBDRepositorio<IModeloEquipamento>, IRepositorioEquipamento)
  strict private const
    QUERY_BASE =
      'select ' +
      '  * ' +
      'from ' +
      '  equipamento ';
  strict protected

    procedure DoIncluir(pModelo: IModeloEquipamento); override;
    procedure DoAlterar(pModelo: IModeloEquipamento); override;
    procedure DoExcluir(pModelo: IModeloEquipamento); override;
    procedure Salvar(pModelo: IModeloEquipamento); override;

    procedure CarregarParametrosComModelo(pParametros: IBDParametros; pModelo: IModeloEquipamento); override;
    procedure CarregarModeloComDataset(pModelo: IModeloEquipamento; pDataset: IBDDataset); override;

    function GetNomeTabela: string; override;

    function CriarModelo: IModeloEquipamento; override;

    function DoGetAll: ITFCList<IModeloEquipamento>; override;

    function TryGet(const pNumeroSerial : string; out pModelo: IModeloEquipamento): Boolean; reintroduce; overload;
    function Get(const pNumeroSerial : string): IModeloEquipamento; reintroduce; overload;

    function GetQueryBase: string; override;
  end;

implementation

uses
  TFC.Guard,
  TFC.Types,
  TFC.Helpers,
  TFC.Collections.Impl,
  Base.Excecoes.Modelo.Impl,
  Modelo.Equipamento.Impl;

{ TBDRepositorioEquipamento }

procedure TBDRepositorioEquipamento.CarregarModeloComDataset(pModelo: IModeloEquipamento; pDataset: IBDDataset);
begin
  inherited;

  pModelo.Serial := pDataset.Fields['serial'].AsString;
  pModelo.Sku := pDataset.Fields['Sku'].AsString;
  pModelo.PartNumber := pDataset.Fields['PartNumber'].AsString;
end;

procedure TBDRepositorioEquipamento.CarregarParametrosComModelo(pParametros: IBDParametros; pModelo: IModeloEquipamento);
begin
  inherited;

  pParametros.TrySetAsString('serial', pModelo.Serial);
  pParametros.TrySetAsString('Sku', pModelo.Sku);
  pParametros.TrySetAsString('PartNumber', pModelo.PartNumber);
end;

function TBDRepositorioEquipamento.CriarModelo: IModeloEquipamento;
begin
  Result := TModeloEquipamento.Create;
end;

procedure TBDRepositorioEquipamento.DoAlterar(pModelo: IModeloEquipamento);
begin
  inherited;

end;

procedure TBDRepositorioEquipamento.DoExcluir(pModelo: IModeloEquipamento);
begin
  inherited;

end;

function TBDRepositorioEquipamento.DoGetAll: ITFCList<IModeloEquipamento>;
begin
  Result := AbrirQueryECarregarModelos(QUERY_BASE,
    procedure(pParametros: IBDParametros)
    begin

    end);
end;

procedure TBDRepositorioEquipamento.DoIncluir(pModelo: IModeloEquipamento);
begin
  inherited;

end;

function TBDRepositorioEquipamento.Get(const pNumeroSerial : string): IModeloEquipamento;
begin
  if not TryGet(pNumeroSerial, Result) then
  begin
    raise EModeloNaoEncontrado.Create;
  end;
end;

function TBDRepositorioEquipamento.GetNomeTabela: string;
begin
  Result := 'equipamento';
end;

function TBDRepositorioEquipamento.GetQueryBase: string;
begin
  Result := QUERY_BASE;
end;

procedure TBDRepositorioEquipamento.Salvar(pModelo: IModeloEquipamento);
begin
  inherited;

end;

function TBDRepositorioEquipamento.TryGet(const pNumeroSerial : string; out pModelo: IModeloEquipamento): Boolean;
begin
  pModelo := CriarModelo;

  Result := TryAbrirQueryECarregarModelo(QUERY_BASE + ' where serial = :serial',
    pModelo,
    procedure(pParametros: IBDParametros)
    begin
      pParametros.TrySetAsString('serial', pNumeroSerial);
    end);
end;

end.
