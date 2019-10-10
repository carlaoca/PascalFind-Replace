unit VKY_Definiciones_Simples_Mod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, DBActns, DB, ImgList, Menus,
  JvExExtCtrls, JvNetscapeSplitter,
  IBQuery, IBCustomDataSet, IBDatabase;

type
  TVKY_Definiciones_Simples_Frm = class(TForm)
    Panel_botonera: TPanel;
    nuevo_boton: TBitBtn;
    cancelar_boton: TBitBtn;
    eliminar_boton: TBitBtn;
    boton_guardar: TBitBtn;
    salir_boton: TBitBtn;
    grupo_buscador: TGroupBox;
    buscador_rapido_boton: TBitBtn;
    splitter_izquierda_derecha: TJvNetscapeSplitter;
    grupo_registro: TGroupBox;
    lista_acciones_cabacera: TActionList;
    dataset_insertar_cabecera: TDataSetInsert;
    dataset_eliminar_cabecera: TDataSetDelete;
    dataset_cancelar_cabecera: TDataSetCancel;
    accion_guardar_todos_los_registros: TAction;
    accion_salir_form: TAction;
    accion_buscador_rapido: TAction;
    accion_buscador: TAction;
    buscar_boton: TBitBtn;
    imprimir_boton: TBitBtn;
    accion_imprimir_registro: TAction;
    imagenes_v1: TImageList;
    ver_operaciones_log_boton: TBitBtn;
    ver_operaciones_en_el_log_accion: TAction;
    visualizador_log_popup_menu: TPopupMenu;
    procedure abrir_querys();
    procedure abrir_datasets();
    procedure cerrar_querys();
    procedure cerrar_datasets();
    procedure abrir_querys_sumadores_footers;
    procedure cerrar_querys_sumadores_footers;
    procedure cerrar_querys_no_se_abren_al_inicio;
    procedure accion_guardar_todos_los_registrosExecute(Sender: TObject);
    procedure accion_salir_formExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);//virtual; //creo, que no amerita que sea virtual
    procedure FormClose(Sender: TObject; var Action: TCloseAction); //virtual; //creo, que no amerita que sea virtual
    procedure GuardarRegistros(); //virtual; //creo, que no amerita que sea virtual
    procedure cargar_arrays_y_establecer_topes(); virtual;
    procedure cargar_querys_al_array(); virtual;
    procedure cargar_datasets_al_array(); virtual;
    procedure cargar_querys_sumadores_footers; virtual;
    procedure cargar_querys_no_se_abren_al_inicio; virtual;
    procedure reubicar_dataset_post_guardar(); virtual;
    procedure rollbackear_transaccion_al_salir_sin_guardar(); virtual;
    procedure liberar_modulo_de_datos(); virtual;
    procedure procedimientos_adicionales_al_crear_form(); virtual;
    procedure procedimientos_adicionales_al_salir(); virtual;
    function  consultar_si_se_cumplen_las_condiciones_para_guardar(): Boolean; virtual;
    procedure accion_buscadorExecute(Sender: TObject); virtual;
    procedure determinar_si_se_usa_o_no_el_buscador_lateral_rapido_en_este_Form(); virtual;
    procedure refrescar_datasets();
  private
    { Private declarations }
    procedure Dibujar_Titulo(const S : String);
    procedure WMNCPaint(VAR Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCActivate(VAR Msg: TWMNCActivate); message WM_NCACTIVATE;
    procedure WMSetText(VAR Msg: TWMSetText);  message WM_SETTEXT;
  public
    array_objetos_ibqueries: array[0..30] of TIBQuery;
    tope_cantidad_ibqueries: Integer;

    array_objetos_ibdatasets: array[0..30] of TIBDataSet;
    tope_cantidad_ibdatasets: Integer;

    array_objetos_ibqueries_sumadores_footers: array[0..30] of TIBQuery;
    tope_cantidad_ibqueries_sumadores_footers: Integer;

    array_objetos_ibqueries_no_se_abren_al_inicio: array[0..30] of TIBQuery;
    tope_cantidad_ibqueries_no_se_abren_al_inicio: Integer;

    tope_cantidad_grillas_jedi: Integer;
    tope_cantidad_footers_jedi: Integer;

    Modulo_Datos_Relacionado : TDataModule;
    Transaccion_relacionada: TIBTransaction;

    mensaje_para_incumplimiento_condicion_guardar : string;
    el_form_utiliza_o_no_buscador_lateral_rapido : Boolean;

    procedure inicializar_formulario(); virtual;

////======PROTOTIPOS PARA YAKARE VERSION 2.5 =========================
//    procedure inicializar_formulario(); virtual;
//    procedure cerrar_formulario(); virtual;
////======PROTOTIPOS PARA YAKARE VERSION 2.5 =========================
    { Public declarations }
  end;

var
  VKY_Definiciones_Simples_Frm: TVKY_Definiciones_Simples_Frm;

implementation
uses
  Virginia_Recursos_Mod,
  Declaraciones_Generales_Mod,
  Funciones_Generales_Mod,
  ModuloDatosMod;


{$R *.dfm}
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.FormCreate(Sender: TObject);
begin
try
  // en el caso de que algun form, no tenga querys o no tenga datasets, para no
  //tener violacion de memoria al recorrer el array.
  tope_cantidad_ibqueries := -1;
  tope_cantidad_ibdatasets := -1;
  tope_cantidad_ibqueries_sumadores_footers := -1;
  tope_cantidad_ibqueries_no_se_abren_al_inicio := -1;
  tope_cantidad_grillas_jedi := -1;
  tope_cantidad_footers_jedi := -1;

  //x si las moscas, seteo un texto para el mensaje de no cumplimiento al guardar.
  self.mensaje_para_incumplimiento_condicion_guardar := 'Algun Detalle/Registro No Fue Cargado.';

  //auto maximizar
  self.WindowState := wsMaximized;

  //esto esta, para cuando en el futuro habilitemos el buscador rapido
  self.grupo_buscador.Enabled := FALSE;
  self.grupo_buscador.Visible := FALSE;

  //cargamos los arrays de querys y datasets
  self.cargar_querys_al_array();
  self.cargar_datasets_al_array();
  self.cargar_querys_sumadores_footers;
  Self.cargar_querys_no_se_abren_al_inicio;

  //Abrimos las querys y los Datasets
  self.abrir_querys();
  self.abrir_datasets();
  self.abrir_querys_sumadores_footers;

  //cargar el array de grillas, y footers
  self.cargar_arrays_y_establecer_topes();

  //setear los colores
  self.procedimientos_adicionales_al_crear_form();

  Self.Caption := Self.Caption + ' - ' + UpperCase(Declaraciones_Generales_Mod.nombre_empresa) +
  ' - [' + Declaraciones_Generales_Mod.nombre_sucursal_actual + '] == ERP YAKARE - v' +
  IntToStr(Declaraciones_Generales_Mod.major_version) + '.' + IntToStr(Declaraciones_Generales_Mod.minor_version) + ' == ' +
  Declaraciones_Generales_Mod.nombre_version_sistema + ' ==  by Virginia LAB' +
  ' - ' + UpperCase(usuario) + ' -> ' + UpperCase(role);

  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;

//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.accion_salir_formExecute(Sender: TObject);
begin
  self.Close;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.abrir_querys();
var
  i:Integer;
begin
  try
  //1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibqueries  do
    begin
      array_objetos_ibqueries[i].Open;
    end;
  except
  on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;

procedure TVKY_Definiciones_Simples_Frm.abrir_querys_sumadores_footers;
var
  i:Integer;
begin
   try
  //1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibqueries_sumadores_footers  do
    begin
      array_objetos_ibqueries_sumadores_footers[i].Open;
    end;
  except
  on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;

end;

//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.accion_buscadorExecute(Sender: TObject);
begin
//EJEMPLO
//  if (boton_guardar.Enabled = FALSE) then
//    begin
//      Buscador_Factura_Proveedor_Frm := TBuscador_Factura_Proveedor_Frm.Create(self);
//      Buscador_Factura_Proveedor_Frm.tipo_busqueda := 1;
//      //Buscador_Factura_Proveedor_Frm.Show;
//      //mostrar, form de asientos.
//      if (Buscador_Factura_Proveedor_Frm.ShowModal in [mrOK, mrNone, mrCancel] ) then
//        begin
//          Self.recalcular_si_operacion_esta_asentada();
//          Facturas_Proveedores_MD_Frm.facturas_proveedores_DSet.Refresh;
//        end;
//
//      //des-habilitar el tema del Vto. segun sea el tipo de compra localizado.
//      self.des_habilitar_vtos_segun_tipo_de_Compra();
//    end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.accion_guardar_todos_los_registrosExecute(Sender: TObject);
begin
  //se guardan los registros
  self.GuardarRegistros;
  //se reubica
 // self.reubicar_dataset_post_guardar;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.abrir_datasets();
var
  i:Integer;
begin
try
  //1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibdatasets  do
    begin
      array_objetos_ibdatasets[i].Open;
    end;
  except
  on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.Cerrar_querys();
var
  i:Integer;
begin
try
  //1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibqueries  do
    begin
      array_objetos_ibqueries[i].Close;
    end;
  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;

procedure TVKY_Definiciones_Simples_Frm.cerrar_querys_sumadores_footers;
var
  i:Integer;
begin
try
//1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibqueries_sumadores_footers  do
    begin
      array_objetos_ibqueries_sumadores_footers[i].Close;
    end;
  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;

procedure TVKY_Definiciones_Simples_Frm.cerrar_querys_no_se_abren_al_inicio;
var
  i:Integer;
begin
try
//1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibqueries_no_se_abren_al_inicio  do
    begin
      array_objetos_ibqueries_no_se_abren_al_inicio[i].Close;
    end;
  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;

//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.Cerrar_datasets();
var
  i:Integer;
begin
try
  //1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibdatasets  do
    begin
      array_objetos_ibdatasets[i].Close;
    end;
  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.cargar_querys_al_array();
begin
  //ejemplo
  //tope_cantidad_ibqueries := 0;
  //array_objetos_ibqueries[0] := self.clientes_qry;
end;
procedure TVKY_Definiciones_Simples_Frm.cargar_querys_sumadores_footers;
begin
///
end;

procedure TVKY_Definiciones_Simples_Frm.cargar_querys_no_se_abren_al_inicio;
begin
////
end;

//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.cargar_datasets_al_array();
begin
  //ejemplo
  //tope_cantidad_ibdatasets := 0;
  //array_objetos_ibdatasets[0] := self.Clientes_DSET;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.cargar_arrays_y_establecer_topes();
begin
  //ejemplo
  //tope_cantidad_grillas_jedi := 0;
  //array_objetos_grillas_jedi[0] := grilla_operacion_a_asentar_u_asentada;
  //tope_cantidad_grillas_jedi := tope_cantidad_grillas_jedi + 1;
  //array_objetos_grillas_jedi[1] := cotizaciones_del_dia_grilla;

  //tope_cantidad_footers_jedi := 0;
  //array_objetos_footers_jedi[0] := footer_grilla_Detalle_asiento_guaranies;
  //tope_cantidad_footers_jedi := tope_cantidad_footers_jedi + 1;
  //array_objetos_footers_jedi[1] := footer_grilla_Detalle_asiento_dolares;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.FormClose(Sender: TObject;var Action: TCloseAction);
begin
try
 if (Self.boton_guardar.Enabled = True) then
  begin
    case MessageDlg('Se realizaron cambios, desea guardar los cambios?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
     mrYes :
       begin
          try
            self.GuardarRegistros;
          except
            on E: Exception do
          end
       end;
     mrCancel :
       begin
          Action := caNone;
          Exit;
       end;
     mrNo :
       begin
         self.rollbackear_transaccion_al_salir_sin_guardar();
       end;
    end;
  end;
  //procedimientos adicionales para clases hijas, que ya tienen footers
  self.procedimientos_adicionales_al_salir();

  //data sets
  self.cerrar_datasets();

  //querys varias (combos, y eso)
  self.cerrar_querys();

  //querys totalizadoras para Footers
  Self.cerrar_querys_sumadores_footers;

  //Cerramos las queries que no se abrieron al crear el form
  Self.cerrar_querys_no_se_abren_al_inicio;

  //liberar modulo de datos al salir.
  self.liberar_modulo_de_datos();

  //nos auto-libreramos, he'i self Form :)
  Action := caFree;
  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.rollbackear_transaccion_al_salir_sin_guardar();
begin
  //ejemplo
  // Asientos_MD_Frm.transaccion_asientos.RollbackRetaining;
  //asi, sera que no ha de funcionar ? ya que recibe luego el parametro
  //Self.Transaccion_relacionada.RollbackRetaining;
end;

//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.liberar_modulo_de_datos();
begin
  //ejemplo
  //Asientos_MD_Frm.Free;
  //asi, sera que no ha de funcionar ? ya que recibe luego el parametro
  //Self.Transaccion_relacionada.Free;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.procedimientos_adicionales_al_crear_form();
begin
  //ejemplo
  //self.setear_colores_de_objetos();
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.procedimientos_adicionales_al_salir();
begin
  //ejemplo
  //self.liberar_footers_de_datasets();
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.GuardarRegistros();
var
  i:Integer;
begin
  if (consultar_si_se_cumplen_las_condiciones_para_guardar = TRUE) then
  begin
    //inicio la transaccion, si aun no fue iniciada
    if (Transaccion_relacionada.InTransaction = False) then
      Transaccion_relacionada.StartTransaction;

    //Hacer post de los datasets en edicion, iniciando por la cabecera
    for  i := 0 to tope_cantidad_ibdatasets  do
    begin
      if (Array_objetos_ibdatasets[i].State in dsEditModes) then
        array_objetos_ibdatasets[i].post;
    end;

    //commiteamos la transaccion
    if (Transaccion_relacionada.InTransaction = True) then
      Transaccion_relacionada.CommitRetaining;

    //desabilitamos el boton guardar
    self.boton_guardar.Enabled := False;

    //si el form utiliza el buscador lateral, hay que habilitar ahora
    //Habilitamos el Grupo de Busqueda Rapida Lateral
    if (el_form_utiliza_o_no_buscador_lateral_rapido = True) then
      self.grupo_buscador.Enabled := True;
  end//fin de si se cumplio la condicion para guardar
  else
    MessageDlg(mensaje_para_incumplimiento_condicion_guardar, mtWarning, [mbOK], 0);

   //se reubica
   self.reubicar_dataset_post_guardar;
end;
//----------------------------------------------------------------------------//
function TVKY_Definiciones_Simples_Frm.consultar_si_se_cumplen_las_condiciones_para_guardar(): Boolean;
begin
//  if ( (Asientos_MD_Frm.Detalles_Asientos_Dset.IsEmpty = True) and
//       (Asientos_MD_Frm.Detalles_Asientos_Dolares_Dset.IsEmpty = True) and
//       (Asientos_MD_Frm.Asientos_Dset.IsEmpty = FALSE) ) then
//  begin
//    MessageDlg('No se puede guardar si no existe ningún detalle en Gs. o U$', mtInformation, [mbOK], 0);
//    Exit;
//  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.reubicar_dataset_post_guardar();
begin
//
//var
//id_factura_actual : Longword;
//ejemplo
//    //Preguntamos si existe la factura en la query de operaciones, y en caso que no
//    //exista entonces procedemos a re ejecutar
//    if (Facturacion_MD_Frm.operaciones_qry.Locate('id_factura', Facturacion_MD_Frm.Facturacion_Dset.fieldByName('id_factura').AsInteger, []) = False) then
//    begin
//      //Guardamos el id de la factura actual
//      id_factura_actual := Facturacion_MD_Frm.Facturacion_Dset.fieldByName('id_factura').AsInteger;
//
//      Facturacion_MD_Frm.recalcular_todo( Facturacion_MD_Frm.Facturacion_Dset.fieldByName('id_planta').AsInteger,
//                                          Facturacion_MD_Frm.Facturacion_Dset.fieldByName('id_sub_cuenta_cliente').AsInteger,
//                                          Facturacion_MD_Frm.Facturacion_Dset.fieldByName('FECHA').AsDateTime,
//                                          Facturacion_MD_Frm.Facturacion_Dset.fieldByName('FECHA').AsDateTime, 1);
//
//      //Colocamos la query operaciones y el dataset facturaciones al id de la
//      //factura actual
//      Facturacion_MD_Frm.operaciones_qry.Locate('id_factura', id_factura_actual, []);
//      Facturacion_MD_Frm.Facturacion_Dset.Locate('id_factura', id_factura_actual, []);
//
//      plantas_listar_combo.KeyValue := Facturacion_MD_Frm.Facturacion_Dset.fieldByName('ID_PLANTA').AsInteger;
//      sub_ctas_clientes_listar_combo.KeyValue := Facturacion_MD_Frm.Facturacion_Dset.fieldByName('ID_SUB_CUENTA_CLIENTE').AsInteger;
//      fecha_desde_dtp.DateTime := Facturacion_MD_Frm.Facturacion_Dset.fieldByName('FECHA').AsDateTime;
//      fecha_hasta_dtp.DateTime := Facturacion_MD_Frm.Facturacion_Dset.fieldByName('FECHA').AsDateTime;
//      operaciones_lista.KeyValue := Facturacion_MD_Frm.Facturacion_Dset.FieldByName('ID_FACTURA').AsInteger;
//    end
//    else
//    begin
//      //Guardamos el id de la factura actual
//      id_factura_actual := Facturacion_MD_Frm.Facturacion_Dset.fieldByName('id_factura').AsInteger;
//
//      Facturacion_MD_Frm.recalcular_todo( Self.plantas_listar_combo.KeyValue,
//                                          Self.sub_ctas_clientes_listar_combo.KeyValue,
//                                          Self.fecha_desde_dtp.DateTime,
//                                          Self.fecha_hasta_dtp.DateTime, 1);
//
//      //Colocamos la query operaciones y el dataset facturaciones al id de la
//      //factura actual
//      Facturacion_MD_Frm.operaciones_qry.Locate('id_factura', id_factura_actual, []);
//      Facturacion_MD_Frm.Facturacion_Dset.Locate('id_factura', id_factura_actual, []);
//    end
end;
//----------------------------------------------------------------------------//
{Aqui deberiamos de consultar por una query, con datos del sistema, que nos va a determinar,
si la combinacion Empresa/Modulo/Role, esta habilitado para utilizar el buscador
lateral rapido, finalmente va a sertear una variable boolena a true o false,
que es la que usaremos en el resto del form.}
procedure TVKY_Definiciones_Simples_Frm.determinar_si_se_usa_o_no_el_buscador_lateral_rapido_en_este_Form();
begin

end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.Refrescar_datasets();
var
  i:Integer;
begin
try
  //1ro. Recorrida, para hacer el Open de las querys
  for  i := 0 to tope_cantidad_ibdatasets  do
    begin
      array_objetos_ibdatasets[i].Refresh;
    end;
  except
    on E : Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end//fin del on exception
  end;
end;
//----------------------------------------------------------------------------//
procedure TVKY_Definiciones_Simples_Frm.inicializar_formulario();
begin

end;
//----------------------------------------------------------------------------//
{
   ========== PROTOTIPOS PARA LA VERISON 2.5 DE YAKARE ===================
- Este procedimiento, sera llamado, luego de haber creado el form.
- En el cual, vamos a incluir todos los procedimiento adicionales a haber creado el Form,
- mas que nada pensando, en que varios forms, tiene comportamientos y querys distintas,
- segun desde donde se les llame.
}
//procedure TVKY_Definiciones_Simples_Frm.inicializar_formulario();
//begin
//  //cargamos los arrays de querys y datasets
//  self.cargar_querys_al_array();
//  self.cargar_datasets_al_array();
//
//  //Abrimos las querys y los Datasets
//  self.abrir_querys();
//  self.abrir_datasets();
//
//  //determinar si el Form/Modulo, usa o no el buscador lateral.
//  self.determinar_si_se_usa_o_no_el_buscador_lateral_rapido_en_este_Form();
//
//  //si el proceso anterior, determino que se asienta o NO, aqui seteo las mismas propiedades, booleanas
//  self.grupo_buscador.Enabled := el_form_utiliza_o_no_buscador_lateral_rapido;
//  self.grupo_buscador.Visible := el_form_utiliza_o_no_buscador_lateral_rapido;
//
//  //si se va a usar el buscador lateral, el otro boton buscador, no lo haremos.
//  if (el_form_utiliza_o_no_buscador_lateral_rapido = True) then
//    begin
//      buscar_boton.Enabled := False;
//      buscar_boton.Visible := False;
//    end;
//end;
//----------------------------------------------------------------------------//
{- Este procedimiento, sera llamado, antes de hacer un FreeAndNil del form.
}
//procedure TVKY_Definiciones_Simples_Frm.cerrar_formulario();
//begin
//
//end;


procedure TVKY_Definiciones_Simples_Frm.Dibujar_Titulo(const S : String);
var
 TopOfs: Word;
 R: TRect;
 XF,            {frame width}
 YF,            {frame height}
 XS,            {caption bar button width}
 YS: Integer;  {caption bar button height}
begin
 XF := GetSystemMetrics(SM_CXFRAME);
 YF := GetSystemMetrics(SM_CYFRAME);
 XS := GetSystemMetrics(SM_CXSIZE);
 YS := GetSystemMetrics(SM_CYSIZE);
 WITH Canvas DO
   try
     R := Bounds(XF, YF, ClientWidth, YS);
     R.Right := R.Right-XS-1;
     IF biSystemMenu IN BorderIcons THEN R.Left := R.Left+XS+1;
     IF biMinimize IN BorderIcons THEN R.Right := R.Right-XS-1;
     IF biMaximize IN BorderIcons THEN R.Right := R.Right-XS-1;
     Handle := GetWindowDC(Self.Handle);
     Brush.Color := Declaraciones_Generales_Mod.color_borde;
     Font.Color  := Declaraciones_Generales_Mod.color_caption;
     Font.Style  := [fsBold];
     Font.Name   := 'Tahoma';
     Font.Size := 8;
     TopOfs := TextHeight(S);
     IF TopOfs > YS THEN TopOfs := 0
     ELSE TopOfs := (YS-TopOfs) DIV 2;
     SetTextAlign(Handle, TA_CENTER);
     TextRect(R, (R.Right+R.Left) div 2, R.Top+TopOfs, S);

   finally
     ReleaseDC(Self.Handle, Handle);
     Handle := 0;
   end;
end;

procedure TVKY_Definiciones_Simples_Frm.WMNCPaint(VAR Msg: TWMNCPaint);
begin
 Inherited;

 Self.Dibujar_Titulo(Self.Caption);
end;

procedure TVKY_Definiciones_Simples_Frm.WMNCActivate(VAR Msg: TWMNCActivate);
begin
 Inherited;

 Self.Dibujar_Titulo(Self.Caption);
end;

procedure TVKY_Definiciones_Simples_Frm.WMSetText(VAR Msg: TWMSetText);
begin
 Inherited;

 Self.Dibujar_Titulo(Self.Caption);
end;

end.
