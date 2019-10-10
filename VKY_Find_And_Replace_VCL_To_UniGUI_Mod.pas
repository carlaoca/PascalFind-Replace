unit VKY_Find_And_Replace_VCL_To_UniGUI_Mod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, DB, ExtCtrls, DBCtrls, Grids, DBGrids, Mask,
  IBCustomDataSet, IBTable, IBDatabase,
  JvToolEdit, JvExMask, JvCreateProcess, JvComponentBase;

type
  TVKY_Find_And_Replace_VCL_To_UniGUI_FRM = class(TForm)
    boton_migrar: TButton;
    IBDatabase: TIBDatabase;
    IBTransaction: TIBTransaction;
    Vky_Clases_a_Modificar_ds: TDataSource;
    Vky_Clases_a_Modificar: TIBTable;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Vky_Clases_a_ModificarID_CLASE_A_MODIFICAR: TIntegerField;
    Vky_Clases_a_ModificarNOMBRE_ORIGEN: TIBStringField;
    Vky_Clases_a_ModificarNOMBRE_DESTINO: TIBStringField;
    Vky_Clases_a_Modificar_UNIDAC_ds: TDataSource;
    Vky_Clases_a_Modificar_UNIDAC: TIBTable;
    Vky_Clases_a_Modificar_UNIDACID_CLASE_A_MODIFICAR_UNIDAC: TIntegerField;
    Vky_Clases_a_Modificar_UNIDACNOMBRE_ORIGEN: TIBStringField;
    Vky_Clases_a_Modificar_UNIDACNOMBRE_DESTINO: TIBStringField;
    Vky_Clases_a_Modificar_UNIDACWILDCARD_1_PAS: TIBStringField;
    Vky_Clases_a_Modificar_UNIDACWILDCARD_2_DFM: TIBStringField;
    Vky_Clases_a_Modificar_UNIDACOBSERVACIONES: TIBStringField;
    Vky_Clases_a_ModificarWILDCARD_1_PAS: TIBStringField;
    Vky_Clases_a_ModificarWILDCARD_2_DFM: TIBStringField;
    Vky_Clases_a_ModificarOBSERVACIONES: TIBStringField;
    Vky_Boqueron_a_Yakare_Ds: TDataSource;
    Vky_Boqueron_a_Yakare: TIBTable;
    Vky_Boqueron_a_YakareID_BOQUERON_A_YAKARE: TIntegerField;
    Vky_Boqueron_a_YakareNOMBRE_ORIGEN: TIBStringField;
    Vky_Boqueron_a_YakareNOMBRE_DESTINO: TIBStringField;
    Vky_Boqueron_a_YakareWILDCARD_1_PAS: TIBStringField;
    Vky_Boqueron_a_YakareWILDCARD_2_DFM: TIBStringField;
    Vky_Boqueron_a_YakareOBSERVACIONES: TIBStringField;
    GroupBox4: TGroupBox;
    GroupBox3: TGroupBox;
    rg_migrar_vcl_a_unigui: TRadioButton;
    rg_migrar_ibx_a_unidac: TRadioButton;
    rg_migrar_boqueron_a_yakare: TRadioButton;
    barra_progreso: TGauge;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    camino_archivo_a_cargar_text: TJvFilenameEdit;
    JvDirectoryEdit1: TJvDirectoryEdit;
    rg_migrar_unidac_a_ibx: TRadioButton;
    Vky_UNidac_a_IBX_Tabla_ds: TDataSource;
    Vky_UNidac_a_IBX_Tabla: TIBTable;
    Vky_UNidac_a_IBX_TablaID_CLASE_A_MODIFICAR: TIntegerField;
    Vky_UNidac_a_IBX_TablaNOMBRE_ORIGEN: TIBStringField;
    Vky_UNidac_a_IBX_TablaNOMBRE_DESTINO: TIBStringField;
    Vky_UNidac_a_IBX_TablaWILDCARD_1_PAS: TIBStringField;
    Vky_UNidac_a_IBX_TablaWILDCARD_2_DFM: TIBStringField;
    Vky_UNidac_a_IBX_TablaOBSERVACIONES: TIBStringField;
    procedure boton_migrarClick(Sender: TObject);
    procedure Vky_Clases_a_ModificarAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure migrar_vcl_a_unigui;
    procedure migrar_ibx_a_unidac;
    procedure migrar_boqueron_a_yakare;
    procedure migrar_unidac_a_ibx;
    procedure rg_migrar_vcl_a_uniguiClick(Sender: TObject);
    procedure rg_migrar_ibx_a_unidacClick(Sender: TObject);
    procedure rg_migrar_boqueron_a_yakareClick(Sender: TObject);
    procedure rg_migrar_unidac_a_ibxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VKY_Find_And_Replace_VCL_To_UniGUI_FRM: TVKY_Find_And_Replace_VCL_To_UniGUI_FRM;

implementation

{$R *.dfm}

procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  self.Vky_Clases_a_Modificar.Open;
  self.IBDatabase.Close;

  Action := caFree;
end;

procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.FormCreate(Sender: TObject);
begin
  self.IBDatabase.Open;

  //self.Vky_Clases_a_Modificar.Open;
  self.Vky_Clases_a_Modificar_UNIDAC.Open;

  self.JvDirectoryEdit1.Text := ExtractFilePath(Application.ExeName);
  self.camino_archivo_a_cargar_text.Text := ExtractFilePath(Application.ExeName) + 'fart.exe';
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.Vky_Clases_a_ModificarAfterPost(DataSet: TDataSet);
begin
  self.IBTransaction.CommitRetaining;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.boton_migrarClick(Sender: TObject);
begin
  if (self.rg_migrar_vcl_a_unigui.Checked = TRUE) then
    self.migrar_vcl_a_unigui()
  else if (self.rg_migrar_ibx_a_unidac.Checked = TRUE) then
    self.migrar_ibx_a_unidac()
  else if (self.rg_migrar_boqueron_a_yakare.Checked = TRUE) then
    self.migrar_boqueron_a_yakare()
  else if (self.rg_migrar_unidac_a_ibx.Checked = TRUE) then
    self.migrar_unidac_a_ibx();
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.migrar_vcl_a_unigui;
var
  aplicacion_externa :string;
  parametros_fijos_pre_bucle : string;

  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  se_creo_bien   : Boolean;
  parametros : string;
  wildcards : string;
begin
  //Ejemplo - fart.exe -r -V c:\1\*.dfm TPanel TUniPanel

  FillChar(StartInfo,SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo,SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  aplicacion_externa := camino_archivo_a_cargar_text.Text; // ExtractFilePath(Application.ExeName) + 'Actualizador_Temporal.exe';

  //1ra. pasada para los .pas
  wildcards := '*.pas ';
  //parametros_fijos_pre_bucle := ' -r -V ' + self.JvDirectoryEdit1.Text + wildcards;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards;
  self.Vky_Clases_a_Modificar.First;
  while self.Vky_Clases_a_Modificar.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_Clases_a_Modificar.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_Clases_a_Modificar.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_Clases_a_Modificar.Next;
    end;

  //2da. pasada para los .dfm
  wildcards := '*.dfm ';
  //parametros_fijos_pre_bucle := ' -r -V ' + self.JvDirectoryEdit1.Text + wildcards;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards;
  self.Vky_Clases_a_Modificar.First;
  while self.Vky_Clases_a_Modificar.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_Clases_a_Modificar.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_Clases_a_Modificar.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_Clases_a_Modificar.Next;
    end;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.rg_migrar_boqueron_a_yakareClick(Sender: TObject);
begin
  //cerramos las querys, y cambiamos los datasources
 Self.Vky_Clases_a_Modificar.Close;
 Self.Vky_Clases_a_Modificar_UNIDAC.Close;
 Self.Vky_Boqueron_a_Yakare.Close;
 Self.Vky_UNidac_a_IBX_Tabla.Close;

 self.DBNavigator1.DataSource := Self.Vky_Boqueron_a_Yakare_Ds;
 self.DBGrid1.DataSource := Self.Vky_Boqueron_a_Yakare_Ds;

 Self.Vky_Boqueron_a_Yakare.Open;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.rg_migrar_ibx_a_unidacClick(Sender: TObject);
begin
  //cerramos las querys, y cambiamos los datasources
 Self.Vky_Clases_a_Modificar.Close;
 Self.Vky_Clases_a_Modificar_UNIDAC.Close;
 Self.Vky_Boqueron_a_Yakare.Close;
 Self.Vky_UNidac_a_IBX_Tabla.Close;

 self.DBNavigator1.DataSource := Self.Vky_Clases_a_Modificar_UNIDAC_ds;
 self.DBGrid1.DataSource := Self.Vky_Clases_a_Modificar_UNIDAC_ds;

 Self.Vky_Clases_a_Modificar_UNIDAC.Open;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.rg_migrar_vcl_a_uniguiClick(Sender: TObject);
begin
  //cerramos las querys, y cambiamos los datasources
 Self.Vky_Clases_a_Modificar.Close;
 Self.Vky_Clases_a_Modificar_UNIDAC.Close;
 Self.Vky_Boqueron_a_Yakare.Close;
 Self.Vky_UNidac_a_IBX_Tabla.Close;

 self.DBNavigator1.DataSource := Self.Vky_Clases_a_Modificar_ds;
 self.DBGrid1.DataSource := Self.Vky_Clases_a_Modificar_ds;

 Self.Vky_Clases_a_Modificar.Open;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.migrar_ibx_a_unidac;
var
  aplicacion_externa :string;
  parametros_fijos_pre_bucle : string;

  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  se_creo_bien   : Boolean;
  parametros : string;
  wildcards : string;
begin
  //Ejemplo - fart.exe -r -V c:\1\*.dfm TPanel TUniPanel

  FillChar(StartInfo,SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo,SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  aplicacion_externa := camino_archivo_a_cargar_text.Text; // ExtractFilePath(Application.ExeName) + 'Actualizador_Temporal.exe';

  self.Vky_Clases_a_Modificar_UNIDAC.First;
  //1ra. pasada para los .pas
  //wildcards := '*.pas ';
  wildcards := self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('WILDCARD_1_PAS').Value;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
  while self.Vky_Clases_a_Modificar_UNIDAC.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_Clases_a_Modificar_UNIDAC.Next;
      //al cambiar de registro, volvemos a armar el WildCard
      wildcards := self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('WILDCARD_1_PAS').Value;
      parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
    end;

  //2da. pasada para los .dfm
  self.Vky_Clases_a_Modificar_UNIDAC.First;
  //wildcards := '*.dfm ';
  wildcards := self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('WILDCARD_2_DFM').Value;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
  while self.Vky_Clases_a_Modificar_UNIDAC.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_Clases_a_Modificar_UNIDAC.Next;
      //al cambiar de registro, volvemos a armar el WildCard
      wildcards := self.Vky_Clases_a_Modificar_UNIDAC.FieldByName('WILDCARD_2_DFM').Value;
      parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
    end;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.migrar_boqueron_a_yakare;
var
  aplicacion_externa :string;
  parametros_fijos_pre_bucle : string;

  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  se_creo_bien   : Boolean;
  parametros : string;
  wildcards : string;
begin
  //Ejemplo - fart.exe -r -V c:\1\*.dfm TPanel TUniPanel

  FillChar(StartInfo,SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo,SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  aplicacion_externa := camino_archivo_a_cargar_text.Text; // ExtractFilePath(Application.ExeName) + 'Actualizador_Temporal.exe';

  self.Vky_Boqueron_a_Yakare.First;
  //1ra. pasada para los .pas
  //wildcards := '*.pas ';
  wildcards := self.Vky_Boqueron_a_Yakare.FieldByName('WILDCARD_1_PAS').Value;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
  while self.Vky_Boqueron_a_Yakare.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_Boqueron_a_Yakare.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_Boqueron_a_Yakare.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_Boqueron_a_Yakare.Next;
      //al cambiar de registro, volvemos a armar el WildCard
      wildcards := self.Vky_Boqueron_a_Yakare.FieldByName('WILDCARD_1_PAS').Value;
      parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
    end;

  //2da. pasada para los .dfm
  self.Vky_Boqueron_a_Yakare.First;
  //wildcards := '*.dfm ';
  wildcards := self.Vky_Boqueron_a_Yakare.FieldByName('WILDCARD_2_DFM').Value;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
  while self.Vky_Boqueron_a_Yakare.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_Boqueron_a_Yakare.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_Boqueron_a_Yakare.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_Boqueron_a_Yakare.Next;
      //al cambiar de registro, volvemos a armar el WildCard
      wildcards := self.Vky_Boqueron_a_Yakare.FieldByName('WILDCARD_2_DFM').Value;
      parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
    end;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.rg_migrar_unidac_a_ibxClick(Sender: TObject);
begin
  //cerramos las querys, y cambiamos los datasources
 Self.Vky_Clases_a_Modificar.Close;
 Self.Vky_Clases_a_Modificar_UNIDAC.Close;
 Self.Vky_Boqueron_a_Yakare.Close;
 Self.Vky_UNidac_a_IBX_Tabla.Close;

 self.DBNavigator1.DataSource := Self.Vky_UNidac_a_IBX_Tabla_ds;
 self.DBGrid1.DataSource := Self.Vky_UNidac_a_IBX_Tabla_ds;

 Self.Vky_UNidac_a_IBX_Tabla.Open;
end;
//============================================================================//
procedure TVKY_Find_And_Replace_VCL_To_UniGUI_FRM.migrar_unidac_a_ibx;
var
  aplicacion_externa :string;
  parametros_fijos_pre_bucle : string;

  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  se_creo_bien   : Boolean;
  parametros : string;
  wildcards : string;
begin
  //Ejemplo - fart.exe -r -V c:\1\*.dfm TPanel TUniPanel

  FillChar(StartInfo,SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo,SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  aplicacion_externa := camino_archivo_a_cargar_text.Text; // ExtractFilePath(Application.ExeName) + 'Actualizador_Temporal.exe';

  self.Vky_UNidac_a_IBX_Tabla.First;
  //1ra. pasada para los .pas
  //wildcards := '*.pas ';
  wildcards := self.Vky_UNidac_a_IBX_Tabla.FieldByName('WILDCARD_1_PAS').Value;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
  while self.Vky_UNidac_a_IBX_Tabla.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_UNidac_a_IBX_Tabla.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_UNidac_a_IBX_Tabla.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_UNidac_a_IBX_Tabla.Next;
      //al cambiar de registro, volvemos a armar el WildCard
      wildcards := self.Vky_UNidac_a_IBX_Tabla.FieldByName('WILDCARD_1_PAS').Value;
      parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
    end;

  //2da. pasada para los .dfm
  self.Vky_UNidac_a_IBX_Tabla.First;
  //wildcards := '*.dfm ';
  wildcards := self.Vky_UNidac_a_IBX_Tabla.FieldByName('WILDCARD_2_DFM').Value;
  parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
  while self.Vky_UNidac_a_IBX_Tabla.Eof = FALSE do
    begin
      //Aca tuve que hacer una trampita porque al pasarle los paramtros al actualizador
      //el parametro 0 toma siempre el camino del actualizador, por lo tanto le agregue
      //al final el ip del servidor
      parametros := parametros_fijos_pre_bucle +
                    '"' + self.Vky_UNidac_a_IBX_Tabla.FieldByName('NOMBRE_ORIGEN').Value + '"' + ' ' +
                    '"' + self.Vky_UNidac_a_IBX_Tabla.FieldByName('NOMBRE_DESTINO').Value + '"';

      se_creo_bien := CreateProcess(PChar(aplicacion_externa), PChar(parametros), nil, nil, False,
                  CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

      if (se_creo_bien = True) then
      begin
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end
      else
        MessageDlg('Se encontró un problema al tratar de ejecutar el actualizador.', mtWarning, [mbOK], 0);

      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);

      self.Vky_UNidac_a_IBX_Tabla.Next;
      //al cambiar de registro, volvemos a armar el WildCard
      wildcards := self.Vky_UNidac_a_IBX_Tabla.FieldByName('WILDCARD_2_DFM').Value;
      parametros_fijos_pre_bucle := ' -r ' + self.JvDirectoryEdit1.Text + wildcards + ' ';
    end;
end;
//============================================================================//
end.
