unit Modelo.Usuario.Intf;

interface

uses
  Modelo.Intf;

type
  IModeloUsuario = interface(IModeloID)
    ['{78063296-F079-49F0-9C91-23F0A0BF82C2}']

    function GetNome: string;
    procedure SetNome(const pValor: string);

    function GetEmail: string;
    procedure SetEmail(const pValor: string);

    function GetSenha: string;
    procedure SetSenha(const pValor: string);

    function GetAtivo: Boolean;
    procedure SetAtivo(const pValor: Boolean);

    property Nome: string read GetNome write SetNome;
    property Email: string read GetEmail write SetEmail;
    property Senha: string read GetSenha write SetSenha;
    property Ativo: Boolean read GetAtivo write SetAtivo;
  end;

implementation

end.
