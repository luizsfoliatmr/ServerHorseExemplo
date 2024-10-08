unit BD.Repositorio.NotaFiscal.Impl;

interface

uses
  BD.Repositorio.Impl,
  Repositorio.NotaFiscal.Intf,
  Modelo.NotaFiscal.Intf, Modelo.NotaFiscal.Impl;

type

  TBDRepositorioNotaFiscal = class(TBDRepositorio, IRepositorioNotaFiscal)
  public
    function Get(const CodigoEmpresa: Integer; const pChave: string; out ANotaFiscal : IModeloNotaFiscal) : Boolean;
  end;

implementation

{ TBDRepositorioNotaFiscal }

function TBDRepositorioNotaFiscal.Get(const CodigoEmpresa: Integer; const pChave: string; out ANotaFiscal : IModeloNotaFiscal) : Boolean;
begin

  var lDatasetNota := Conexao.AbrirQuery('select chave from notafiscal nf where nf.empresa = :empresa and nf.chave = :chave',
    procedure(pParametros: IBDParametros)
    begin
      pParametros.TrySetAsUInt32('empresa', CodigoEmpresa);
      pParametros.TrySetAsString('chave', pChave);
    end);

  var lDatasetItensNota := Conexao.AbrirQuery('select inf.nomeproduto, inf.quantidade from itemnotafiscal inf inner join notafiscal nf on nf.id = inf.notafiscal where nf.empresa = :empresa and nf.chave = :chave',
    procedure(pParametros: IBDParametros)
    begin
      pParametros.TrySetAsUInt32('empresa', CodigoEmpresa);
      pParametros.TrySetAsString('chave', pChave);
    end);

  Result := lDatasetNota.Next;

  if Result then
  begin
    ANotaFiscal := TModeloNotaFiscal.Create;
    ANotaFiscal.ChaveNotaFiscal := pChave;
    while lDatasetItensNota.Next do
    begin
      var lItem : IModeloItemNotaFiscal := TModeloItemNotaFiscal.Create;

      lItem.NomeProduto := lDatasetItensNota.Fields['nomeproduto'].AsString;
      lItem.Quantidade := lDatasetItensNota.Fields['quantidade'].AsCurrency;

      ANotaFiscal.Itens.Add(lItem);
    end;
  end;

end;

end.
