inherited VKY_Maestros_Detalles_Frm: TVKY_Maestros_Detalles_Frm
  Left = 295
  Top = 80
  Caption = 'VKY_Maestros_Detalles_Frm'
  ClientHeight = 607
  ClientWidth = 1138
  ExplicitLeft = 295
  ExplicitTop = 80
  ExplicitWidth = 1146
  ExplicitHeight = 634
  PixelsPerInch = 96
  TextHeight = 13
  inherited splitter_izquierda_derecha: TJvNetscapeSplitter
    Height = 607
    ExplicitHeight = 607
  end
  inherited Panel_botonera: TPanel
    Height = 607
    ExplicitHeight = 607
    inherited cancelar_boton: TBitBtn
      Top = 104
      ExplicitTop = 104
    end
    inherited eliminar_boton: TBitBtn
      Top = 151
      ExplicitTop = 151
    end
    inherited boton_guardar: TBitBtn
      Top = 243
      ExplicitTop = 243
    end
    inherited salir_boton: TBitBtn
      Top = 564
      TabOrder = 8
      ExplicitTop = 564
    end
    inherited buscar_boton: TBitBtn
      Top = 196
      ExplicitTop = 196
    end
    inherited imprimir_boton: TBitBtn
      Top = 290
      ExplicitTop = 290
    end
    object grupo_asiento_operacion: TGroupBox [7]
      Left = 2
      Top = 445
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
    inherited ver_operaciones_log_boton: TBitBtn
      Top = 523
      TabOrder = 7
      ExplicitTop = 523
    end
  end
  inherited grupo_buscador: TGroupBox
    Height = 607
    ExplicitHeight = 607
    inherited buscador_rapido_boton: TBitBtn
      Top = 564
      ExplicitTop = 564
    end
  end
  inherited grupo_registro: TGroupBox
    Width = 928
    Height = 607
    ExplicitWidth = 928
    ExplicitHeight = 607
    object grupo_cabecera: TGroupBox
      Left = 2
      Top = 15
      Width = 924
      Height = 211
      Align = alTop
      TabOrder = 0
    end
    object grupo_detalles: TGroupBox
      Left = 2
      Top = 375
      Width = 924
      Height = 230
      Align = alBottom
      TabOrder = 1
    end
  end
end
