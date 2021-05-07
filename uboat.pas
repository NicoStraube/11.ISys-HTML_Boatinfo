unit UBoat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  // TBoat
  TBoat = class(TObject)
  private
  public
    boatNumber_, boatName_: string;
    // constructor Create(boatNumber, boatName: string);
  protected
  end;

  // TMotorboat
  TMotorboat = class(TBoat)
  private
    enginePower_: real;
  public
    constructor Create(boatNumber, boatName: string; enginePower: real);
    function getInfoHTML(): string;
  protected
  end;

  // TSailboat
  TSailboat = class(TBoat)
  private
    sailArea_: real;
    personsMin_: integer;
  public
    constructor Create(boatNumber, boatName: string; sailArea: real;
      personsMin: integer);
    function getInfoHTML(): string;
  protected
  end;

implementation


// TBoat
// Hier habe ich den Sinn des constructors nicht ganz verstanden, vielleicht könnten Sie mir das näher erläutern.

// TMotorboat
constructor TMotorboat.Create(boatNumber, boatName: string; enginePower: real);
begin
  boatNumber_ := boatNumber;
  boatName_ := boatName;
  enginePower_ := enginePower;
end;

function TMotorboat.getInfoHTML(): string;
begin
  Result := '<!DOCTYPE HTML> <html lang="de"> <meta charset="UTF-8">' +
    '<head><title>Info.- Prüflingsnummer 0815</title> <style type="text/css"> table,tr{border-collapse: collapse;border: 1px solid black;}td {padding: 3px}</style></head>' + '<body> <center><h2>HTML-Bootsinfo</h2><p>Type: Motorboat</p><hr style="width: 75%"><p>' + '<div>' + '<table>' + '<tr>' + '<td>Boatnumber:</td>' + '<td>' + boatNumber_ + '</td>' + '</tr>' + '<tr>' + '<td>Boatname:</td>' + '<td>' + boatName_ + '</td>' + '</tr>' + '<tr>' + '<td>Engine power in kW:</td>' + '<td>' + FloatToStr(enginePower_) + '</td>' + '</tr>' + '</table>' + '</div>' + '</center>' + '</body>' + '</html>';
end;

// TSailboat
constructor TSailboat.Create(boatNumber, boatName: string; sailArea: real;
  personsMin: integer);
begin
  boatNumber_ := boatNumber;
  boatName_ := boatName;
  sailArea_ := sailArea;
  personsMin_ := personsMin;
end;

function TSailboat.getInfoHTML(): string;
begin
  Result := '<!DOCTYPE HTML> <html lang="de"> <meta charset="UTF-8">' +
    '<head><title>Info.- Prüflingsnummer 0815</title> <style type="text/css"> table,tr{border-collapse: collapse;border: 1px solid black;}td {padding: 3px}</style></head>' + '<body> <center><h2>HTML-Bootsinfo</h2><p>Type: Sailboat<p><hr style="width: 75%"><p>' + '<div>' + '<table>' + '<tr>' + '<td>Boatnumber:</td>' + '<td>' + boatNumber_ + '</td>' + '</tr>' + '<tr>' + '<td>Boatname:</td>' + '<td>' + boatName_ + '</td>' + '</tr>' + '<tr>' + '<td>Sailarea in cm³:</td>' + '<td>' + FloatToStr(sailArea_) + '</td>' + '</tr>' + '</tr>' + '<tr>' + '<td>Persons min:</td>' + '<td>' + IntToStr(personsMin_) + '</td>' + '</tr>' + '</table></div></center></body></html>';
end;

end.
