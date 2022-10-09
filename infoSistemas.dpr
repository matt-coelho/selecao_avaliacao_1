program infoSistemas;

uses
  Vcl.Forms,
  formulario in 'formulario.pas' {frmCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.Run;
end.
