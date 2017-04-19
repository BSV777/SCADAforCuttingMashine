program Rezka;

uses
  Forms,
  FormMan in 'FormMan.pas' {ManualControlForm},
  ContrMan in 'Classes\ContrMan.pas',
  OPCClient in 'Classes\OPCClient.pas',
  OPCDA in 'OPC\OPCDA.pas',
  OPCtypes in 'OPC\OPCtypes.pas',
  OPCutils in 'OPC\OPCutils.pas',
  Params in 'Params.pas' {ParamsForm},
  PZ in 'PZ.pas' {FPZ},
  Setup in 'Setup.pas' {SetupForm},
  FormAuto in 'FormAuto.pas' {AutoControlForm},
  Auto in 'Auto.pas',
  ContrAuto in 'Classes\ContrAuto.pas',
  ContrDetail in 'Classes\ContrDetail.pas',
  ContrPlan in 'Classes\ContrPlan.pas',
  ClassZadanie in 'Classes\ClassZadanie.pas',
  SingleInst in 'SingleInst.pas',
  TapeCounter_TLB in 'Classes\TapeCounter_TLB.pas',
  SplashUnit in 'SplashUnit.pas' {Splash},
  ColorBtn in 'Classes\ColorBtn.pas';

{$R .\RES\Rezka.res}
{$R .\RES\RezkaEMF.RES}

begin
  if not ActivatePrevInstance(TManualControlForm.ClassName, '') then
    begin
      Application.Initialize;
      Application.Title := 'Л-ПАК. Агрегат резки';
      Splash := TSplash.Create(Application);
      Splash.Show;
      Splash.Update;
      Application.CreateForm(TManualControlForm, ManualControlForm);
  Application.CreateForm(TParamsForm, ParamsForm);
  Application.CreateForm(TSetupForm, SetupForm);
  Application.CreateForm(TAutoControlForm, AutoControlForm);
  Splash.Close;
      Application.Run;
    end;
end.
