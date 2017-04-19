object FPZ: TFPZ
  Left = 253
  Top = 97
  Width = 696
  Height = 500
  Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 688
    Height = 432
    Align = alClient
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 688
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 8
      Top = 10
      Width = 81
      Height = 25
      Caption = #1044#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 112
      Top = 10
      Width = 81
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Database1: TDatabase
    AliasName = 'sklado'
    DatabaseName = 'Skladlso'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=german'
      'PASSWORD=blis')
    SessionName = 'Default'
    Left = 48
    Top = 80
  end
  object QPZ: TQuery
    DatabaseName = 'Skladlso'
    SQL.Strings = (
      'select z.num, z.pz_line, substr(z.pz_line,1,200) as l, z.knifes'
      'from system.pz_line l, system.proiz_zad z'
      'where l.id_pz=z.id_pz'
      ''
      'order by l.id_ln')
    Left = 56
    Top = 39
    object QPZNUM: TStringField
      DisplayLabel = #8470
      DisplayWidth = 11
      FieldName = 'NUM'
      Origin = 'SKLADLSO.PROIZ_ZAD.NUM'
      Size = 10
    end
    object QPZPZ_LINE: TMemoField
      FieldName = 'PZ_LINE'
      Origin = 'SKLADLSO.PROIZ_ZAD.PZ_LINE'
      Visible = False
      BlobType = ftMemo
      Size = 400
    end
    object QPZL: TStringField
      DisplayLabel = #1057#1090#1088#1086#1082#1072
      FieldName = 'L'
      Size = 200
    end
    object QPZKNIFES: TStringField
      FieldName = 'KNIFES'
    end
  end
  object DataSource1: TDataSource
    DataSet = QPZ
    Left = 88
    Top = 80
  end
end
