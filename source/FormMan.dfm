object ManualControlForm: TManualControlForm
  Left = 111
  Top = 137
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051'-'#1055#1040#1050'. '#1040#1075#1088#1077#1075#1072#1090' '#1088#1077#1079#1082#1080'. '#1056#1091#1095#1085#1086#1077' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1077'.'
  ClientHeight = 720
  ClientWidth = 1020
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbZadRezult: TLabel
    Left = 725
    Top = 344
    Width = 286
    Height = 13
    AutoSize = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 1
    Top = 0
    Width = 1013
    Height = 338
    Caption = #1057#1090#1072#1085#1086#1082' 1'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 450
      Top = 16
      Width = 77
      Height = 22
      Caption = #1056#1080#1083#1077#1074#1082#1080
    end
    object Label2: TLabel
      Left = 460
      Top = 180
      Width = 44
      Height = 22
      Caption = #1053#1086#1078#1080
    end
    object GroupBox3: TGroupBox
      Left = 612
      Top = 180
      Width = 399
      Height = 155
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object btAllST1UP: TButton
        Left = 210
        Top = 40
        Width = 153
        Height = 33
        Caption = #1055#1086#1076#1085#1103#1090#1100' '#1074#1089#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btAllST1UPClick
      end
      object btZadST1Down: TButton
        Left = 210
        Top = 75
        Width = 153
        Height = 33
        Caption = #1054#1087#1091#1089#1090#1080#1090#1100' '#1088#1072#1073#1086#1095#1080#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btZadST1DownClick
      end
      object btAutoZadanie1: TButton
        Left = 56
        Top = 40
        Width = 153
        Height = 33
        Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btAutoZadanie1Click
      end
      object btAutoStart1: TButton
        Left = 56
        Top = 75
        Width = 153
        Height = 33
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btAutoStart1Click
      end
      object bt1: TButton
        Left = 56
        Top = 110
        Width = 153
        Height = 33
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object btFreeST1UP: TButton
        Left = 210
        Top = 110
        Width = 153
        Height = 33
        Caption = #1055#1086#1076#1085#1103#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btFreeST1UPClick
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 1
    Top = 360
    Width = 1013
    Height = 338
    Caption = #1057#1090#1072#1085#1086#1082' 2'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 450
      Top = 16
      Width = 77
      Height = 22
      Caption = #1056#1080#1083#1077#1074#1082#1080
    end
    object Label4: TLabel
      Left = 460
      Top = 180
      Width = 44
      Height = 22
      Caption = #1053#1086#1078#1080
    end
    object GroupBox4: TGroupBox
      Left = 612
      Top = 180
      Width = 399
      Height = 155
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object btAllST2UP: TButton
        Left = 210
        Top = 40
        Width = 153
        Height = 33
        Caption = #1055#1086#1076#1085#1103#1090#1100' '#1074#1089#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btAllST2UPClick
      end
      object btZadST2Down: TButton
        Left = 210
        Top = 75
        Width = 153
        Height = 33
        Caption = #1054#1087#1091#1089#1090#1080#1090#1100' '#1088#1072#1073#1086#1095#1080#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btZadST2DownClick
      end
      object btAutoZadanie2: TButton
        Left = 56
        Top = 40
        Width = 153
        Height = 33
        Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btAutoZadanie2Click
      end
      object btAutoStart2: TButton
        Left = 56
        Top = 75
        Width = 153
        Height = 33
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btAutoStart2Click
      end
      object bt2: TButton
        Left = 56
        Top = 110
        Width = 153
        Height = 33
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object btFreeST2UP: TButton
        Left = 210
        Top = 110
        Width = 153
        Height = 33
        Caption = #1055#1086#1076#1085#1103#1090#1100' '#1089#1074#1086#1073#1086#1076#1085#1099#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = btFreeST2UPClick
      end
    end
  end
  object edZadanie: TEdit
    Left = 1
    Top = 340
    Width = 720
    Height = 21
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnDblClick = edZadanieDblClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 701
    Width = 1020
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object MainReadTimer: TTimer
    Enabled = False
    OnTimer = MainReadTimerTimer
    Left = 909
    Top = 24
  end
  object MainMenu1: TMainMenu
    Left = 848
    Top = 64
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object mnSaveState: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
        ShortCut = 123
        OnClick = mnSaveStateClick
      end
    end
    object mnSet: TMenuItem
      Caption = 'F1:'#1053#1072#1089#1090#1088#1086#1081#1082#1072
      object mnSetup: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
        ShortCut = 112
        OnClick = mnSetupClick
      end
      object mnSetupWork: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1073#1086#1095#1080#1093
        ShortCut = 8304
        OnClick = mnSetupWorkClick
      end
    end
    object mnNewZad: TMenuItem
      Caption = 'F2:'#1053#1086#1074#1086#1077' '#1079#1072#1076#1072#1085#1080#1077
      ShortCut = 113
      OnClick = mnNewZadClick
    end
    object mnAutoZad1: TMenuItem
      Caption = 'F3:'#1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1085#1072' '#1089#1090#1072#1085#1082#1077' 1'
      ShortCut = 114
      OnClick = mnAutoZad1Click
    end
    object mnAutoZad2: TMenuItem
      Caption = 'F4:'#1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1085#1072' '#1089#1090#1072#1085#1082#1077' 2'
      ShortCut = 115
      OnClick = mnAutoZad2Click
    end
    object mnNewGUI: TMenuItem
      Caption = 'F5:'#1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1077
      ShortCut = 116
      OnClick = mnNewGUIClick
    end
  end
end
