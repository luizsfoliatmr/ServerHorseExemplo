program ServerHorseBaseExemplo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  TFC.DefaultImplementations.PortuguesBR in 'modules\serverhorsebase\src\externos\TFC\Source\TFC.DefaultImplementations.PortuguesBR.pas',
  BD.Repositorio.Equipamento.Impl in 'Implementacoes\bd\BD.Repositorio.Equipamento.Impl.pas',
  BD.Repositorio.Usuario.Impl in 'Implementacoes\bd\BD.Repositorio.Usuario.Impl.pas',
  Controller.Equipamento.Impl in 'Implementacoes\controllers\Controller.Equipamento.Impl.pas',
  Controller.Usuario.Impl in 'Implementacoes\controllers\Controller.Usuario.Impl.pas',
  Modelo.Equipamento.Impl in 'Implementacoes\modelos\Modelo.Equipamento.Impl.pas',
  Modelo.Usuario.Impl in 'Implementacoes\modelos\Modelo.Usuario.Impl.pas',
  Regra.Equipamento.Impl in 'Implementacoes\regras\Regra.Equipamento.Impl.pas',
  Regra.Usuario.Impl in 'Implementacoes\regras\Regra.Usuario.Impl.pas',
  Modelo.Equipamento.Intf in 'interfaces\modelos\Modelo.Equipamento.Intf.pas',
  Modelo.Usuario.Intf in 'interfaces\modelos\Modelo.Usuario.Intf.pas',
  Regra.Equipamento.Intf in 'interfaces\regras\Regra.Equipamento.Intf.pas',
  Regra.Usuario.Intf in 'interfaces\regras\Regra.Usuario.Intf.pas',
  Repositorio.Equipamento.Intf in 'interfaces\repositorio\Repositorio.Equipamento.Intf.pas',
  Repositorio.Usuario.Intf in 'interfaces\repositorio\Repositorio.Usuario.Intf.pas',
  Registros.ServerBaseExemplo in 'registros\Registros.ServerBaseExemplo.pas';

begin

  ReportMemoryLeaksOnShutdown := True;

  TRegistradorImplementacoesServerBaseExemplo.Registrar;

  THorse.Get('ping',
    procedure(pRequest: THorseRequest; pResponse: THorseResponse)
    begin
      pResponse.Send('pong');
    end);

  THorse.Listen(9000,
    procedure
    begin
      Writeln('Server is runing on port ' + THorse.Port.ToString);
      Writeln('Press return to stop...');

{$IFDEF MSWINDOWS}
      Readln;
{$ELSE}
      while True do
      begin
        Sleep(100);
      end;
{$ENDIF}

      THorse.StopListen;
    end);

end.
