unit VKY_Definiciones_Simples_Con_Grillas_Mod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBActns, ActnList, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  DBCtrls, ImgList, Menus,
  VKY_Definiciones_Simples_Mod,
  JvExExtCtrls, JvNetscapeSplitter, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  JvDBGridFooter, JvDBCheckBox;

type
  TVKY_Definiciones_Simples_Con_Grillas_Frm = class(TVKY_Definiciones_Simples_Frm)
    grupo_objetos_definicion: TGroupBox;
    grilla_definiciones: TJvDBUltimGrid;
    footer_grilla_definiciones: TJvDBGridFooter;
    grupo_navegador_definicion: TGroupBox;
    grupo_asiento_operacion: TGroupBox;
    operacion_con_o_sin_asieno_chk: TJvDBCheckBox;
    asentar_operacion_Boton: TBitBtn;
    navegador_definiciones: TDBNavigator;
    procedure procedimientos_adicionales_al_crear_form(); override;
    procedure procedimientos_adicionales_al_salir(); override;
    procedure liberar_footers_de_datasets();
    procedure setear_colores_de_objetos();
    procedure determinar_si_se_puede_asentar_o_no_desde_este_Form(); virtual;
    procedure recalcular_si_operacion_esta_asentada(); virtual;
    procedure asentar_operacion_BotonClick(Sender: TObject); virtual;
    procedure accion_guardar_todos_los_registrosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    //    There are three ways to deallocate the memory associates with a dynamic array, a:
    //    SetLength(a, 0);
    //    Finalize(a);
    //    a := nil;

    //   una pregunta, que la dejo registrada el 2017/02/15 es:
    //   si esta bien que estas definiciones sigan aqui como publicas, o las deberiamos de meter como Variables de la clase.

    array_objetos_grillas_jedi: array[0..20] of TJvDBUltimGrid;
    //array_objetos_grillas_jedi: array of TJvDBUltimGrid;

    //tope_cantidad_grillas_jedi: Integer; //se llevo a vky_definiciones_simples

    array_objetos_footers_jedi: array[0..20] of TJvDBGridFooter;
    //array_objetos_footers_jedi: array of TJvDBGridFooter;
    //tope_cantidad_footers_jedi: Integer; //se llevo a vky_definiciones_simples

    el_form_permite_o_no_asentar : Boolean;
    { Public declarations }
  end;

var
  VKY_Definiciones_Simples_Con_Grillas_Frm: TVKY_Definiciones_Simples_Con_Grillas_Frm;

implementation
uses
  Virginia_Recursos_Mod,
  Declaraciones_Generales_Mod,
  Funciones_Generales_Mod,
  ModuloDatosMod;

{$R *.dfm}
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.procedimientos_adicionales_al_crear_form();
begin
  // en el caso de que algun form, no tenga querys o no tenga datasets, para no
  //tener violacion de memoria al recorrer el array.
  //tope_cantidad_grillas_jedi := -1; //se llevo a vky_definiciones_simples
  //tope_cantidad_footers_jedi := -1; //se llevo a vky_definiciones_simples

  self.setear_colores_de_objetos();

  //auto maximizar
  self.WindowState := wsMaximized;

  //determinar si el FOrm/Modulo, puede asentar la operacion.
  self.el_form_permite_o_no_asentar := False;
  self.determinar_si_se_puede_asentar_o_no_desde_este_Form();

  //si el proceso anterior, determino que se asienta o NO, aqui seteo las mismas propiedades, booleanas
  self.grupo_asiento_operacion.Enabled := el_form_permite_o_no_asentar;
  self.grupo_asiento_operacion.Visible := el_form_permite_o_no_asentar;

  //determinar si el Form/Modulo, usa o no el buscador lateral.
  self.determinar_si_se_usa_o_no_el_buscador_lateral_rapido_en_este_Form();

  //si el proceso anterior, determino que se asienta o NO, aqui seteo las mismas propiedades, booleanas
  self.grupo_buscador.Enabled := el_form_utiliza_o_no_buscador_lateral_rapido;
  self.grupo_buscador.Visible := el_form_utiliza_o_no_buscador_lateral_rapido;

  //si se va a usar el buscador lateral, el otro boton buscador, no lo haremos.
  if (el_form_utiliza_o_no_buscador_lateral_rapido = True) then
  begin
    buscar_boton.Enabled := False;
    buscar_boton.Visible := False;
  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.procedimientos_adicionales_al_salir();
begin
  self.liberar_footers_de_datasets();
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.setear_colores_de_objetos();
var
  i:Integer;
begin
try
  //Si todavia no se cargo la variable, entonces hay que cargarla
  if (Declaraciones_Generales_Mod.color_alterno_de_Filas_en_grillas = '') then
  begin
    Declaraciones_Generales_Mod.color_alterno_de_Filas_en_grillas :=
    Funciones_Generales_Mod.cargar_variable_global('color_alterno_de_Filas_en_grillas', 2,
    ModuloDatos.Transaccion, 'color_alterno_grilla');

    Declaraciones_Generales_Mod.color_de_footers_de_grillas :=
    Funciones_Generales_Mod.cargar_variable_global('color_de_footers_de_grillas', 2,
    ModuloDatos.Transaccion, 'color_footer');
  end;

  //1ro. Recorrida, para el seteo de los colores alternos en las grillas.
  for  i := 0 to tope_cantidad_grillas_jedi  do
    begin
      array_objetos_grillas_jedi[i].AlternateRowColor := StringToColor(color_alterno_de_Filas_en_grillas);
    end;

  //1ro. Recorrida, para el seteo de los colores alternos en las grillas.
  for  i := 0 to tope_cantidad_footers_jedi  do
    begin
      array_objetos_footers_jedi[i].Color := StringToColor(color_de_footers_de_grillas);
    end;

  except
  on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.liberar_footers_de_datasets();
var
  i:Integer;
begin
try
  //1ro. Recorrida, para el seteo de los colores alternos en las grillas.
  for  i := 0 to tope_cantidad_footers_jedi  do
    begin
      //voy a matarles su data source
      array_objetos_footers_jedi[i].DataSource := NIL;
      //voy a matarles su DBGrid
      array_objetos_footers_jedi[i].DBGrid := NIL;
    end;

  except
  on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;
//----------------------------------------------------------------------------//
{Aqui deberiamos de consultar por una query, con datos del sistema, que nos va a determinar,
si la combinacion Empresa/Modulo/Role, esta habilitado para asentar desde la operacion.
Este procedimiento, finalmente va a sertear una variable boolena a true o false,
que es la que usaremos en el resto del form.}
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.determinar_si_se_puede_asentar_o_no_desde_este_Form();
begin

end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.recalcular_si_operacion_esta_asentada();
begin
//ejemplo, de OP.
// //el tema de si ya tiene o no asiento.
//  //1) cerrar la query
//  Ordenes_Pago_MD_Frm.op_tiene_asiento_qry.Close;
//
//  //2) parametrizamos la query
//  Ordenes_Pago_MD_Frm.op_tiene_asiento_qry.ParamByName('ID_ORDEN_PAGO').AsInteger := Ordenes_Pago_MD_Frm.ord_pago_pag_provee_DSet.FieldByName('ID_ORDEN_PAGO').AsInteger;
//
//  //3) Abrimos la query
//  Ordenes_Pago_MD_Frm.op_tiene_asiento_qry.Open;
//
//  //4) Coloreamos el Componente segun sea el resulado del Field Cantidad.
//  if (    (Ordenes_Pago_MD_Frm.op_tiene_asiento_qry.FieldByName('cantidad').AsInteger = 0 )
//       or (Ordenes_Pago_MD_Frm .op_tiene_asiento_qry.FieldByName('cantidad').IsNull ) ) then
//    begin
//      ////colores, de avisos
//      Self.operacion_con_o_sin_asieno_chk.Font.Color := clRed;
//    end
//  else
//    begin
//      ////colores, de avisos
//      Self.operacion_con_o_sin_asieno_chk.Font.Color := clGreen;
//    end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.accion_guardar_todos_los_registrosExecute(
  Sender: TObject);
begin
  inherited;

  if (Self.boton_guardar.Enabled = False) then
    Self.navegador_definiciones.Enabled := True;
end;

procedure TVKY_Definiciones_Simples_Con_Grillas_Frm.asentar_operacion_BotonClick(Sender: TObject);
begin
//ejemplo, de OP.
//  try
//  inherited;
//  try
//    //crear modulo de datos, de asientos
//    Asientos_MD_Frm := TAsientos_MD_Frm.Create(self);
//
//    if (    (Ordenes_Pago_MD_Frm.op_tiene_asiento_qry.FieldByName('cantidad').AsInteger = 0 )
//         or (Ordenes_Pago_MD_Frm.op_tiene_asiento_qry.FieldByName('cantidad').IsNull ) ) then
//      begin
//        //llamar a procedimiento que carga el asiento.
//        Asientos_MD_Frm.asentar_ordenes_pagos_sp.Close;
//        Asientos_MD_Frm.asentar_ordenes_pagos_sp.ParamByName('ID_ORDEN_PAGO_P').AsInteger := Ordenes_Pago_MD_Frm.ord_pago_pag_provee_DSet.fieldbyname('ID_ORDEN_PAGO').AsInteger;
//        Asientos_MD_Frm.asentar_ordenes_pagos_sp.ExecProc;
//
//        Asientos_MD_Frm.transaccion_asientos.CommitRetaining;
//      end;
//
//    //crear form, de asientos.
//    Asientos_Frm := TAsientos_Frm.Create(self);
//    Asientos_Frm.Modulo_Datos_Relacionado := Asientos_MD_Frm;
//    Asientos_Frm.Transaccion_relacionada := Asientos_MD_Frm.transaccion_asientos;
//
//    //reejecutar la busqueda de dicho form, pero para que ubique esta NCR.
//    Asientos_MD_Frm.buscador_qry.Close;
//    Asientos_MD_Frm.buscador_qry.SQL.Clear;
//    Asientos_MD_Frm.buscador_qry.SQL.Text := Asientos_MD_Mod.select_buscador_x_modulos_op;
//    Asientos_MD_Frm.buscador_qry.ParamByName('ID_ORDEN_PAGO_P').AsInteger := Ordenes_Pago_MD_Frm.ord_pago_pag_provee_DSet.fieldbyname('ID_ORDEN_PAGO').AsInteger;
//    Asientos_MD_Frm.buscador_qry.Open;
//
//    Asientos_Frm.tipo_comportamiento := 3; //asientos automaticos, de otros modulos.
//    Asientos_Frm.modulo_a_asentar := 1;    //ordenes de pago.
//    Asientos_Frm.id_del_registro_en_cuestion := Ordenes_Pago_MD_Frm.ord_pago_pag_provee_DSet.fieldbyname('ID_ORDEN_PAGO').AsInteger;
//    Asientos_Frm.procedimientos_iniciales_post_Creacion();
//    Asientos_Frm.refrescar_y_mostrar_cambios_fiscal(Ordenes_Pago_MD_Frm.ord_pago_pag_provee_DSet.FieldByName('FECHA').AsDateTime);
//  //-------------------------------------------//
//    //mostrar, form de asientos.
//    if (Asientos_Frm.ShowModal in [mrOK, mrNone, mrCancel] ) then
//      begin
//        Self.recalcular_si_operacion_esta_asentada();
//        Ordenes_Pago_MD_Frm.ord_pago_pag_provee_DSet.Refresh;
//      end;
//  except
//    on E : Exception do
//    begin
//    if (Asientos_MD_Frm.transaccion_asientos.InTransaction = True) then
//      Asientos_MD_Frm.transaccion_asientos.RollbackRetaining;
//
//    if (Assigned(Asientos_MD_Frm) = True) then
//      Asientos_MD_Frm.Free;
//
//    MessageDlg(E.Message, mtError, [mbOK], 0);
//    end//fin del on exception
//  end
//  finally
//    Asientos_Frm.Free;
//  end;
end;
//----------------------------------------------------------------------------//
end.
