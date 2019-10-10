unit VKY_Maestros_Varios_Detalles_Mod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBActns, ActnList, StdCtrls, Buttons, ExtCtrls, ComCtrls, DBCtrls, ImgList, Menus,
  VKY_Maestros_Detalles_Mod,
  JvExExtCtrls, JvNetscapeSplitter, JvDBGrid, JvDBUltimGrid, JvDBGridFooter, JvDBCheckBox;

type
  TVKY_Maestros_Varios_Detalles_Frm = class(TVKY_Maestros_Detalles_Frm)
    page_control_varios_detalles: TPageControl;
    tab_detalle_1: TTabSheet;
    tab_detalle_2: TTabSheet;

  private
    { Private declarations }
  public
    //Esta variable se llevo a definiciones simplres
    //tope_cantidad_footers_jedi: Integer;
    { Public declarations }
  end;

var
  VKY_Maestros_Varios_Detalles_Frm: TVKY_Maestros_Varios_Detalles_Frm;

implementation

{$R *.dfm}
//----------------------------------------------------------------------------//
end.
