program GetDateTime;

{
  Jacek Pazera
  https://github.com/jackdp/GetDateTime
  https://www.pazera-software.com

  License: public domain
}

{$mode objfpc}{$H+}

uses
  // RTL
  SysUtils, DateUtils,

  // JPLib
  JPL.Console, JPL.TStr, JPL.Conversion
  ;


const
  DEFAULT_TEMPLATE = '$Y.$M.$D-$H;$MIN;$S,$MS';
  APP_VERSION = '1.0';
  APP_DATE = '2022.07.12';
  APP_AUTHOR = 'JP';
  APP_URL = 'https://github.com/jackdp/GetDateTime';

  {$IFDEF CPUX64}
  APP_BITS_STR = '64';
  {$ELSE}
  APP_BITS_STR = '32';
  {$ENDIF}

  INFO_STR = 'Version ' + APP_VERSION + ', ' + APP_DATE + ', ' + APP_BITS_STR + '-bit, ' + APP_AUTHOR + ENDL + APP_URL;

var
  dtNow: TDateTime;
  MyName, Param1, UParam1: string;


function GetDateTimeStr(const ADateTime: TDateTime; const Template: string): string;
var
  xYear, xMonth, xDay, xHour, xMinute, xSecond, xMs: Word;
  sYear, sMonth, sDay, sHour, sMinute, sSecond, sMs: string;
begin
  DecodeDateTime(ADateTime, xYear, xMonth, xDay, xHour, xMinute, xSecond, xMs);

  sYear := itos(xYear);
  sMonth := TStr.Pad(itos(xMonth), 2, '0');
  sDay := TStr.Pad(itos(xDay), 2, '0');
  sHour := TStr.Pad(itos(xHour), 2, '0');
  sMinute := TStr.Pad(itos(xMinute), 2, '0');
  sSecond := TStr.Pad(itos(xSecond), 2, '0');
  sMs := TStr.Pad(itos(xMs), 3, '0');

  Result := Template;

  // Do not change order!
  Result := TStr.ReplaceAll(Result, '$Y', sYear, True);
  Result := TStr.ReplaceAll(Result, '$MIN', sMinute, True);
  Result := TStr.ReplaceAll(Result, '$MS', sMs, True);
  Result := TStr.ReplaceAll(Result, '$M', sMonth, True);
  Result := TStr.ReplaceAll(Result, '$D', sDay, True);
  Result := TStr.ReplaceAll(Result, '$H', sHour, True);
  Result := TStr.ReplaceAll(Result, '$S', sSecond, True);
end;

procedure ShowUsage;
var
  clTimePart, clTMPL: string;

  function Tag(const s: string): string;
  begin
    Result := '<color=' + clTimePart + '>' + s + '</color>';
  end;

begin
  clTMPL := 'lightmagenta';
  clTimePart := 'blue,black';

  TConsole.WriteTaggedTextLine('Usage: ' + MyName + ' [<color=' + clTMPL + '>TEMPLATE</color>]');
  Writeln(INFO_STR);
  Writeln;

  TConsole.WriteTaggedTextLine(
    '<color=' + clTMPL + '>TEMPLATE</color>: Any text where the ' +
    Tag('$Y') + ' will be replaced with the current year, ' +
    Tag('$M') + ' - month, ' +
    Tag('$D') + ' - day, ' +
    Tag('$H') + ' - hour, ' +
    Tag('$MIN') + ' - minutes, ' +
    Tag('$S') + ' - seconds, ' +
    Tag('$MS') + ' - milliseconds'
  );
  Writeln;
  TConsole.WriteTaggedText('Default <color=' + clTMPL + '>TEMPLATE</color>: ' + Tag(DEFAULT_TEMPLATE));
  TConsole.WriteTaggedTextLine('    <color=darkgray>==> ' + GetDateTimeStr(dtNow, DEFAULT_TEMPLATE) + '</color>');
end;


{$R *.res}

//////////////////////////// ENTRY POINT ////////////////////////////
var
  i: integer;
begin
  {$IF DECLARED(UseHeapTrace)}
  GlobalSkipIfNoLeaks := True; // supported as of debugger version 3.2.0
  {$ENDIF}

  dtNow := Now;

  MyName := ExtractFileName(ParamStr(0));

  Param1 := Trim(ParamStr(1));
  UParam1 := UpperCase(Param1);
  if (Param1 = '/?') or (UParam1 = '-H') or (UParam1 = '--HELP') then
  begin
    ShowUsage;
    Exit;
  end;

  if ParamCount = 0 then Param1 := DEFAULT_TEMPLATE
  else
    for i := 2 to ParamCount do
      Param1 := Param1 + ' ' + ParamStr(i);

  Write(GetDateTimeStr(dtNow, Param1));
end.

