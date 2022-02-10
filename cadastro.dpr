program cadastro;

uses
  Vcl.Forms,
  formulario in 'formulario.pas' {formularioCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformularioCadastro, formularioCadastro);
  Application.Run;
end.
