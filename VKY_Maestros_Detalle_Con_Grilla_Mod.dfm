inherited VKY_Maestros_Detalle_Con_Grilla_Frm: TVKY_Maestros_Detalle_Con_Grilla_Frm
  Left = 314
  Top = 101
  Caption = 'VKY_Maestros_Detalle_Con_Grilla_Frm'
  ClientHeight = 520
  ExplicitLeft = 314
  ExplicitTop = 101
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 13
  inherited splitter_izquierda_derecha: TJvNetscapeSplitter
    Height = 520
    ExplicitHeight = 520
  end
  inherited Panel_botonera: TPanel
    Height = 520
    ExplicitHeight = 520
    inherited salir_boton: TBitBtn
      Top = 477
      ExplicitTop = 477
    end
    inherited grupo_asiento_operacion: TGroupBox
      Top = 358
      ExplicitTop = 310
    end
    inherited ver_operaciones_log_boton: TBitBtn
      Top = 436
      ExplicitLeft = 6
      ExplicitTop = 402
      ExplicitWidth = 96
    end
  end
  inherited grupo_buscador: TGroupBox
    Height = 520
    ExplicitHeight = 520
    inherited buscador_rapido_boton: TBitBtn
      Top = 477
      ExplicitTop = 477
    end
  end
  inherited grupo_registro: TGroupBox
    Height = 520
    ExplicitHeight = 520
    inherited grupo_detalles: TGroupBox
      Top = 230
      Height = 288
      ExplicitTop = 232
      ExplicitHeight = 288
      object footer_grilla_detalle: TJvDBGridFooter
        Left = 2
        Top = 267
        Width = 920
        Height = 19
        Color = clMoneyGreen
        SizeGrip = True
        Columns = <>
        DBGrid = grilla_detalle
      end
      object grilla_detalle: TJvDBUltimGrid
        Left = 2
        Top = 131
        Width = 920
        Height = 136
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
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
      object grupo_objetos_detalle: TGroupBox
        Left = 2
        Top = 74
        Width = 920
        Height = 57
        Align = alTop
        TabOrder = 2
      end
      object grupo_navegador_grilla_detalle: TGroupBox
        Left = 2
        Top = 15
        Width = 920
        Height = 59
        Align = alTop
        TabOrder = 3
        object navegador_detalle: TDBNavigator
          Left = 2
          Top = 15
          Width = 916
          Height = 40
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbCancel, nbRefresh]
          Align = alTop
          Flat = True
          ConfirmDelete = False
          TabOrder = 0
        end
      end
    end
  end
end
