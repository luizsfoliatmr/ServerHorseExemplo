unit Controller.Usuario.Impl;

interface

uses
  System.SysUtils,
  System.JSON,
  JOSE.Core.JWT,
  Horse,
  Controller.Modelo.Impl,
  Modelo.Usuario.Intf,
  Regra.Usuario.Intf;

type
  TControllerUsuario = class(TControllerModeloID<IModeloUsuario, IRegraUsuario>)
  strict private
    function CriarJWT(const pJWTSetup: TProc<TJWT>; const pSecondsTimeOut: UInt32 = 3600; const pChave: string = 'chave_temporaria'): string;
    procedure DoPostLogin(pRequest: THorseRequest; pResponse: THorseResponse);
    class procedure PostLogin(pRequest: THorseRequest; pResponse: THorseResponse);
  strict protected
    procedure CarregarModeloComJSON(pModelo: IModeloUsuario; const pJSON: TJSONObject); override;
    procedure CarregarJSONComModelo(const pJSON: TJSONObject; pModelo: IModeloUsuario); override;
  public
    class procedure Registrar;
  end;

implementation

uses
  System.DateUtils,
  JOSE.Core.Builder,
  Horse.JWT,
  Base.Helpers.Horse,
  TFC.Helpers,
  TFC.Implementations,
  TFC.Guard,
  Auxiliar.Log.Intf,
  Gerenciador.Sessao,
  Gerenciador.Sessao.Identificador;

{ TControllerUsuario }

procedure TControllerUsuario.CarregarJSONComModelo(const pJSON: TJSONObject; pModelo: IModeloUsuario);
begin
  inherited;

  pJSON.AddPair('nome', pModelo.Nome);
  pJSON.AddPair('email', pModelo.Email);
  pJSON.AddPair('ativo', pModelo.Ativo);
end;

procedure TControllerUsuario.CarregarModeloComJSON(pModelo: IModeloUsuario; const pJSON: TJSONObject);
begin
  inherited;

  pModelo.Nome := pJSON.GetValue<string>('nome');
  pModelo.Email := pJSON.GetValue<string>('email');
  pModelo.Ativo := pJSON.GetValue<Boolean>('ativo');

  var lSenha: string;
  if pJSON.TryGetValue<string>('senha', lSenha) then
  begin
    pModelo.Senha := lSenha;
  end;
end;

function TControllerUsuario.CriarJWT(const pJWTSetup: TProc<TJWT>; const pSecondsTimeOut: UInt32; const pChave: string): string;
var
  lJWT: TJWT;
begin
  lJWT := TJWT.Create;
  try
    lJWT.Claims.IssuedAt := Now;
    lJWT.Claims.Expiration := Now.IncSecond(pSecondsTimeOut);
    if Assigned(pJWTSetup) then
    begin
      pJWTSetup(lJWT);
    end;

    Result := TJOSE.SHA256CompactToken(pChave, lJWT);
  finally
    lJWT.Free;
  end;
end;

procedure TControllerUsuario.DoPostLogin(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  var lUsuarioAutorizado: Boolean;
  var lUsuario: IModeloUsuario;
  var lIdentificador : string;
  try
    var lJSONBody := pRequest.Body<TJSONObject>;
    var lEmail: string;
    var lSenha: string;

    if not pRequest.Headers.TryGetValue('identificador', lIdentificador) then
      RaiseBadRequest;

    if not lJSONBody.TryGetValue<string>('email', lEmail) or
      not lJSONBody.TryGetValue<string>('senha', lSenha) then
    begin
      RaiseBadRequest;
    end;

    TGerenciadorSessao.SetValor<string>(TGerenciadorSessaoIdentificador.GUID_IDENTIFICADOR, lIdentificador);

    lUsuarioAutorizado := Regra.TryValidar(lEmail, lSenha, lUsuario);
  except
    on E: Exception do
    begin
      TTFCImplementations.Get<ICentralLogs>.LogarErro('Erro de login.', E);

      lUsuarioAutorizado := False;
    end;
  end;

  if lUsuarioAutorizado then
  begin
    var lResposta := TJSONObject.Create;
    try
      lResposta.AddPair('jwt', CriarJWT(
        procedure(pJWT: TJWT)
        begin
          pJWT.Claims.SetClaimOfType<UInt32>('idUsuario', lUsuario.ID);
          pJWT.Claims.SetClaimOfType<string>('identificador', lIdentificador)
        end, 3600));
      var lJSONUsuario := TJSONObject.Create;
      lResposta.AddPair('usuario', lJSONUsuario);

      CarregarJSONComModelo(lJSONUsuario, lUsuario);
    except
      lResposta.Free;
      raise;
    end;

    pResponse
      .Send(lResposta)
      .Status(THTTPStatus.Created);
  end else
  begin
    raise EHorseException.New
      .Error('Usuário não autorizado')
      .Status(THTTPStatus.Forbidden);
  end;
end;

class procedure TControllerUsuario.PostLogin(pRequest: THorseRequest; pResponse: THorseResponse);
begin
  var lInstancia := Self.Create;
  try
    lInstancia.DoPostLogin(pRequest, pResponse);
  finally
    lInstancia.Free;
  end;
end;

class procedure TControllerUsuario.Registrar;
begin
  THorse.Post('/usuario/login', Self.PostLogin);
end;

end.
