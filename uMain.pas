unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,System.bluetooth, FMX.Edit;

type
  TfrmMain = class(TForm)
    CornerButton1: TCornerButton;
    txtPrinterName: TEdit;
    Label1: TLabel;
    procedure CornerButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    LDevice: TBluetoothDevice;
    Manager: TBluetoothManager;
      LSockect: TBluetoothSocket;
        SelDevice:TBluetoothDevice;
          Guid:TGUID;
  public
    { Public declarations }
    function FindBTDevice(Device: string): TBluetoothDevice;
    procedure printStruk();
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
procedure TfrmMain.printStruk();
var
  I : Integer;
  cad : String;
 	Buff: TBytes;



  BluetoothAdapter: TBluetoothAdapter;
  ListBluetooth:TBluetoothDeviceList;
  FBluetoothManager:TBluetoothManager;
  DX:String;
  SND:TBytes;
  B:Integer;
  LServices: TBluetoothServiceList;
  ServiceGUI, ServiceName:String;



  MLsocket:TBluetoothSocket;

  lprintheader: string;
  lprintfooter: string;
begin

if LDevice.IsPaired then
  begin
  LServices := LDevice.GetServices;
  SelDevice:=LDevice;


  serviceGUI:='{00001101-0000-1000-8000-00805F9B34FB}';
  serviceName:='SerialPort';
  guid:= StringToGUID(servicegui);
  end;

{/device}

	if (LDevice <> nil) then
	begin

  LSockect := SelDevice.CreateClientSocket(Guid, true);   //was LDevice
  if (Assigned(LDevice)) And (Assigned(LSockect))
    then
      Begin
      if Not LSockect.Connected then
        LSockect.Connect
      End
    else
      Begin
      LSockect := SelDevice.CreateClientSocket(Guid, True);
      LSockect.Connect; //pindah ke button
      End;


  lprintheader:=lprintheader+'1015687';
  if Assigned(LSockect) then
    Begin
    if LSockect.Connected
      then
        Begin
        DX := lprintheader;
        SND := TEncoding.UTF8.GetBytes(DX);
        LSockect.SendData(SND);

        Sleep(100);
        End;
    End;


  end;
end;
procedure TfrmMain.CornerButton1Click(Sender: TObject);
begin
printStruk;
end;

function TfrmMain.FindBTDevice(Device: string): TBluetoothDevice;
var
  I: integer;
  LDevice: TBluetoothDevice;
	KnownDevices: TBluetoothDeviceList;
begin
  //if assigned(LDevice) then exit;

  KnownDevices := Manager.GetPairedDevices(Manager.CurrentAdapter);
  for I := 0 to KnownDevices.Count - 1 do
  begin
    LDevice := KnownDevices.Items[I];
    if Device = LDevice.DeviceName then Exit(LDevice);
  end;

  KnownDevices := Manager.LastDiscoveredDevices;
  for I := 0 to KnownDevices.Count - 1  do
  begin
    LDevice := KnownDevices.Items[I];
    if Device = LDevice.DeviceName then Exit(LDevice);
  end;

  Result := nil;
end;
procedure TfrmMain.FormCreate(Sender: TObject);
begin
Manager := TBluetoothManager.Current;
  if ldevice=nil then
      LDevice := FindBTDevice(txtPrinterName.text);
end;

end.
