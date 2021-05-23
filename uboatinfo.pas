unit UBoatinfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Character, UBoat;

type

  { TForm1 }

  TForm1 = class(TForm)
    buttonReset: TButton;
    buttonGetInfo: TButton;
    ICurrentEnginePower: TLabel;
    ICurrentSailArea: TLabel;
    ICurrentPersonsMin: TLabel;
    lCurrentEnginePower_: TLabel;
    lCurrentSailArea_: TLabel;
    lCurrentPersonsMin_: TLabel;
    lDebug: TLabel;
    lCurrentNumber: TLabel;
    ICurrentName: TLabel;
    lCurrentNumber_: TLabel;
    lCurrentName_: TLabel;
    lEditPersonsMin: TLabeledEdit;
    lEditSailArea: TLabeledEdit;
    lEditEnginePower: TLabeledEdit;
    lEditBoatName: TLabeledEdit;
    lEditBoatNumber: TLabeledEdit;
    saveDialog: TSaveDialog;
    procedure buttonGetInfoClick(Sender: TObject);
    procedure buttonResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
  var
    mBoat: TMotorboat;
    sBoat: TSailboat;

    instanceExists: integer;
    aTextFile: TextFile;
    row: string;

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  instanceExists := 0;
end;


procedure TForm1.buttonResetClick(Sender: TObject);
begin
  lDebug.Font.Color := clSilver;
  lDebug.Caption := '-';

  lEditBoatNumber.Clear;
  lEditBoatName.Clear;
  lEditEnginePower.Clear;
  lEditSailArea.Clear;
  lEditPersonsMin.Clear;

  lCurrentNumber_.Caption := '-';
  lCurrentName_.Caption := '-';
  lCurrentEnginePower_.Caption := '-';
  lCurrentSailArea_.Caption := '-';
  lCurrentPersonsMin_.Caption := '-';

  mBoat := nil;
  sBoat := nil;
  instanceExists := 0;
end;


procedure TForm1.buttonGetInfoClick(Sender: TObject);
var
  boatNumber, boatName: string;
  enginePower, sailArea: real;
  personsMin, index: integer;
begin
  // Delete any existing error message.
  lDebug.Font.Color := clSilver;
  lDebug.Caption := '-';

  boatNumber := UpperCase(lEditBoatNumber.Caption);
  boatName := lEditBoatName.Caption;

  // Check if there is already an boat-object created.
  if (instanceExists = 0) then
    // no object
  begin
    // Make sure, that the boatNumber is not an empty string.
    if (boatNumber = EmptyStr) then
    begin
      lDebug.Font.Color := clRed;
      lDebug.Caption := 'Cannot accept an empty boatNumber.';
      exit();
    end;

    // Make sure, that the boatNumber has at least 2 chars.
    if (Length(boatNumber) < 2) then
    begin
      lDebug.Font.Color := clRed;
      lDebug.Caption := 'Your boatNumber needs at least 2 chars.';
      exit();
    end;

    // Make sure that there are no unallowed chars in the boatNumber.
    for index := 2 to Length(boatNumber) do
      if (not IsNumber(boatNumber[index])) then
      begin
        lDebug.Font.Color := clRed;
        lDebug.Caption := 'Your boatNumber contains unallowed chars.';
        exit();
      end;

    // Precoditions checked, create instance.
    if (boatNumber[1] = 'M') then
      // type = TMotorboat
    begin
      // Check if string is float.
      if (not TryStrToFloat(lEditEnginePower.Caption, enginePower)) then
      begin
        lDebug.Font.Color := clRed;
        lDebug.Caption := 'Cannot get enginePower.';
        exit();
      end;

      // Create TMotorboat.
      mBoat := TMotorboat.Create(boatNumber, boatName, enginePower);
      instanceExists := 1;

      lCurrentNumber_.Caption := boatNumber;
      lCurrentName_.Caption := boatName;
      lCurrentEnginePower_.Caption := FloatToStr(enginePower);

      ShowMessage('Your motorboat was created, please click again to download.');
    end

    else if (boatNumber[1] = 'S') then
      // type = TSailboat
    begin
      // Check if string is float.
      if (not TryStrToFloat(lEditSailArea.Caption, sailArea)) then
      begin
        lDebug.Font.Color := clRed;
        lDebug.Caption := 'Cannot get sailArea.';
        exit();
      end;

      if (not TryStrToInt(lEditPersonsMin.Caption, personsMin)) then
      begin
        lDebug.Font.Color := clRed;
        lDebug.Caption := 'Cannot get personsMin.';
        exit();
      end;

      // Create TSailboat.
      TryStrToInt(lEditPersonsMin.Caption, personsMin);
      sBoat := TSailboat.Create(boatNumber, boatName, sailArea, personsMin);
      instanceExists := 2;

      lCurrentNumber_.Caption := boatNumber;
      lCurrentName_.Caption := boatName;
      lCurrentSailArea_.Caption := FloatToStr(sailArea);
      lCurrentPersonsMin_.Caption := IntToStr(personsMin);

      ShowMessage('Your sailboat was created, please click again to download.');
    end
    else
      // wrong type despite preconditions? weird O.o
    begin
      lDebug.Font.Color := clRed;
      lDebug.Caption := 'Wrong boatNumber, needs to start with "M" or "S".';
      exit();
    end;

  end

  else if (instanceExists = 1) then
    // TMotorboat -> save data
  begin
    if (saveDialog.Execute = True) then
    begin
      AssignFile(aTextFile, saveDialog.FileName);
      Rewrite(aTextFile);
      row := mBoat.getInfoHTML();
      Write(aTextFile, row);

      try
        CloseFile(aTextFile);
      except;
        ShowMessage('An error occured while saving your file.');
      end;
    end;
  end

  else if (instanceExists = 2) then
    // TSailboat - save data
  begin
    if (saveDialog.Execute = True) then
    begin
      AssignFile(aTextFile, saveDialog.FileName);
      Rewrite(aTextFile);
      row := sBoat.getInfoHTML();
      Write(aTextFile, row);

      try
        CloseFile(aTextFile);
      except;
        ShowMessage('An error occured while saving your file.');
      end;
    end;
  end

  else
    // no object, but not 0?
  begin
    ShowMessage('An unknown error occured, please restart.');
    exit();
  end;

end;

end.









