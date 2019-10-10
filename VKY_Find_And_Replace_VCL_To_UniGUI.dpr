program VKY_Find_And_Replace_VCL_To_UniGUI;

uses
  Forms,
  VKY_Find_And_Replace_VCL_To_UniGUI_Mod in 'VKY_Find_And_Replace_VCL_To_UniGUI_Mod.pas' {VKY_Find_And_Replace_VCL_To_UniGUI_FRM};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TVKY_Find_And_Replace_VCL_To_UniGUI_FRM, VKY_Find_And_Replace_VCL_To_UniGUI_FRM);
  Application.Run;
end.
