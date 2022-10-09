{
2.Criar uma tela de cadastro de clientes, com os seguintes campos:
-Dados do Cadastro:
Nome, Identidade, CPF, Telefone, Email, Endereço, Cep, Logradouro,
Numero, Complemento, Bairro, Cidade, Estado, Pais
3.Ao informar um Cep o sistema deve realizar a busca dos dados relacionados ao mesmo no seguinte endereço: https://viacep.com.br/;
4.A forma de consumo da API do via Cep, deverá ser utilizando JSON;
5.Ao termino do cadastro o usuário deverá enviar um e-mail contendo as informações cadastrais e anexar um arquivo no formato XML com o mesmo conteúdo;
6.Os registros devem ficar salvo em memória, não é necessário criar um banco de dados ou arquivo para o armazenamento dos dados;
}
unit formulario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, FireDAC.Stan.StorageJSON, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, IdMessage, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TfrmCadastro = class(TForm)
    edtNome: TLabeledEdit;
    edtIdentidadde: TLabeledEdit;
    edtCPF: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    edtEmail: TLabeledEdit;
    lblEndereco: TLabel;
    edtCEP: TLabeledEdit;
    edtLogradouro: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtPais: TLabeledEdit;
    IdHTTP1: TIdHTTP;
    lblmsg: TLabel;
    cdsDados: TClientDataSet;
    cdsDadosNome: TStringField;
    cdsDadosIdentidade: TStringField;
    cdsDadosCPF: TStringField;
    cdsDadosTelefone: TStringField;
    cdsDadosCEP: TStringField;
    cdsDadosLogradouro: TStringField;
    cdsDadosNumero: TStringField;
    cdsDadosComplemento: TStringField;
    cdsDadosBairro: TStringField;
    cdsDadosCidade: TStringField;
    cdsDadosEstado: TStringField;
    cdsDadosPais: TStringField;
    dbgrid: TDBGrid;
    ds: TDataSource;
    btnCadastro: TButton;
    btnRemover: TButton;
    cdsDadosEmail: TStringField;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    btnLimparTudo: TButton;
    procedure edtCEPExit(Sender: TObject);
    procedure limpaEndereco;
    procedure limpaDadosPessoais;
    procedure btnCadastroClick(Sender: TObject);
    procedure edtTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure btnRemoverClick(Sender: TObject);
    procedure IRbtnRemover;
    procedure createXML;
    procedure enviaEmail;
    procedure FormShow(Sender: TObject);
    procedure btnLimparTudoClick(Sender: TObject);
    procedure saveJson;
    procedure readXML(path:string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

uses
  system.json, XMLIntf, xmldoc, IdEMailAddress, IdGlobal, IdAttachmentFile, System.IOUtils;

{$R *.dfm}

procedure TfrmCadastro.btnCadastroClick(Sender: TObject);
var email:string;
begin
  lblmsg.Caption := '';

  cdsDados.Append;
  cdsDadosNome.Value := edtNome.Text;
  cdsDadosIdentidade.Value := edtIdentidadde.Text;
  cdsDadosCPF.Value := edtCPF.Text;
  cdsDadosTelefone.Value := edtTelefone.Text;
  cdsDadosEmail.Value := edtEmail.Text;
  cdsDadosCEP.Value := edtCEP.Text;
  cdsDadosLogradouro.Value := edtLogradouro.Text;
  cdsDadosNumero.Value := edtNumero.Text;
  cdsDadosComplemento.Value := edtComplemento.Text;
  cdsDadosBairro.Value := edtBairro.Text;
  cdsDadosCidade.Value := edtCidade.Text;
  cdsDadosEstado.Value := edtEstado.Text;
  cdsDadosPais.Value := edtPais.Text;
  cdsDados.Post;

  cdsDados.Close;
  cdsDados.Open;
  cdsDados.Last;
  IRbtnRemover;

  limpaEndereco;
  limpaDadosPessoais;

  createXML;

  email := edtEmail.Text;
  if (not email.IsEmpty) and (email.Contains('@')) then
   enviaEmail;
end;

procedure TfrmCadastro.btnLimparTudoClick(Sender: TObject);
begin
  limpaDadosPessoais;
  limpaEndereco;
end;

procedure TfrmCadastro.btnRemoverClick(Sender: TObject);
begin
  edtNome.Text := cdsDadosNome.Value;
  edtIdentidadde.Text := cdsDadosIdentidade.Value;
  edtCPF.Text := cdsDadosCPF.Value;
  edtTelefone.Text := cdsDadosTelefone.Value;
  edtEmail.Text := cdsDadosEmail.Value;
  edtCEP.Text := cdsDadosCEP.Value;
  edtLogradouro.Text := cdsDadosLogradouro.Value;
  edtNumero.Text := cdsDadosNumero.Value;
  edtComplemento.Text := cdsDadosComplemento.Value;
  edtBairro.Text := cdsDadosBairro.Value;
  edtCidade.Text := cdsDadosCidade.Value;
  edtEstado.Text := cdsDadosEstado.Value;
  edtPais.Text := cdsDadosPais.Value;

  cdsDados.Delete;
  cdsDados.Close;
  cdsDados.Open;
  cdsDados.Last;

  IRbtnRemover;
end;

procedure TfrmCadastro.edtCEPExit(Sender: TObject);
var
  cep: string;
  resposta: TStringStream;
  enderecoJSON: TJSonValue;
begin
  cep := edtCEP.Text;
  lblmsg.Caption := '';
  limpaEndereco;
  if (not cep.IsEmpty) and (cep.Length = 8) and (not cep.Contains(' ')) then
  begin
    IdHTTP1.HandleRedirects := true;
    resposta := TStringStream.Create;
    try
      IdHTTP1.Get('http://www.viacep.com.br/ws/' + cep + '/json/', resposta);
      if IdHTTP1.ResponseCode = 200 then
      begin
        enderecoJSON := TJsonObject.ParseJSONValue(resposta.DataString);
        try
          if resposta.DataString.Contains('erro') then
            lblmsg.Caption := 'CEP inválido'
          else
          begin
            edtLogradouro.Text := enderecoJSON.GetValue<string>('logradouro');
            edtBairro.Text := enderecoJSON.GetValue<string>('bairro');
            edtCidade.Text := enderecoJSON.GetValue<string>('localidade');
            edtEstado.Text := enderecoJSON.GetValue<string>('uf');

            edtComplemento.Text := enderecoJSON.GetValue<string>('complemento');
            edtCEP.Text := cep;
            edtNumero.SetFocus;

            saveJson;
          end;
        except
          lblMSG.caption := 'CEP digitado não existe';
        end;
      end;
    except
      lblmsg.Caption := 'viacep erro cod ' + IdHTTP1.ResponseCode.ToString;
    end;
  end
  else
    lblMSG.caption := 'CEP incompleto ou em branco';
end;

procedure TfrmCadastro.edtTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', '(', ')']) then
    Key := #0;
end;

procedure TfrmCadastro.FormShow(Sender: TObject);
var dir, path:string;
begin
  cdsDados.Close;
  cdsDados.CreateDataSet;

  edtNome.SetFocus;

  dir := GetCurrentDir;
  if DirectoryExists(dir+'/xml') then
  begin
    for path in Tdirectory.GetFiles(dir+'/xml') do
    begin
      if path.Contains('.xml') then
        readxml(path);
    end;
  end;
end;

procedure TfrmCadastro.limpaEndereco;
begin
  edtPais.Clear;
  edtEstado.Clear;
  edtCidade.Clear;
  edtBairro.Clear;
  edtComplemento.Clear;
  edtNumero.Clear;
  edtLogradouro.Clear;
  edtCEP.Clear;
end;

procedure TfrmCadastro.limpaDadosPessoais;
begin
  edtNome.Clear;
  edtCPF.Clear;
  edtIdentidadde.Clear;
  edtTelefone.Clear;
  edtEmail.Clear;
end;

procedure TfrmCadastro.IRbtnRemover;
begin
  if cdsDados.RecordCount = 0 then
    btnRemover.Enabled := false
  else
    btnRemover.Enabled := true;
end;

procedure TfrmCadastro.createXML;
var
  XML: IXMLDocument;
  root, node, inode: IXMLNode;
begin
  XML := newxmldocument;
  XML.Encoding := 'UTF-8';
  root := XML.AddChild('Usuario');
  node := root.AddChild('Identificacao');

  inode := node.AddChild('Nome');
  inode.Text := cdsDadosNome.Text;
  inode := node.AddChild('Identidade');
  inode.Text := cdsDadosIdentidade.Text;
  inode := node.AddChild('CPF');
  inode.Text := cdsDadosCPF.Text;
  inode := node.AddChild('Telefone');
  inode.Text := cdsDadosTelefone.Text;
  inode := node.AddChild('Email');
  inode.Text := cdsDadosEmail.Text;
  //
  node := root.AddChild('Endereco');

  inode := node.AddChild('CEP');
  inode.Text := cdsDadosCEP.Text;
  inode := node.AddChild('Logradouro');
  inode.Text := cdsDadosLogradouro.Text;
  inode := node.AddChild('Numero');
  inode.Text := cdsDadosNumero.Text;
  inode := node.AddChild('Complemento');
  inode.Text := cdsDadosComplemento.Text;
  inode := node.AddChild('Bairro');
  inode.Text := cdsDadosBairro.Text;
  inode := node.AddChild('Cidade');
  inode.Text := cdsDadosCidade.Text;
  inode := node.AddChild('Estado');
  inode.Text := cdsDadosEstado.Text;
  inode := node.AddChild('Pais');
  inode.Text := cdsDadosPais.Text;

  if DirectoryExists(GetCurrentDir + '/xml') then
    XML.SaveToFile(GetCurrentDir + '/xml/' + cdsDadosCPF.Text + '.xml')
  else
  begin
    CreateDir(GetCurrentDir + '\xml');
    XML.SaveToFile(GetCurrentDir + '/xml/' + cdsDadosCPF.Text + '.xml');
  end;
end;

procedure TfrmCadastro.saveJson;
var jsonObject: TJSONObject;
    jsonArray: TJSONArray;
    jsonPair:TJSONPair;
    json:TStringList;
    dir:string;
begin
  jsonObject := TJSONObject.Create;
  jsonArray := TJSONArray.Create();
  jsonPair := TJSONPair.Create('viacep', jsonArray);

  jsonObject.AddPair(TJSONPair.Create('cep', edtCEP.Text));
  jsonObject.AddPair(TJSONPair.Create('logradouro', edtLogradouro.Text));
  jsonObject.AddPair(TJSONPair.Create('bairro', edtBairro.Text));
  jsonObject.AddPair(TJSONPair.Create('cidade', edtCidade.Text));
  jsonObject.AddPair(TJSONPair.Create('estado', edtEstado.Text));
  jsonArray.AddElement(jsonObject);

  json := TStringList.Create;
  json.Add(jsonArray.ToJSON);

  dir := GetCurrentDir;
  if DirectoryExists(dir+'/json') then
    json.SaveToFile(dir+'/json/'+edtCEP.Text+'.json')
  else
  begin
    CreateDir(dir+'/json');
    json.SaveToFile(dir+'/json/'+edtCEP.Text+'.json');
  end;
end;

procedure TfrmCadastro.readXML(path:string);
var xml:TXMLDocument;
    root, child:IXMLNode;
    number:integer;
begin
  xml := TXMLDocument.Create(Application);
  xml.LoadFromFile(path);
  xml.Active := true;
  root := xml.DocumentElement; //usuario, main node or root node
  //field names are case sensitive, indexes also can be used
  child := root.ChildNodes['Identificacao']; //'identificacao'/0
  //number := child.ChildNodes.Count; //use to know the number of items

  cdsDados.Append;
  cdsDadosNome.Value := child.ChildNodes['Nome'].Text;
  cdsDadosIdentidade.Value := child.ChildNodes['Identidade'].text;
  cdsDadosCPF.Value := child.ChildNodes['CPF'].text;
  cdsDadosTelefone.Value := child.ChildNodes['Telefone'].text;
  cdsDadosEmail.Value := child.ChildNodes['Email'].text;

  child := root.ChildNodes['Endereco']; //'Endereco'/1
  cdsDadosCEP.Value := child.ChildNodes['CEP'].text;
  cdsDadosLogradouro.Value := child.ChildNodes['Logradouro'].text;
  cdsDadosNumero.Value := child.ChildNodes['Numero'].text;
  cdsDadosComplemento.Value := child.ChildNodes['Complemento'].text;
  cdsDadosBairro.Value := child.ChildNodes['Bairro'].text;
  cdsDadosCidade.Value := child.ChildNodes['Cidade'].Text;
  cdsDadosEstado.Value := child.ChildNodes['Estado'].text;
  cdsDadosPais.Value := child.ChildNodes['Pais'].text;
  cdsDados.Post;

  cdsDados.Close;
  cdsDados.Open;
end;

procedure TfrmCadastro.enviaEmail;
var
    anexo: TIdAttachmentFile;
    usmtp, porta, email, senha, dnome, demail, assunto, afile:string;
    msg:TStringList;
begin
  usmtp := 'smtp-mail.outlook.com';
  porta := '587';
  email := 'EMAIL';
  senha := 'SENHA DO EMAIL/EMAIL PASSWORD';
  demail := cdsDadosEmail.Text;
  dnome := cdsDadosNome.Text;
  assunto := 'Dados usuario codigo '+cdsDadosCPF.Text;
  afile := GetCurrentDir+'/xml/'+cdsDadosCPF.Text+'.xml';

  msg := TStringList.Create;
  msg.Add('Nome: '+dnome +#13);
  msg.Add('Identidade:'+cdsDadosIdentidade.Text +#13);
  msg.Add('CPF:'+cdsDadosCPF.Text +#13);
  msg.Add('Telefone:'+cdsDadosTelefone.Text +#13);
  msg.Add('Email:'+demail +#13);
  msg.Add('CEP:'+ cdsDadosCEP.Text +#13);
  msg.Add('Logradouro:'+cdsDadosLogradouro.Text +#13);
  msg.Add('Numero:'+cdsDadosNumero.Text +#13);
  msg.Add('Complemento:'+cdsDadosComplemento.Text +#13);
  msg.Add('Bairro:'+cdsDadosBairro.Text +#13);
  msg.Add('Cidade:'+cdsDadosCidade.Text +#13);
  msg.Add('Estado:'+cdsDadosEstado.Text +#13);
  msg.Add('Pais:'+cdsDadosPais.Text +#13+#13);
  msg.Add('XML anexo');

  with IdSSLIOHandlerSocketOpenSSL do
  begin
    Destination := usmtp+':'+porta;
    Host := usmtp;
    MaxLineAction := maException;
    Port := StrToInt(porta);
    SSLOptions.Method := sslvTLSv1;
    SSLOptions.Mode := sslmUnassigned;
    SSLOptions.VerifyMode := [];
    SSLOptions.VerifyDepth := 0;
  end;

  IdMessage.Clear;
  anexo := TIdAttachmentFile.Create(IdMessage.MessageParts, afile);
  with IdMessage do
  begin
    Recipients.Add.Address := demail;
    From.Address := email;
    Subject := assunto;
    Body := msg;
    Priority := mpHigh;
  end;

  with idsmtp do
  begin
    Host := usmtp;
    Port := StrToInt(porta);
    Username := email;
    Password := senha;
    IOHandler := IdSSLIOHandlerSocketOpenSSL;
    AuthType := satDefault;
    UseTLS := utUseRequireTLS;
  end;

  try
    with idsmtp do
    begin
      Connect;
      Send(IdMessage);
      lblmsg.Caption := 'enviado por email';
      Disconnect();
    end;
  except
    lblmsg.Caption := 'erro ao enviar email';
    idsmtp.Disconnect();
  end;
  anexo.Free;
  msg.Free;
end;

end.

