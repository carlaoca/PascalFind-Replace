inherited VKY_Definiciones_Simples_Con_Grillas_Frm: TVKY_Definiciones_Simples_Con_Grillas_Frm
  Left = 294
  Top = 148
  Caption = 'VKY_Definiciones_Simples_Con_Grillas_Frm'
  ExplicitLeft = 294
  ExplicitTop = 148
  ExplicitWidth = 1139
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel_botonera: TPanel
    inherited cancelar_boton: TBitBtn
      Top = 63
      ExplicitTop = 63
    end
    inherited eliminar_boton: TBitBtn
      Top = 110
      ExplicitTop = 110
    end
    inherited boton_guardar: TBitBtn
      Top = 232
      ExplicitTop = 232
    end
    inherited salir_boton: TBitBtn
      TabOrder = 8
    end
    inherited buscar_boton: TBitBtn
      Top = 185
      ExplicitTop = 185
    end
    inherited imprimir_boton: TBitBtn
      Top = 279
      ExplicitTop = 279
    end
    inherited ver_operaciones_log_boton: TBitBtn
      TabOrder = 7
    end
    object grupo_asiento_operacion: TGroupBox
      Left = 2
      Top = 435
      Width = 96
      Height = 78
      Align = alBottom
      Caption = 'Asiento Contable'
      Enabled = False
      TabOrder = 6
      Visible = False
      object operacion_con_o_sin_asieno_chk: TJvDBCheckBox
        Left = 2
        Top = 13
        Width = 89
        Height = 25
        Caption = 'ASENTADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object asentar_operacion_Boton: TBitBtn
        Left = 2
        Top = 37
        Width = 87
        Height = 36
        Caption = '&Asentar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = asentar_operacion_BotonClick
      end
    end
  end
  inherited grupo_registro: TGroupBox
    ExplicitLeft = 2
    ExplicitHeight = 441
    object grupo_objetos_definicion: TGroupBox
      Left = 2
      Top = 65
      Width = 917
      Height = 58
      Align = alTop
      TabOrder = 0
    end
    object grilla_definiciones: TJvDBUltimGrid
      Left = 2
      Top = 123
      Width = 917
      Height = 453
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clGreen
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      TitleButtons = True
      AlternateRowColor = clSkyBlue
      ShowCellHint = True
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.RealNamesOption = '[With the real field name]'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      AutoSizeRows = False
      RowResize = True
      RowsHeight = 20
      TitleRowHeight = 24
      SortWith = swFields
    end
    object footer_grilla_definiciones: TJvDBGridFooter
      Left = 2
      Top = 576
      Width = 917
      Height = 19
      Color = clMoneyGreen
      SizeGrip = True
      Columns = <>
      DBGrid = grilla_definiciones
    end
    object grupo_navegador_definicion: TGroupBox
      Left = 2
      Top = 15
      Width = 917
      Height = 50
      Align = alTop
      TabOrder = 3
      object navegador_definiciones: TDBNavigator
        Left = 2
        Top = 15
        Width = 913
        Height = 25
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
        Align = alTop
        Flat = True
        ConfirmDelete = False
        TabOrder = 0
      end
    end
  end
end
