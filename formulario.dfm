object frmCadastro: TfrmCadastro
  Left = 0
  Top = 0
  Caption = 'JSON, XML, Email, ClientDataSet - InfoSistemas'
  ClientHeight = 341
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblEndereco: TLabel
    Left = 152
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object lblmsg: TLabel
    Left = 283
    Top = 8
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtNome: TLabeledEdit
    Left = 8
    Top = 33
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 0
  end
  object edtIdentidadde: TLabeledEdit
    Left = 8
    Top = 71
    Width = 121
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Identidade'
    TabOrder = 1
  end
  object edtCPF: TLabeledEdit
    Left = 8
    Top = 110
    Width = 121
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'CPF'
    MaxLength = 11
    NumbersOnly = True
    TabOrder = 2
  end
  object edtTelefone: TLabeledEdit
    Left = 8
    Top = 148
    Width = 121
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Telefone'
    MaxLength = 13
    TabOrder = 3
    OnKeyPress = edtTelefoneKeyPress
  end
  object edtEmail: TLabeledEdit
    Left = 8
    Top = 186
    Width = 121
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Email'
    MaxLength = 250
    TabOrder = 4
  end
  object edtCEP: TLabeledEdit
    Left = 152
    Top = 41
    Width = 121
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'CEP'
    MaxLength = 8
    NumbersOnly = True
    TabOrder = 5
    OnExit = edtCEPExit
  end
  object edtLogradouro: TLabeledEdit
    Left = 152
    Top = 76
    Width = 121
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Logradouro'
    TabOrder = 6
  end
  object edtNumero: TLabeledEdit
    Left = 152
    Top = 118
    Width = 121
    Height = 21
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'N'#250'mero'
    MaxLength = 6
    TabOrder = 7
  end
  object edtComplemento: TLabeledEdit
    Left = 279
    Top = 41
    Width = 247
    Height = 21
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'Complemento'
    TabOrder = 8
  end
  object edtBairro: TLabeledEdit
    Left = 279
    Top = 76
    Width = 121
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Bairro'
    MaxLength = 240
    TabOrder = 9
  end
  object edtCidade: TLabeledEdit
    Left = 405
    Top = 76
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Cidade'
    MaxLength = 240
    TabOrder = 10
  end
  object edtEstado: TLabeledEdit
    Left = 279
    Top = 118
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Estado'
    MaxLength = 100
    TabOrder = 11
  end
  object edtPais: TLabeledEdit
    Left = 405
    Top = 118
    Width = 121
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'Pa'#237's'
    MaxLength = 80
    TabOrder = 12
  end
  object dbgrid: TDBGrid
    Left = 8
    Top = 213
    Width = 519
    Height = 120
    DataSource = ds
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 13
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Identidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Telefone'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Logradouro'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Numero'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Complemento'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Bairro'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Estado'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pais'
        Width = 150
        Visible = True
      end>
  end
  object btnCadastro: TButton
    Left = 152
    Top = 186
    Width = 180
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 14
    OnClick = btnCadastroClick
  end
  object btnRemover: TButton
    Left = 346
    Top = 186
    Width = 180
    Height = 25
    Caption = 'Remover'
    Enabled = False
    TabOrder = 15
    OnClick = btnRemoverClick
  end
  object btnLimparTudo: TButton
    Left = 152
    Top = 155
    Width = 374
    Height = 25
    Caption = 'Limpar Tudo'
    TabOrder = 16
    OnClick = btnLimparTudoClick
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 160
    Top = 288
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 240
    object cdsDadosNome: TStringField
      FieldName = 'Nome'
      Size = 120
    end
    object cdsDadosIdentidade: TStringField
      FieldName = 'Identidade'
      Size = 10
    end
    object cdsDadosCPF: TStringField
      FieldName = 'CPF'
      Size = 11
    end
    object cdsDadosTelefone: TStringField
      FieldName = 'Telefone'
      Size = 13
    end
    object cdsDadosCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object cdsDadosLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 240
    end
    object cdsDadosNumero: TStringField
      FieldName = 'Numero'
      Size = 6
    end
    object cdsDadosComplemento: TStringField
      FieldName = 'Complemento'
      Size = 240
    end
    object cdsDadosBairro: TStringField
      FieldName = 'Bairro'
      Size = 240
    end
    object cdsDadosCidade: TStringField
      FieldName = 'Cidade'
      Size = 240
    end
    object cdsDadosEstado: TStringField
      FieldName = 'Estado'
      Size = 100
    end
    object cdsDadosPais: TStringField
      FieldName = 'Pais'
      Size = 80
    end
    object cdsDadosEmail: TStringField
      FieldName = 'Email'
      Size = 250
    end
  end
  object ds: TDataSource
    DataSet = cdsDados
    Left = 312
    Top = 296
  end
  object IdSMTP: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL
    SASLMechanisms = <>
    UseTLS = utUseExplicitTLS
    Left = 256
    Top = 240
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 256
    Top = 288
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':25'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 160
    Top = 240
  end
end
