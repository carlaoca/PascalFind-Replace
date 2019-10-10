object VKY_Find_And_Replace_VCL_To_UniGUI_FRM: TVKY_Find_And_Replace_VCL_To_UniGUI_FRM
  Left = 525
  Top = 152
  Caption = 'VKY_Find_And_Replace_VCL_To_UniGUI_FRM'
  ClientHeight = 473
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object boton_migrar: TButton
    Left = 0
    Top = 0
    Width = 559
    Height = 49
    Align = alTop
    Caption = '&Migrar'
    TabOrder = 0
    OnClick = boton_migrarClick
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 257
    Width = 559
    Height = 216
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 40
      Width = 555
      Height = 174
      Align = alClient
      DataSource = Vky_Clases_a_Modificar_UNIDAC_ds
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBNavigator1: TDBNavigator
      Left = 2
      Top = 15
      Width = 555
      Height = 25
      DataSource = Vky_Clases_a_Modificar_UNIDAC_ds
      Align = alTop
      TabOrder = 1
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 49
    Width = 559
    Height = 208
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 80
    ExplicitTop = 81
    object barra_progreso: TGauge
      Left = 272
      Top = 79
      Width = 100
      Height = 127
      Align = alRight
      Progress = 0
      ExplicitLeft = 368
      ExplicitTop = 24
      ExplicitHeight = 100
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 79
      Width = 239
      Height = 127
      Align = alLeft
      Caption = 'Cual Migrar ?'
      TabOrder = 0
      object rg_migrar_vcl_a_unigui: TRadioButton
        Left = 2
        Top = 15
        Width = 235
        Height = 17
        Align = alTop
        Caption = 'UniGUI'
        TabOrder = 0
        OnClick = rg_migrar_vcl_a_uniguiClick
      end
      object rg_migrar_ibx_a_unidac: TRadioButton
        Left = 2
        Top = 32
        Width = 235
        Height = 17
        Align = alTop
        Caption = 'UniDAC (desde IBX)'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rg_migrar_ibx_a_unidacClick
      end
      object rg_migrar_boqueron_a_yakare: TRadioButton
        Left = 2
        Top = 49
        Width = 235
        Height = 17
        Align = alTop
        Caption = 'Boqueron a Yakare (plantas, Campa'#241'as, etc)'
        TabOrder = 2
        OnClick = rg_migrar_boqueron_a_yakareClick
      end
      object rg_migrar_unidac_a_ibx: TRadioButton
        Left = 2
        Top = 66
        Width = 235
        Height = 17
        Align = alTop
        Caption = 'IBX (desde UniDAC)'
        TabOrder = 3
        OnClick = rg_migrar_unidac_a_ibxClick
        ExplicitLeft = 3
        ExplicitTop = 72
      end
    end
    object Memo1: TMemo
      Left = 372
      Top = 79
      Width = 185
      Height = 127
      Align = alRight
      Lines.Strings = (
        'Memo1')
      TabOrder = 1
      ExplicitLeft = 136
      ExplicitTop = 344
      ExplicitHeight = 89
    end
    object GroupBox2: TGroupBox
      Left = 2
      Top = 15
      Width = 555
      Height = 64
      Align = alTop
      Caption = 'Camino a Aplicacion + Directorio con Fuentes (.pas + .dfm)'
      TabOrder = 2
      object camino_archivo_a_cargar_text: TJvFilenameEdit
        Left = 2
        Top = 15
        Width = 551
        Height = 21
        Align = alTop
        Filter = 'FART Aplication  (fart.exe)|fart.exe'
        TabOrder = 0
      end
      object JvDirectoryEdit1: TJvDirectoryEdit
        Left = 2
        Top = 36
        Width = 551
        Height = 21
        Align = alTop
        DialogKind = dkWin32
        TabOrder = 1
        Text = 'JvDirectoryEdit1'
      end
    end
  end
  object IBDatabase: TIBDatabase
    Connected = True
    DatabaseName = '10.0.0.6:/VirginiaLAB/Datos/restaurador/vcl_to_unigui.fdb'
    Params.Strings = (
      'user_name=soporteviky'
      'password=dba2016'
      'lc_ctype=UTF8')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    Left = 280
    Top = 56
  end
  object IBTransaction: TIBTransaction
    DefaultDatabase = IBDatabase
    DefaultAction = TARollbackRetaining
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 280
    Top = 104
  end
  object Vky_Clases_a_Modificar_ds: TDataSource
    DataSet = Vky_Clases_a_Modificar
    Left = 184
    Top = 200
  end
  object Vky_Clases_a_Modificar: TIBTable
    Database = IBDatabase
    Transaction = IBTransaction
    AfterPost = Vky_Clases_a_ModificarAfterPost
    FieldDefs = <
      item
        Name = 'ID_CLASE_A_MODIFICAR'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMBRE_ORIGEN'
        DataType = ftString
        Size = 1024
      end
      item
        Name = 'NOMBRE_DESTINO'
        DataType = ftString
        Size = 1024
      end
      item
        Name = 'WILDCARD_1_PAS'
        DataType = ftString
        Size = 192
      end
      item
        Name = 'WILDCARD_2_DFM'
        DataType = ftString
        Size = 192
      end
      item
        Name = 'OBSERVACIONES'
        DataType = ftString
        Size = 1024
      end>
    IndexDefs = <
      item
        Name = 'PK_VKY_CLASES_A_MODIFICAR'
        Fields = 'ID_CLASE_A_MODIFICAR'
        Options = [ixUnique]
      end>
    IndexFieldNames = 'ID_CLASE_A_MODIFICAR'
    StoreDefs = True
    TableName = 'VKY_CLASES_A_MODIFICAR'
    Left = 176
    Top = 200
    object Vky_Clases_a_ModificarID_CLASE_A_MODIFICAR: TIntegerField
      FieldName = 'ID_CLASE_A_MODIFICAR'
    end
    object Vky_Clases_a_ModificarNOMBRE_ORIGEN: TIBStringField
      DisplayWidth = 20
      FieldName = 'NOMBRE_ORIGEN'
      Size = 1024
    end
    object Vky_Clases_a_ModificarNOMBRE_DESTINO: TIBStringField
      DisplayWidth = 20
      FieldName = 'NOMBRE_DESTINO'
      Size = 1024
    end
    object Vky_Clases_a_ModificarWILDCARD_1_PAS: TIBStringField
      FieldName = 'WILDCARD_1_PAS'
      Size = 192
    end
    object Vky_Clases_a_ModificarWILDCARD_2_DFM: TIBStringField
      FieldName = 'WILDCARD_2_DFM'
      Size = 192
    end
    object Vky_Clases_a_ModificarOBSERVACIONES: TIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 1024
    end
  end
  object Vky_Clases_a_Modificar_UNIDAC_ds: TDataSource
    DataSet = Vky_Clases_a_Modificar_UNIDAC
    Left = 40
    Top = 192
  end
  object Vky_Clases_a_Modificar_UNIDAC: TIBTable
    Database = IBDatabase
    Transaction = IBTransaction
    AfterPost = Vky_Clases_a_ModificarAfterPost
    FieldDefs = <
      item
        Name = 'ID_CLASE_A_MODIFICAR_UNIDAC'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMBRE_ORIGEN'
        DataType = ftString
        Size = 1024
      end
      item
        Name = 'NOMBRE_DESTINO'
        DataType = ftString
        Size = 1024
      end
      item
        Name = 'WILDCARD_1_PAS'
        DataType = ftString
        Size = 192
      end
      item
        Name = 'WILDCARD_2_DFM'
        DataType = ftString
        Size = 192
      end
      item
        Name = 'OBSERVACIONES'
        DataType = ftString
        Size = 1024
      end>
    IndexDefs = <
      item
        Name = 'RDB$PRIMARY2'
        Fields = 'ID_CLASE_A_MODIFICAR_UNIDAC'
        Options = [ixPrimary, ixUnique]
      end>
    IndexFieldNames = 'ID_CLASE_A_MODIFICAR_UNIDAC'
    StoreDefs = True
    TableName = 'VKY_CLASES_A_MODIFICAR_UNIDAC'
    Left = 56
    Top = 192
    object Vky_Clases_a_Modificar_UNIDACID_CLASE_A_MODIFICAR_UNIDAC: TIntegerField
      FieldName = 'ID_CLASE_A_MODIFICAR_UNIDAC'
      Required = True
    end
    object Vky_Clases_a_Modificar_UNIDACNOMBRE_ORIGEN: TIBStringField
      FieldName = 'NOMBRE_ORIGEN'
      Size = 1024
    end
    object Vky_Clases_a_Modificar_UNIDACNOMBRE_DESTINO: TIBStringField
      FieldName = 'NOMBRE_DESTINO'
      Size = 1024
    end
    object Vky_Clases_a_Modificar_UNIDACWILDCARD_1_PAS: TIBStringField
      FieldName = 'WILDCARD_1_PAS'
      Size = 192
    end
    object Vky_Clases_a_Modificar_UNIDACWILDCARD_2_DFM: TIBStringField
      FieldName = 'WILDCARD_2_DFM'
      Size = 192
    end
    object Vky_Clases_a_Modificar_UNIDACOBSERVACIONES: TIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 1024
    end
  end
  object Vky_Boqueron_a_Yakare_Ds: TDataSource
    DataSet = Vky_Boqueron_a_Yakare
    Left = 360
    Top = 136
  end
  object Vky_Boqueron_a_Yakare: TIBTable
    Database = IBDatabase
    Transaction = IBTransaction
    AfterPost = Vky_Clases_a_ModificarAfterPost
    FieldDefs = <
      item
        Name = 'ID_BOQUERON_A_YAKARE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMBRE_ORIGEN'
        DataType = ftString
        Size = 1024
      end
      item
        Name = 'NOMBRE_DESTINO'
        DataType = ftString
        Size = 1024
      end
      item
        Name = 'WILDCARD_1_PAS'
        DataType = ftString
        Size = 192
      end
      item
        Name = 'WILDCARD_2_DFM'
        DataType = ftString
        Size = 192
      end
      item
        Name = 'OBSERVACIONES'
        DataType = ftString
        Size = 1024
      end>
    IndexDefs = <
      item
        Name = 'RDB$PRIMARY3'
        Fields = 'ID_BOQUERON_A_YAKARE'
        Options = [ixPrimary, ixUnique]
      end>
    IndexFieldNames = 'ID_BOQUERON_A_YAKARE'
    StoreDefs = True
    TableName = 'VKY_BOQUERON_A_YAKARE'
    Left = 376
    Top = 136
    object Vky_Boqueron_a_YakareID_BOQUERON_A_YAKARE: TIntegerField
      FieldName = 'ID_BOQUERON_A_YAKARE'
      Required = True
    end
    object Vky_Boqueron_a_YakareNOMBRE_ORIGEN: TIBStringField
      FieldName = 'NOMBRE_ORIGEN'
      Size = 1024
    end
    object Vky_Boqueron_a_YakareNOMBRE_DESTINO: TIBStringField
      FieldName = 'NOMBRE_DESTINO'
      Size = 1024
    end
    object Vky_Boqueron_a_YakareWILDCARD_1_PAS: TIBStringField
      FieldName = 'WILDCARD_1_PAS'
      Size = 192
    end
    object Vky_Boqueron_a_YakareWILDCARD_2_DFM: TIBStringField
      FieldName = 'WILDCARD_2_DFM'
      Size = 192
    end
    object Vky_Boqueron_a_YakareOBSERVACIONES: TIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 1024
    end
  end
  object Vky_UNidac_a_IBX_Tabla_ds: TDataSource
    DataSet = Vky_UNidac_a_IBX_Tabla
    Left = 448
    Top = 192
  end
  object Vky_UNidac_a_IBX_Tabla: TIBTable
    Database = IBDatabase
    Transaction = IBTransaction
    AfterPost = Vky_Clases_a_ModificarAfterPost
    FieldDefs = <
      item
        Name = 'ID_CLASE_A_MODIFICAR'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMBRE_ORIGEN'
        DataType = ftWideString
        Size = 1024
      end
      item
        Name = 'NOMBRE_DESTINO'
        DataType = ftWideString
        Size = 1024
      end
      item
        Name = 'WILDCARD_1_PAS'
        DataType = ftWideString
        Size = 192
      end
      item
        Name = 'WILDCARD_2_DFM'
        DataType = ftWideString
        Size = 192
      end
      item
        Name = 'OBSERVACIONES'
        DataType = ftWideString
        Size = 1024
      end>
    IndexDefs = <
      item
        Name = 'RDB$PRIMARY5'
        Fields = 'ID_CLASE_A_MODIFICAR'
        Options = [ixPrimary, ixUnique]
      end>
    IndexFieldNames = 'ID_CLASE_A_MODIFICAR'
    StoreDefs = True
    TableName = 'VKY_UNIDAC_A_IBX'
    Left = 464
    Top = 192
    object Vky_UNidac_a_IBX_TablaID_CLASE_A_MODIFICAR: TIntegerField
      FieldName = 'ID_CLASE_A_MODIFICAR'
      Required = True
    end
    object Vky_UNidac_a_IBX_TablaNOMBRE_ORIGEN: TIBStringField
      FieldName = 'NOMBRE_ORIGEN'
      Size = 1024
    end
    object Vky_UNidac_a_IBX_TablaNOMBRE_DESTINO: TIBStringField
      FieldName = 'NOMBRE_DESTINO'
      Size = 1024
    end
    object Vky_UNidac_a_IBX_TablaWILDCARD_1_PAS: TIBStringField
      FieldName = 'WILDCARD_1_PAS'
      Size = 192
    end
    object Vky_UNidac_a_IBX_TablaWILDCARD_2_DFM: TIBStringField
      FieldName = 'WILDCARD_2_DFM'
      Size = 192
    end
    object Vky_UNidac_a_IBX_TablaOBSERVACIONES: TIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 1024
    end
  end
end
