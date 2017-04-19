unit TapeCounter_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 30.10.2009 11:45:03 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\BURSA\TapeCounter\Source\Source\TapeCounter.tlb (1)
// LIBID: {E16C8863-2764-4B6B-A6F1-24182C7C75BF}
// LCID: 0
// Helpfile: 
// HelpString: TapeCounter Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  TapeCounterMajorVersion = 1;
  TapeCounterMinorVersion = 0;

  LIBID_TapeCounter: TGUID = '{E16C8863-2764-4B6B-A6F1-24182C7C75BF}';

  IID_IComPort: TGUID = '{7B0CE0D0-B65D-4D5C-A247-9FA20794D5C9}';
  CLASS_ComPort: TGUID = '{FA0B3FBC-9B06-4B60-AAF4-5DFB98051691}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IComPort = interface;
  IComPortDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ComPort = IComPort;


// *********************************************************************//
// Interface: IComPort
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7B0CE0D0-B65D-4D5C-A247-9FA20794D5C9}
// *********************************************************************//
  IComPort = interface(IDispatch)
    ['{7B0CE0D0-B65D-4D5C-A247-9FA20794D5C9}']
    procedure Clear_; safecall;
    function Get_Num_: WideString; safecall;
    procedure Set_Num_(const Value: WideString); safecall;
    function Get_Value_: WideString; safecall;
    procedure Set_Value_(const Value: WideString); safecall;
    function Get_Num__: WideString; safecall;
    procedure Set_Num__(const Value: WideString); safecall;
    function Get_Value__: WideString; safecall;
    procedure Set_Value__(const Value: WideString); safecall;
    function Get_id_sm_times: WideString; safecall;
    procedure Set_id_sm_times(const Value: WideString); safecall;
    function Get_count_idles: WideString; safecall;
    procedure Set_count_idles(const Value: WideString); safecall;
    function Get_id_pz: WideString; safecall;
    procedure Set_id_pz(const Value: WideString); safecall;
    function Get_sm1: WideString; safecall;
    procedure Set_sm1(const Value: WideString); safecall;
    function Get_sm3: WideString; safecall;
    procedure Set_sm3(const Value: WideString); safecall;
    function Get_sm5: WideString; safecall;
    procedure Set_sm5(const Value: WideString); safecall;
    function Get_syrie: WideString; safecall;
    procedure Set_syrie(const Value: WideString); safecall;
    function Get_ADD_C: WideString; safecall;
    procedure Set_ADD_C(const Value: WideString); safecall;
    function Get_freez1: WideString; safecall;
    procedure Set_freez1(const Value: WideString); safecall;
    function Get_freez3: WideString; safecall;
    procedure Set_freez3(const Value: WideString); safecall;
    function Get_freez5: WideString; safecall;
    procedure Set_freez5(const Value: WideString); safecall;
    function Get_rest: Integer; safecall;
    procedure Set_rest(Value: Integer); safecall;
    function Get_sm53: WideString; safecall;
    procedure Set_sm53(const Value: WideString); safecall;
    function Get_restpz: WideString; safecall;
    procedure Set_restpz(const Value: WideString); safecall;
    property Num_: WideString read Get_Num_ write Set_Num_;
    property Value_: WideString read Get_Value_ write Set_Value_;
    property Num__: WideString read Get_Num__ write Set_Num__;
    property Value__: WideString read Get_Value__ write Set_Value__;
    property id_sm_times: WideString read Get_id_sm_times write Set_id_sm_times;
    property count_idles: WideString read Get_count_idles write Set_count_idles;
    property id_pz: WideString read Get_id_pz write Set_id_pz;
    property sm1: WideString read Get_sm1 write Set_sm1;
    property sm3: WideString read Get_sm3 write Set_sm3;
    property sm5: WideString read Get_sm5 write Set_sm5;
    property syrie: WideString read Get_syrie write Set_syrie;
    property ADD_C: WideString read Get_ADD_C write Set_ADD_C;
    property freez1: WideString read Get_freez1 write Set_freez1;
    property freez3: WideString read Get_freez3 write Set_freez3;
    property freez5: WideString read Get_freez5 write Set_freez5;
    property rest: Integer read Get_rest write Set_rest;
    property sm53: WideString read Get_sm53 write Set_sm53;
    property restpz: WideString read Get_restpz write Set_restpz;
  end;

// *********************************************************************//
// DispIntf:  IComPortDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7B0CE0D0-B65D-4D5C-A247-9FA20794D5C9}
// *********************************************************************//
  IComPortDisp = dispinterface
    ['{7B0CE0D0-B65D-4D5C-A247-9FA20794D5C9}']
    procedure Clear_; dispid 201;
    property Num_: WideString dispid 202;
    property Value_: WideString dispid 203;
    property Num__: WideString dispid 204;
    property Value__: WideString dispid 205;
    property id_sm_times: WideString dispid 206;
    property count_idles: WideString dispid 207;
    property id_pz: WideString dispid 208;
    property sm1: WideString dispid 209;
    property sm3: WideString dispid 210;
    property sm5: WideString dispid 211;
    property syrie: WideString dispid 212;
    property ADD_C: WideString dispid 213;
    property freez1: WideString dispid 214;
    property freez3: WideString dispid 215;
    property freez5: WideString dispid 216;
    property rest: Integer dispid 217;
    property sm53: WideString dispid 218;
    property restpz: WideString dispid 219;
  end;

// *********************************************************************//
// The Class CoComPort provides a Create and CreateRemote method to          
// create instances of the default interface IComPort exposed by              
// the CoClass ComPort. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComPort = class
    class function Create: IComPort;
    class function CreateRemote(const MachineName: string): IComPort;
  end;

implementation

uses ComObj;

class function CoComPort.Create: IComPort;
begin
  Result := CreateComObject(CLASS_ComPort) as IComPort;
end;

class function CoComPort.CreateRemote(const MachineName: string): IComPort;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ComPort) as IComPort;
end;

end.
