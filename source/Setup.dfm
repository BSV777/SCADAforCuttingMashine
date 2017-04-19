object SetupForm: TSetupForm
  Left = 286
  Top = 196
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1090#1086#1095#1082#1080' '#1086#1090#1089#1095#1077#1090#1072
  ClientHeight = 292
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 1
    Top = 0
    Width = 368
    Height = 290
    Caption = #1057#1090#1072#1085#1086#1082' 1'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 66
      Top = 24
      Width = 77
      Height = 22
      Caption = #1056#1080#1083#1077#1074#1082#1080
    end
    object Label2: TLabel
      Left = 258
      Top = 24
      Width = 44
      Height = 22
      Caption = #1053#1086#1078#1080
    end
    object sgST1R: TStringGrid
      Left = 8
      Top = 48
      Width = 172
      Height = 234
      ColCount = 3
      DefaultRowHeight = 20
      RowCount = 11
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      OnDrawCell = sgST1RDrawCell
    end
    object sgST1BL: TStringGrid
      Left = 190
      Top = 48
      Width = 172
      Height = 150
      ColCount = 3
      DefaultRowHeight = 20
      RowCount = 7
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      OnDrawCell = sgST1BLDrawCell
    end
    object btSend1ToPLC: TButton
      Left = 214
      Top = 224
      Width = 137
      Height = 33
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btSend1ToPLCClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 373
    Top = 0
    Width = 368
    Height = 290
    Caption = #1057#1090#1072#1085#1086#1082' 2'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 66
      Top = 24
      Width = 77
      Height = 22
      Caption = #1056#1080#1083#1077#1074#1082#1080
    end
    object Label4: TLabel
      Left = 258
      Top = 24
      Width = 44
      Height = 22
      Caption = #1053#1086#1078#1080
    end
    object sgST2R: TStringGrid
      Left = 8
      Top = 48
      Width = 172
      Height = 234
      ColCount = 3
      DefaultRowHeight = 20
      RowCount = 11
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      OnDrawCell = sgST2RDrawCell
    end
    object sgST2BL: TStringGrid
      Left = 190
      Top = 48
      Width = 172
      Height = 150
      ColCount = 3
      DefaultRowHeight = 20
      RowCount = 7
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      OnDrawCell = sgST2BLDrawCell
    end
    object btSend2ToPLC: TButton
      Left = 214
      Top = 224
      Width = 137
      Height = 33
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btSend2ToPLCClick
    end
  end
  object ReadPosTimer: TTimer
    OnTimer = ReadPosTimerTimer
    Left = 328
    Top = 16
  end
end
