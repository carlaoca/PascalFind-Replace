unit VKY_Maestros_Detalle_Con_Grilla_Mod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBActns, ActnList, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  ComCtrls, DBCtrls, ImgList, Menus,
  VKY_Maestros_Detalles_Mod,
  JvExExtCtrls, JvNetscapeSplitter, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  JvDBGridFooter, JvDBCheckBox;

type
  TVKY_Maestros_Detalle_Con_Grilla_Frm = class(TVKY_Maestros_Detalles_Frm)
    footer_grilla_detalle: TJvDBGridFooter;
    grilla_detalle: TJvDBUltimGrid;
    grupo_objetos_detalle: TGroupBox;
    grupo_navegador_grilla_detalle: TGroupBox;
    navegador_detalle: TDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VKY_Maestros_Detalle_Con_Grilla_Frm: TVKY_Maestros_Detalle_Con_Grilla_Frm;

implementation

{$R *.dfm}

end.
