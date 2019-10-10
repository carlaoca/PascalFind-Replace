unit VKY_Maestros_Detalle_Con_Pestanhas_Mod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, DBActns, ActnList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  VKY_Definiciones_Simples_Mod,
  JvExExtCtrls, JvNetscapeSplitter;

type
  TVKY_Maestros_Detalle_Con_Pestanhas_Frm = class(TVKY_Definiciones_Simples_Frm)
    page_control_principal: TPageControl;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VKY_Maestros_Detalle_Con_Pestanhas_Frm: TVKY_Maestros_Detalle_Con_Pestanhas_Frm;

implementation

{$R *.dfm}

end.
