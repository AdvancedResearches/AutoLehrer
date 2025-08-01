//
//  NextGen_UI_Style.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 12.04.25.
//

import SwiftUI

enum NG_UISchema{
    case NG_UISchema_Regular_Bright
    case NG_UISchema_Regular_Dark
}

enum NG_TextField{
    case NG_TextField_Regular
    case NG_TextField_Attention
}

public enum NG_TextStyle{
    case NG_TextStyle_Title
    case NG_TextStyle_Title_Sheet
    case NG_TextStyle_SectionHeader
    case NG_TextStyle_Text_Big
    case NG_TextStyle_Text_Regular
    case NG_TextStyle_Text_Small
    case NG_TextStyle_AppWizard
    case NG_TextStyle_Color_ListRow_Top
    case NG_TextStyle_Color_ListRow_Second
    case NG_TextStyle_Color_Grid_MasterHeader
    case NG_TextStyle_Color_Grid_SubHeader
    case NG_TextStyle_Color_Grid_Row
    case NG_TextStyle_Metric_Count
    case NG_TextStyle_Metric_Load
}

public enum NG_TextColor{
    case NG_TextColor_Red
    case NG_TextColor_Green
    case NG_TextColor_Regular
    case NG_TextColor_Disabled
    case NG_TextColor_Muscle_Fatigue_NotTired
    case NG_TextColor_Muscle_Fatigue_SlightlyTired
    case NG_TextColor_Muscle_Fatigue_Tired
    case NG_TextColor_Muscle_Fatigue_VeryTired
    case NG_TextColor_Muscle_Fatigue_Damaged
    case NG_TextColor_Muscle_Development_Undefined
    case NG_TextColor_Muscle_Development_Underdeveloped
    case NG_TextColor_Muscle_Development_Developed
}

enum NG_IconStyle{
    case NG_IconStyle_Regular
    case NG_IconStyle_Disabled
    case NG_IconStyle_Red
    case NG_IconStyle_Green
    case NG_IconStyle_Transparent
}

enum NG_ButtonStyle{
    case NG_ButtonStyle_Regular
    case NG_ButtonStyle_Service
    case NG_ButtonStyle_Red
    case NG_ButtonStyle_Green
    case NG_ButtonStyle_DatePicker
    case NG_ButtonStyle_Skipped
    case NG_ButtonStyle_Easy
    case NG_ButtonStyle_Normal
    case NG_ButtonStyle_Hard
}

enum NG_CardStyle{
    case NG_CardStyle_AppWizard
    case NG_CardStyle_Regular
    case NG_CardStyle_Red
    case NG_CardStyle_Green
    case NG_CardStyle_Training_Completed
    case NG_CardStyle_Training_InProgress
    case NG_CardStyle_Training_Passed
    case NG_CardStyle_Training_Future
    case NG_CardStyle_Training_Today
    case NG_CardStyle_Metric_NotStarted
    case NG_CardStyle_Metric_Skipped
    case NG_CardStyle_Metric_Easy
    case NG_CardStyle_Metric_Normal
    case NG_CardStyle_Metric_Hard
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
    
    static let NG_RawColor_Black: Color                                  = Color(hex: "#000000")
    static let NG_RawColor_VeryDarkGray: Color                           = Color(hex: "#1A1A1A") // Очень тёмно-серый
    static let NG_RawColor_DarkGray: Color                               = Color(hex: "#2E2E2E") // Темно-серый
    static let NG_RawColor_MediumGray: Color                             = Color(hex: "#555555") // Средне-серый
    static let NG_RawColor_BrightGray: Color                             = Color(hex: "#AAAAAA") // Светло-серый
    static let NG_RawColor_VeryBrightGray: Color                         = Color(hex: "#EEEEEE") // Очень светло-серый
    static let NG_RawColor_White: Color                                  = Color(hex: "#FFFFFF")
    
    static let NG_RawColor_VeryDarkPink: Color                           = Color(hex: "#B48D89") // Очень тёмно-розовый (оттенок от MediumPink)
    static let NG_RawColor_DarkPink: Color                               = Color(hex: "#D2B2AE") // Тёмно-розовый (оттенок от MediumPink)
    static let NG_RawColor_MediumPink: Color                             = Color(hex: "#F3E3E0") // Нежно-розовый (медиум)
    static let NG_RawColor_BrightPink: Color                             = Color(hex: "#FBEDEC") // Светло-розовый (оттенок от MediumPink)
    static let NG_RawColor_VeryBrightPink: Color                         = Color(hex: "#FFF6F5") // Очень светло-розовый (оттенок от MediumPink)
    
    static let NG_RawColor_VeryDarkBlue: Color                           = Color(hex: "#1A2A4A") // Очень тёмно-синий
    static let NG_RawColor_DarkBlue: Color                               = Color(hex: "#2F4F6F") // Тёмно-синий
    static let NG_RawColor_MediumBlue: Color                             = Color(hex: "#4A6A8F") // Средне-синий
    static let NG_RawColor_BrightBlue: Color                             = Color(hex: "#A5C4E5") // Светло-синий
    static let NG_RawColor_VeryBrightBlue: Color                         = Color(hex: "#EAF2FB") // Очень светло-синий
    
    static let NG_RawColor_VeryDarkGrayBlue: Color                       = Color(hex: "#1D2935") // Очень тёмно-серовато-синий
    static let NG_RawColor_DarkGrayBlue: Color                           = Color(hex: "#2F3E50") // Тёмно-серовато-синий
    static let NG_RawColor_MediumGrayBlue: Color                         = Color(hex: "#4A5C70") // Средне-серовато-синий
    static let NG_RawColor_BrightGrayBlue: Color                         = Color(hex: "#A3B4C5") // Светло-серовато-синий
    static let NG_RawColor_VeryBrightGrayBlue: Color                     = Color(hex: "#EDF1F5") // Очень светло-серовато-синий
    
    static let NG_RawColor_VeryDarkGreen: Color                          = Color(hex: "#1A3A1A") // Очень тёмно-зелёный
    static let NG_RawColor_DarkGreen: Color                              = Color(hex: "#2E5F2E") // Тёмно-зелёный
    static let NG_RawColor_MediumGreen: Color                            = Color(hex: "#4A8A4A") // Средне-зелёный
    static let NG_RawColor_BrightGreen: Color                            = Color(hex: "#A5D6A5") // Светло-зелёный
    static let NG_RawColor_VeryBrightGreen: Color                        = Color(hex: "#EAF9EA") // Очень светло-зелёный
    
    static let NG_RawColor_VeryDarkPureGreen: Color                      = Color(hex: "#004000") // Очень тёмный чисто-зелёный
    static let NG_RawColor_DarkPureGreen: Color                          = Color(hex: "#008000") // Тёмный чисто-зелёный
    static let NG_RawColor_MediumPureGreen: Color                        = Color(hex: "#00FF00") // Базовый чисто-зелёный
    static let NG_RawColor_BrightPureGreen: Color                        = Color(hex: "#66FF66") // Светлый чисто-зелёный
    static let NG_RawColor_VeryBrightPureGreen: Color                    = Color(hex: "#E5FFE5") // Очень светлый чисто-зелёный
    
    static let NG_RawColor_VeryDarkRed: Color                            = Color(hex: "#4A1A1A") // Очень тёмно-красный
    static let NG_RawColor_DarkRed: Color                                = Color(hex: "#6F2F2F") // Тёмно-красный
    static let NG_RawColor_MediumRed: Color                              = Color(hex: "#8F4A4A") // Средне-красный
    static let NG_RawColor_BrightRed: Color                              = Color(hex: "#E5A5A5") // Светло-красный
    static let NG_RawColor_VeryBrightRed: Color                          = Color(hex: "#FBEAEA") // Очень светло-красный
    
    static let NG_RawColor_VeryDarkPureRed: Color                        = Color(hex: "#400000") // Очень тёмный чисто-красный (пересчитанный)
    static let NG_RawColor_DarkPureRed: Color                            = Color(hex: "#800000") // Тёмный чисто-красный (пересчитанный)
    static let NG_RawColor_MediumPureRed: Color                          = Color(hex: "#FF0000") // Базовый чисто-красный
    static let NG_RawColor_BrightPureRed: Color                          = Color(hex: "#FF6666") // Светлый чисто-красный (пересчитанный)
    static let NG_RawColor_VeryBrightPureRed: Color                      = Color(hex: "#FFE5E5") // Очень светлый чисто-красный (пересчитанный)
    
    static let NG_RawColor_VeryDarkPureBlue: Color                       = Color(hex: "#000040") // Очень тёмный чисто-синий
    static let NG_RawColor_DarkPureBlue: Color                           = Color(hex: "#000080") // Тёмный чисто-синий
    static let NG_RawColor_MediumPureBlue: Color                         = Color(hex: "#0000FF") // Базовый чисто-синий
    static let NG_RawColor_BrightPureBlue: Color                         = Color(hex: "#6666FF") // Светлый чисто-синий
    static let NG_RawColor_VeryBrightPureBlue: Color                     = Color(hex: "#E5E5FF") // Очень светлый чисто-синий
    
    static let NG_RawColor_VeryDarkLime: Color                           = Color(hex: "#3A4A1A") // Очень тёмный лаймовый
    static let NG_RawColor_DarkLime: Color                               = Color(hex: "#5F6F2F") // Тёмный лаймовый
    static let NG_RawColor_MediumLime: Color                             = Color(hex: "#7A8F4A") // Средний лаймовый
    static let NG_RawColor_BrightLime: Color                             = Color(hex: "#D6E5A5") // Светлый лаймовый
    static let NG_RawColor_VeryBrightLime: Color                         = Color(hex: "#F5FBEA") // Очень светлый лаймовый
    
    static let NG_RawColor_VeryDarkCyan: Color                           = Color(hex: "#1A3A4A") // Очень тёмно-голубой
    static let NG_RawColor_DarkCyan: Color                               = Color(hex: "#2F5F6F") // Тёмно-голубой
    static let NG_RawColor_MediumCyan: Color                             = Color(hex: "#4A8A9F") // Средне-голубой
    static let NG_RawColor_BrightCyan: Color                             = Color(hex: "#A5D6E5") // Светло-голубой
    static let NG_RawColor_VeryBrightCyan: Color                         = Color(hex: "#EAFBFD") // Очень светло-голубой
    
    static let NG_RawColor_VeryDarkPureCyan: Color                      = Color(hex: "#004040") // Очень тёмный чисто-голубой
    static let NG_RawColor_DarkPureCyan: Color                          = Color(hex: "#008080") // Тёмный чисто-голубой
    static let NG_RawColor_MediumPureCyan: Color                        = Color(hex: "#00FFFF") // Базовый чисто-голубой
    static let NG_RawColor_BrightPureCyan: Color                        = Color(hex: "#66FFFF") // Светлый чисто-голубой
    static let NG_RawColor_VeryBrightPureCyan: Color                    = Color(hex: "#E5FFFF") // Очень светлый чисто-голубой
    
    
    //static let NR_Raw_regularButtonStart = Color(hex: "#6692C3")  // Синий-фиолетовый (слева)
    static let NG_RawColor_CoolCornflowerBlue = Color(hex: "#6692C3")  // Синий-фиолетовый (слева)
    
    //static let NR_Raw_regularButtonEnd = Color(hex: "#405C96")    // Голубой (справа)
    static let NG_RawColor_DeepSapphireBlue = Color(hex: "#405C96")    // Голубой (справа)
    
    //static let NR_Raw_regularButtonBridghtBorder = Color(hex: "#CCD9E3")
    static let NG_RawColor_IcyMistBlue = Color(hex: "#CCD9E3")
    
    //static let NR_Raw_regularButtonDarkBorder = Color(hex: "#173A6B")
    static let NG_RawColor_MidnightIndigo = Color(hex: "#173A6B")
    
    //static let NR_Raw_serviceButtonStart = Color(hex: "#93A3BA") // темнее, графит с синевой
    static let NG_RawColor_SteelMistBlue = Color(hex: "#93A3BA") // темнее, графит с синевой
    
    //static let NR_Raw_serviceButtonEnd = Color(hex: "#607493")
    static let NG_RawColor_SlateSkyBlue = Color(hex: "#607493")
    
    //static let NR_Raw_serviceButtonBridghtBorder = Color(hex: "#C9D4DF")
    static let NG_RawColor_PaleFrostBlue = Color(hex: "#C9D4DF")
    
    //static let NR_Raw_serviceButtonDarkBorder = Color(hex: "#16396C")
    static let NG_RawColor_MarineTwilightBlue = Color(hex: "#16396C")
    
    //static let NR_Raw_disabledButtonStart = Color(hex: "#C7CDD6") // темнее, графит с синевой
    static let NG_RawColor_CloudedSteel = Color(hex: "#C7CDD6") // темнее, графит с синевой
    
    //static let NR_Raw_disabledButtonEnd = Color(hex: "#AAB2C0")
    static let NG_RawColor_MutedSteelBlue = Color(hex: "#AAB2C0")
    
    //static let NR_Raw_disabledButtonBridghtBorder = Color(hex: "#E4E7EC")
    static let NG_RawColor_FrostedSilver = Color(hex: "#E4E7EC")
    
    //static let NR_Raw_disabledButtonDarkBorder = Color(hex: "#8D99A8")
    static let NG_RawColor_SmokySteelBlue = Color(hex: "#8D99A8")
    
    static let NG_RawColor_ShadowSteel = Color(hex: "#6E6E6E")
    
    static let NG_RawColor_CharcoalIron = Color(hex: "#3A3A3A")
    
    static let NG_RawColor_GraphiteSmoke = Color(hex: "#444444")
    
    static let NG_RawColor_JetBlackGray = Color(hex: "#1E1E1E")
    
    static let NG_RawColor_CoalGray = Color(hex: "#2B2B2B")
    
    static let NG_RawColor_MidnightBlueGray = Color(hex: "#18222B")
    
    static let NG_RawColor_CoolMidnightBlue = Color(hex: "#1C2A3A")
    
    static let NG_RawColor_DeepNavyBlue = Color(hex: "#14202E")
    
    static let NG_RawColor_FrostedSteelBlue = Color(hex: "#4A5D75")
    
    static let NG_RawColor_MidnightSlate = Color(hex: "#2A3B4D")
    
    static let NG_RawColor_SteelGlowBlue = Color(hex: "#5F7892")
    
    static let NG_RawColor_SteelMistBlue_Dark = Color(hex: "#2C3B4A")
    
    static let NG_RawColor_SlateSkyBlue_Dark = Color(hex: "#1F2E3D")
    
    static let NG_RawColor_MutedMidnightBlueShadow = Color(hex: "#131C24")
    
    static let NG_RawColor_PaleFrostBlue_Dark = Color(hex: "#5A6E84")
    
    static let NG_RawColor_MarineTwilightBlue_Dark = Color(hex: "#1B2937")
    
    static let NG_MuscleFatigue_Color_NotTired_Retrowave_Dark = Color(hex: "#A8D8FF")
    static let NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark = Color(hex: "#A0E6B2")
    static let NG_MuscleFatigue_Color_Tired_Retrowave_Dark = Color(hex: "#FFE066")
    static let NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark = Color(hex: "#FF9933")
    static let NG_MuscleFatigue_Color_Damaged_Retrowave_Dark = Color(hex: "#8B00FF")
    
    static let NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark = Color(hex: "#B0B0B0")
    static let NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark = Color(hex: "#FF9999")
    static let NG_MuscleDevelopment_Color_Developed_Retrowave_Dark = Color(hex: "#66CC66")
        
    // Muscle Fatigue Retrowave Colors (Light)
    static let NG_MuscleFatigue_Color_NotTired_Retrowave_Light = Color(hex: "#DFF1FF")
    static let NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light = Color(hex: "#CFF7DA")
    static let NG_MuscleFatigue_Color_Tired_Retrowave_Light = Color(hex: "#FFF2B2")
    static let NG_MuscleFatigue_Color_VeryTired_Retrowave_Light = Color(hex: "#FFD1A3")
    static let NG_MuscleFatigue_Color_Damaged_Retrowave_Light = Color(hex: "#D6A8FF")

    // Muscle Development Retrowave Colors (Light)
    static let NG_MuscleDevelopment_Color_Unknown_Retrowave_Light = Color(hex: "#DDDDDD")
    static let NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light = Color(hex: "#FFCCCC")
    static let NG_MuscleDevelopment_Color_Developed_Retrowave_Light = Color(hex: "#B2E6B2")
    
    static let NG_Muscle_Color_Default = Color(hex: "#007F00")
    
    static let NG_Muscle_Border = Color(hex: "#D4AF37")
}

extension Font {
    static let NG_Font_Title: Font                                       = Font.system(size: 25, weight: .bold)
    static let NG_Font_Title_Sheet: Font                                 = Font.system(size: 20, weight: .bold)
    static let NG_Font_SectionHeader: Font                               = Font.system(size: 20, weight: .bold)
    static let NG_Font_Text_Big: Font                                    = Font.system(size: 22, weight: .bold)
    static let NG_Font_Text_Regular: Font                                = Font.system(size: 17, weight: .regular)
    static let NG_Font_Text_Small: Font                                  = Font.system(size: 12, weight: .regular)
    static let NG_Font_Button: Font                                      = Font.system(size: 17, weight: .bold)
    static let NG_Font_ListRow_Top_Regular: Font                         = Font.system(size: 17, weight: .bold)
    static let NG_Font_ListRow_Second_Regular: Font                      = Font.system(size: 17, weight: .regular)
    static let NG_Font_Text_Grid_MasterHeader: Font                      = Font.system(size: 17, weight: .bold)
    static let NG_Font_Text_Grid_SubHeader: Font                         = Font.system(size: 17, weight: .regular)
    static let NG_Font_Text_Grid_Rows: Font                              = Font.system(size: 17, weight: .regular)
    static let NG_Font_Text_Metric_Count: Font                           = Font.system(size: 13, weight: .regular)
    static let NG_Font_Text_Metric_Load: Font                            = Font.system(size: 15, weight: .regular)
}

//ICON
extension View {
    func NG_iconStyling(_ style: NG_IconStyle, isDisabled: Binding<Bool>, isHighlighting: Binding<Bool>, isPulsating: Binding<Bool>, theme: ThemeManager) -> some View {
        let effectiveStyle: NG_IconStyle = isDisabled.wrappedValue ? .NG_IconStyle_Disabled : style
        let background: LinearGradient
        let glare: Color
        switch style {
        case .NG_IconStyle_Disabled:
            background = theme.currentTheme.NG_LinearGradient_Icon_Background_Disabled
            glare = theme.currentTheme.NG_Color_Icon_Glare_Disabled
        case .NG_IconStyle_Regular:
            background = theme.currentTheme.NG_LinearGradient_Icon_Background_Regular
            glare = theme.currentTheme.NG_Color_Icon_Glare_Regular
        case .NG_IconStyle_Green:
            background = theme.currentTheme.NG_LinearGradient_Icon_Background_Green
            glare = theme.currentTheme.NG_Color_Icon_Glare_Green
        case .NG_IconStyle_Red:
            background = theme.currentTheme.NG_LinearGradient_Icon_Background_Red
            glare = theme.currentTheme.NG_Color_Icon_Glare_Red
        case .NG_IconStyle_Transparent:
            background = LinearGradient(colors: [.clear, .clear], startPoint: .top, endPoint: .bottom)
            glare = Color.clear
        }
        
        return self.foregroundStyle(background)
            .if(isHighlighting.wrappedValue){ view in
                view.shadow(color: glare, radius: 3, x: 0, y: 0)
            }
            .if(isPulsating.wrappedValue){ view in
                view.NG_Pulsating(pulsation: isPulsating)
            }
    }
}

//TEXT STYLING
extension View {
    func NG_textStyling(_ style: NG_TextStyle, _ tint: NG_TextColor? = nil, noShadow: Bool = false, glare: Bool = false, pulsation: Bool = false, theme: ThemeManager) -> some View {
        var tintedValue: Color = theme.currentTheme.NG_Color_Text_Regular_Text
        var tintedGlare: Color? = nil
        if(tint != nil){
            switch tint! {
            case NG_TextColor.NG_TextColor_Red:
                tintedValue = theme.currentTheme.NG_Color_Text_Red_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_Red_Glare
            case NG_TextColor.NG_TextColor_Green:
                tintedValue = theme.currentTheme.NG_Color_Text_Green_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_Green_Glare
            case NG_TextColor.NG_TextColor_Regular:
                tintedValue = theme.currentTheme.NG_Color_Text_Regular_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
            case NG_TextColor.NG_TextColor_Disabled:
                tintedValue = theme.currentTheme.NG_Color_Text_Disabled_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_Disabled_Glare
            case NG_TextColor.NG_TextColor_Muscle_Fatigue_NotTired:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleFatigue_NotTired_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleFatigue_NotTired_Glare
            case NG_TextColor.NG_TextColor_Muscle_Fatigue_SlightlyTired:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleFatigue_SlightlyTired_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleFatigue_SlightlyTired_Glare
            case NG_TextColor.NG_TextColor_Muscle_Fatigue_Tired:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleFatigue_Tired_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleFatigue_Tired_Glare
            case NG_TextColor.NG_TextColor_Muscle_Fatigue_VeryTired:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleFatigue_VeryTired_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleFatigue_VeryTired_Glare
            case NG_TextColor.NG_TextColor_Muscle_Fatigue_Damaged:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleFatigue_Damaged_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleFatigue_Damaged_Glare
            case NG_TextColor.NG_TextColor_Muscle_Development_Undefined:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Undefined_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Undefined_Glare
            case NG_TextColor.NG_TextColor_Muscle_Development_Underdeveloped:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Underdeveloped_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare
            case NG_TextColor.NG_TextColor_Muscle_Development_Developed:
                tintedValue = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Developed_Text
                tintedGlare = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Developed_Glare
            }
        }
        var effectiveGlare: Color? = nil
        if(glare){
            if(tintedGlare != nil){
                effectiveGlare = tintedGlare
            }else{
                switch style {
                case .NG_TextStyle_Title:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_AppWizard:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_AppWizard_Glare
                case .NG_TextStyle_Color_Grid_Row:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Text_Big:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Text_Small:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Metric_Load:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Title_Sheet:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Metric_Count:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Text_Regular:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Color_ListRow_Top:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Color_Grid_SubHeader:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Color_ListRow_Second:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_Color_Grid_MasterHeader:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                case .NG_TextStyle_SectionHeader:
                    effectiveGlare = theme.currentTheme.NG_Color_Text_Regular_Glare
                }
            }
        }
        let theFont: Font
        switch style {
        case .NG_TextStyle_Title:
            theFont = .NG_Font_Title
        case .NG_TextStyle_Title_Sheet:
            theFont = .NG_Font_Title_Sheet
            
        case .NG_TextStyle_SectionHeader:
            theFont = .NG_Font_SectionHeader
            
        case .NG_TextStyle_AppWizard:
            theFont = .NG_Font_Text_Regular
            
        case .NG_TextStyle_Text_Big:
            theFont = .NG_Font_Text_Big
        case .NG_TextStyle_Text_Regular:
            theFont = .NG_Font_Text_Regular
        case .NG_TextStyle_Text_Small:
            theFont = .NG_Font_Text_Small
            
        case .NG_TextStyle_Metric_Load:
            theFont = .NG_Font_Text_Metric_Load
        case .NG_TextStyle_Metric_Count:
            theFont = .NG_Font_Text_Metric_Count
        
        case .NG_TextStyle_Color_ListRow_Top:
            theFont = .NG_Font_ListRow_Top_Regular
        case .NG_TextStyle_Color_ListRow_Second:
            theFont = .NG_Font_ListRow_Second_Regular
            
        case .NG_TextStyle_Color_Grid_MasterHeader:
            theFont = .NG_Font_Text_Grid_MasterHeader
        case .NG_TextStyle_Color_Grid_SubHeader:
            theFont = .NG_Font_Text_Grid_SubHeader
        case .NG_TextStyle_Color_Grid_Row:
            theFont = .NG_Font_Text_Grid_Rows
        }
        let theTint: Color
        if(tint != nil){
            switch tint! {
            case .NG_TextColor_Red:
                theTint = theme.currentTheme.NG_Color_Text_Red_Text
            case .NG_TextColor_Green:
                theTint = theme.currentTheme.NG_Color_Text_Green_Text
            case .NG_TextColor_Regular:
                theTint = theme.currentTheme.NG_Color_Text_Regular_Text
            case .NG_TextColor_Disabled:
                theTint = theme.currentTheme.NG_Color_Text_Disabled_Text
            case .NG_TextColor_Muscle_Fatigue_NotTired:
                theTint = theme.currentTheme.NG_Color_Text_MuscleFatigue_NotTired_Text
            case .NG_TextColor_Muscle_Fatigue_SlightlyTired:
                theTint = theme.currentTheme.NG_Color_Text_MuscleFatigue_SlightlyTired_Text
            case .NG_TextColor_Muscle_Fatigue_Tired:
                theTint = theme.currentTheme.NG_Color_Text_MuscleFatigue_Tired_Text
            case .NG_TextColor_Muscle_Fatigue_VeryTired:
                theTint = theme.currentTheme.NG_Color_Text_MuscleFatigue_VeryTired_Text
            case .NG_TextColor_Muscle_Fatigue_Damaged:
                theTint = theme.currentTheme.NG_Color_Text_MuscleFatigue_Damaged_Text
            case NG_TextColor.NG_TextColor_Muscle_Development_Undefined:
                theTint = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Undefined_Text
            case NG_TextColor.NG_TextColor_Muscle_Development_Underdeveloped:
                theTint = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Underdeveloped_Text
            case NG_TextColor.NG_TextColor_Muscle_Development_Developed:
                theTint = theme.currentTheme.NG_Color_Text_MuscleDevelopment_Developed_Text
            }
        }else{
            theTint = .clear
        }
        let theColor: Color
        switch style {
        case .NG_TextStyle_Title:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_AppWizard:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_AppWizard_Text
        case .NG_TextStyle_Color_Grid_Row:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Grid_Rows_Text
        case .NG_TextStyle_Text_Big:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_Text_Small:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_Metric_Load:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_Title_Sheet:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_Metric_Count:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_Text_Regular:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        case .NG_TextStyle_Color_ListRow_Top:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_ListRow_Text_Top
        case .NG_TextStyle_Color_Grid_SubHeader:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Grid_SubHeader_Text
        case .NG_TextStyle_Color_ListRow_Second:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_ListRow_Text_Second
        case .NG_TextStyle_Color_Grid_MasterHeader:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Grid_MasterHeader_Text
        case .NG_TextStyle_SectionHeader:
            theColor = tint != nil ? theTint : theme.currentTheme.NG_Color_Text_Regular_Text
        }
        var theShadow: Color? = nil
        switch style {
        case .NG_TextStyle_Title:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        case .NG_TextStyle_AppWizard:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_AppWizard_Shadow
        case .NG_TextStyle_Color_Grid_Row:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        case .NG_TextStyle_Text_Big:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        case .NG_TextStyle_Text_Small:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        case .NG_TextStyle_Metric_Load:
            theShadow = nil
        case .NG_TextStyle_Title_Sheet:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        case .NG_TextStyle_Metric_Count:
            theShadow = nil
        case .NG_TextStyle_Text_Regular:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        case .NG_TextStyle_Color_ListRow_Top:
            theShadow = nil
        case .NG_TextStyle_Color_Grid_SubHeader:
            theShadow = nil
        case .NG_TextStyle_Color_ListRow_Second:
            theShadow = nil
        case .NG_TextStyle_Color_Grid_MasterHeader:
            theShadow = nil
        case .NG_TextStyle_SectionHeader:
            theShadow = noShadow ? nil : theme.currentTheme.NG_Color_Text_Regular_Shadow
        }
        var theGlare: Color? = nil
        switch style {
        case .NG_TextStyle_Title:
            theGlare = glare ? theme.currentTheme.NG_Color_Text_Regular_Glare : nil
        case .NG_TextStyle_AppWizard:
            theGlare = glare ? theme.currentTheme.NG_Color_Text_AppWizard_Glare : nil
        case .NG_TextStyle_Color_Grid_Row:
            theGlare = nil
        case .NG_TextStyle_Text_Big:
            theGlare = glare ? theme.currentTheme.NG_Color_Text_Regular_Glare : nil
        case .NG_TextStyle_Text_Small:
            theGlare = glare ? theme.currentTheme.NG_Color_Text_Regular_Glare : nil
        case .NG_TextStyle_Metric_Load:
            theGlare = nil
        case .NG_TextStyle_Title_Sheet:
            theGlare = glare ? theme.currentTheme.NG_Color_Text_Regular_Glare : nil
        case .NG_TextStyle_Metric_Count:
            theGlare = nil
        case .NG_TextStyle_Text_Regular:
            theGlare = glare ? theme.currentTheme.NG_Color_Text_Regular_Glare : nil
        case .NG_TextStyle_Color_ListRow_Top:
            theGlare = nil
        case .NG_TextStyle_Color_Grid_SubHeader:
            theGlare = nil
        case .NG_TextStyle_Color_ListRow_Second:
            theGlare = nil
        case .NG_TextStyle_Color_Grid_MasterHeader:
            theGlare = nil
        case .NG_TextStyle_SectionHeader:
            theGlare = nil
        }
        
        return self.modifier(NG_TextStyle_Modifier(font: theFont, color: theColor, shadow: theShadow, glare: theGlare))
            .if(pulsation){ view in
                view.modifier(NG_Pulsation_Modifier(pulsating: .constant(true), baseScale: .constant(1.00), bigScale: .constant(1.05)))
            }
    }
}

struct NG_TextStyle_Modifier: ViewModifier {
    var font: Font
    var color: Color
    var shadow: Color? = nil
    var glare: Color? = nil
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .if(shadow != nil){ view in
                view.shadow(color: shadow!, radius: 8, x: 3, y: 4)
            }
            .if(glare != nil){ view in
                view.shadow(color: glare!, radius: 3, x: 0, y: 0)
            }
    }
}

//NAVIGATION TITLE

extension View {
    func NG_NavigationTitle(_ name: String, theme: ThemeManager) -> some View {
        self.toolbar {
            ToolbarItem(placement: .principal) {
                Text(name)
                    .NG_textStyling(.NG_TextStyle_Title, theme: theme)
            }
        }
    }
}

//CARDS

extension View {
    func NG_Card(_ style: NG_CardStyle, noShadow: Bool = false, highlighted: Binding<Bool> = .constant(false), theme: ThemeManager) -> some View {
        let background: LinearGradient
        let shadow: Color
        let borderDark: Color
        let borderBright: Color
        let borderBright2: Color?
        let borderHighlighter: Color?
        let cornerRadius: CGFloat
        let contentPadding: CGFloat
        switch style {
        case .NG_CardStyle_Red:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Red
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Red
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Red
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Red
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Green:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Green
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Green
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Green
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Green
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Regular:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Regular
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Regular
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Regular
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Regular
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_AppWizard:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_AppWizard
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_AppWizard
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_AppWizard
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_AppWizard
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Training_Today:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Today
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Today
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Today
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Today
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Training_Future:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Future
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Future
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Future
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Future
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Training_Passed:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Passed
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Passed
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Passed
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Passed
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Training_Completed:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Completed
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Completed
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Completed
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Completed
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Training_InProgress:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_InProgress
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_InProgress
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_InProgress
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_InProgress
            borderBright2 = theme.currentTheme.NG_Color_Card_Border_Bright_InProgress_2
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 20
            contentPadding = 10
        case .NG_CardStyle_Metric_NotStarted:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_NotStarted
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_NotStarted
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_NotStarted
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_NotStarted
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 10
            contentPadding = 5
        case .NG_CardStyle_Metric_Skipped:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Skipped
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Skipped
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Skipped
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Skipped
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 10
            contentPadding = 5
        case .NG_CardStyle_Metric_Easy:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Easy
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Easy
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Easy
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Easy
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 10
            contentPadding = 5
        case .NG_CardStyle_Metric_Normal:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Normal
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Normal
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Normal
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Normal
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 10
            contentPadding = 5
        case .NG_CardStyle_Metric_Hard:
            background = theme.currentTheme.NG_LinearGradient_Background_Card_Hard
            shadow = noShadow ? .clear : theme.currentTheme.NG_Color_Card_Shadow_Hard
            borderDark = theme.currentTheme.NG_Color_Card_Border_Dark_Hard
            borderBright = theme.currentTheme.NG_Color_Card_Border_Bright_Hard
            borderBright2 = nil
            borderHighlighter = highlighted.wrappedValue ? theme.currentTheme.NG_Color_Card_Border_Bright_Highlighted : nil
            cornerRadius = 10
            contentPadding = 5
        }
        return self
            .modifier(NG_CardStyle_Modifier(backgroundGradient: background, shadowColor: shadow, borderDark: borderDark, borderBright: borderBright, borderBright2: borderBright2, borderHighlighter: borderHighlighter, cornerRadius: cornerRadius, contentPadding: contentPadding))
    }
}

struct NG_CardStyle_Modifier: ViewModifier {
    let backgroundGradient: LinearGradient
    let shadowColor: Color
    let borderDark: Color
    let borderBright: Color
    var borderBright2: Color? = nil
    var borderHighlighter: Color? = nil
    var cornerRadius: CGFloat = 20
    var contentPadding: CGFloat = 10
    @State private var isHighlighted = false
    func body(content: Content) -> some View {
        content
            .padding(contentPadding)
            .background(backgroundGradient)
            .cornerRadius(cornerRadius)
            .if(shadowColor != .clear){ view in
                view.shadow(color: shadowColor, radius: 8, x: 3, y: 4)
            }
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderDark, lineWidth: 1)
            )
            .overlay(
                Group {
                    if let borderBright2 = borderBright2 {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .inset(by: 2)
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [
                                        borderBright, borderBright2, borderBright, borderBright2,
                                        borderBright, borderBright2, borderBright
                                    ]),
                                    center: .center
                                ),
                                lineWidth: 2
                            )
                            .blur(radius: 2)
                    } else {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .inset(by: 2)
                            .stroke(borderBright, lineWidth: 1)
                            .blur(radius: 2)
                    }
                }
            )
            .overlay(
                Group {
                    if let borderBright2 = borderBright2 {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .inset(by: 2)
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [
                                        borderBright, borderBright2, borderBright, borderBright2,
                                        borderBright, borderBright2, borderBright
                                    ]),
                                    center: .center
                                ),
                                lineWidth: 2
                            )
                    } else {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .inset(by: 2)
                            .stroke(borderBright, lineWidth: 1)
                    }
                }
            )
            .if(borderHighlighter != nil){ view in
                view.overlay(
                    Group {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .inset(by: 2)
                            .stroke(isHighlighted ? borderHighlighter! : .clear, lineWidth: isHighlighted ? 3 : 0)
                            .shadow(color: isHighlighted ? borderHighlighter! : .clear, radius: isHighlighted ? 5 : 0, x: 0, y: 0)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                    isHighlighted.toggle()
                                }
                            }
                    }
                )
            }
    }
}

// BUTTONS

struct NG_Button: View {
    let title: String
    let style: NG_ButtonStyle
    @Binding var isDisabled: Bool
    @Binding var isHighlighting: Bool
    @Binding var isPulsating: Bool
    var massivePulse: Bool = false
    var action: (() -> Void)? = nil
    var widthFlood: Bool = false
    var textScroll: Bool = false
    var narrowHorizontalPadding: Bool = false
    var narrowVerticalPadding: Bool = false
    @EnvironmentObject var theme: ThemeManager
    
    private var backgroundGradient: LinearGradient {
        if isDisabled { return theme.currentTheme.NG_LinearGradient_Background_Button_Disabled }
        switch style {
        case .NG_ButtonStyle_Regular:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Regular
        case .NG_ButtonStyle_Service:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Service
        case .NG_ButtonStyle_Red:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Red
        case .NG_ButtonStyle_Green:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Green
        case .NG_ButtonStyle_DatePicker:
            return theme.currentTheme.NG_LinearGradient_Background_Button_DatePicker
        case .NG_ButtonStyle_Skipped:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Skipped
        case .NG_ButtonStyle_Easy:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Easy
        case .NG_ButtonStyle_Normal:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Normal
        case .NG_ButtonStyle_Hard:
            return theme.currentTheme.NG_LinearGradient_Background_Button_Hard
        }
    }
    
    private var borderBright: Color {
        if (isHighlighting || isPulsating) { return theme.currentTheme.NG_Color_Button_Border_Bright_Highlighted }
        switch style {
        case .NG_ButtonStyle_Regular:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Regular
        case .NG_ButtonStyle_Service:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Service
        case .NG_ButtonStyle_Red:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Red
        case .NG_ButtonStyle_Green:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Green
        case .NG_ButtonStyle_DatePicker:
            return theme.currentTheme.NG_Color_Button_Border_Bright_DatePicker
        case .NG_ButtonStyle_Skipped:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Skipped
        case .NG_ButtonStyle_Easy:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Easy
        case .NG_ButtonStyle_Normal:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Normal
        case .NG_ButtonStyle_Hard:
            return theme.currentTheme.NG_Color_Button_Border_Bright_Hard
        }
    }
    
    private var borderDark: Color {
        switch style {
        case .NG_ButtonStyle_Regular:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Regular
        case .NG_ButtonStyle_Service:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Service
        case .NG_ButtonStyle_Red:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Red
        case .NG_ButtonStyle_Green:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Green
        case .NG_ButtonStyle_DatePicker:
            return theme.currentTheme.NG_Color_Button_Border_Dark_DatePicker
        case .NG_ButtonStyle_Skipped:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Skipped
        case .NG_ButtonStyle_Easy:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Easy
        case .NG_ButtonStyle_Normal:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Normal
        case .NG_ButtonStyle_Hard:
            return theme.currentTheme.NG_Color_Button_Border_Dark_Hard
        }
    }
    
    private var shadowColor: Color? {
        if (isHighlighting || isPulsating) { return nil }
        if isDisabled { return nil }
        switch style {
        case .NG_ButtonStyle_Regular:
            return nil
        case .NG_ButtonStyle_Service:
            return nil
        case .NG_ButtonStyle_Red:
            return nil
        case .NG_ButtonStyle_Green:
            return nil
        case .NG_ButtonStyle_DatePicker:
            return nil
        case .NG_ButtonStyle_Skipped:
            return nil
        case .NG_ButtonStyle_Easy:
            return nil
        case .NG_ButtonStyle_Normal:
            return nil
        case .NG_ButtonStyle_Hard:
            return nil
        }
    }
    
    private var glareColor: Color? {
        if (isHighlighting || isPulsating) { return theme.currentTheme.NG_Color_Button_Glare_Highlighted }
        if isDisabled { return nil }
        switch style {
        case .NG_ButtonStyle_Regular:
            return nil
        case .NG_ButtonStyle_Service:
            return nil
        case .NG_ButtonStyle_Red:
            return nil
        case .NG_ButtonStyle_Green:
            return nil
        case .NG_ButtonStyle_DatePicker:
            return nil
        case .NG_ButtonStyle_Skipped:
            return theme.currentTheme.NG_Color_Button_Glare_Skipped
        case .NG_ButtonStyle_Easy:
            return theme.currentTheme.NG_Color_Button_Glare_Easy
        case .NG_ButtonStyle_Normal:
            return theme.currentTheme.NG_Color_Button_Glare_Normal
        case .NG_ButtonStyle_Hard:
            return theme.currentTheme.NG_Color_Button_Glare_Hard
        }
    }
    
    private var textColor: Color {
        if (isHighlighting || isPulsating) { return theme.currentTheme.NG_Color_Button_Text_Highlighted }
        if isDisabled { return theme.currentTheme.NG_Color_Button_Text_Disabled }
        switch style{
        case .NG_ButtonStyle_Regular:
            return theme.currentTheme.NG_Color_Button_Text_Regular
        case .NG_ButtonStyle_Service:
            return theme.currentTheme.NG_Color_Button_Text_Service
        case .NG_ButtonStyle_Red:
            return theme.currentTheme.NG_Color_Button_Text_Red
        case .NG_ButtonStyle_Green:
            return theme.currentTheme.NG_Color_Button_Text_Green
        case .NG_ButtonStyle_DatePicker:
            return theme.currentTheme.NG_Color_Button_Text_DatePicker
        case .NG_ButtonStyle_Skipped:
            return theme.currentTheme.NG_Color_Button_Text_Skipped
        case .NG_ButtonStyle_Easy:
            return theme.currentTheme.NG_Color_Button_Text_Easy
        case .NG_ButtonStyle_Normal:
            return theme.currentTheme.NG_Color_Button_Text_Normal
        case .NG_ButtonStyle_Hard:
            return theme.currentTheme.NG_Color_Button_Text_Hard
        }
    }
    
    var body: some View {
        if let action = action {
            Button(action: action) {
                if(textScroll){
                    ScrollView(.horizontal){
                        HStack {
                            Spacer(minLength: 0)
                            Text(title)
                            Spacer(minLength: 0)
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                }else{
                    Text(title)
                }
            }
            .buttonStyle(
                NG_Color_ButtonStyle_ButtonStyle(
                    backgroundGradient: backgroundGradient,
                    borderBright: borderBright,
                    borderDark: borderDark,
                    textColor: textColor,
                    widthFlood: widthFlood,
                    horizontalPadding: narrowHorizontalPadding ? 5 : 20,
                    verticalPadding: narrowVerticalPadding ? 2 : 12
                )
            )
            .if(glareColor != nil){ view in
                view
                    .shadow(color: glareColor!, radius: 3, x: 0, y: 0)
            }
            .if(shadowColor != nil){ view in
                view
                    .shadow(color: shadowColor!, radius: 8, x: 3, y: 4)
            }
            //.NG_Pulsating(pulsation: $isPulsating)
            .if(isPulsating){ view in
                view.modifier(NG_Pulsation_Modifier(pulsating: .constant(true), baseScale: .constant(1.00), bigScale: .constant( massivePulse ? 1.2 : 1.05)))
            }
        }else {
            Button(action: {}) {
                Text(title)
            }
                .buttonStyle(
                    NG_Color_ButtonStyle_ButtonStyle(
                        backgroundGradient: backgroundGradient,
                        borderBright: borderBright,
                        borderDark: borderDark,
                        textColor: textColor,
                        widthFlood: widthFlood,
                        horizontalPadding: narrowHorizontalPadding ? 5 : 20,
                        verticalPadding: narrowVerticalPadding ? 2 : 12
                    )
                )
                .disabled(true)
                .if(glareColor != nil){ view in
                    view
                        .shadow(color: glareColor!, radius: 3, x: 0, y: 0)
                }
                .if(shadowColor != nil){ view in
                    view
                        .shadow(color: shadowColor!, radius: 8, x: 3, y: 4)
                }
            //.NG_Pulsating(pulsation: $isPulsating)
            .if(isPulsating){ view in
                view.modifier(NG_Pulsation_Modifier(pulsating: .constant(true), baseScale: .constant(1.00), bigScale: .constant( massivePulse ? 1.2 : 1.05)))
            }
        }
    }
}

struct NG_Color_ButtonStyle_ButtonStyle: ButtonStyle {
    let backgroundGradient: LinearGradient
    let borderBright: Color
    let borderDark: Color
    let textColor: Color
    let widthFlood: Bool
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.NG_Font_Button)
            .foregroundColor(textColor)
            .padding(.vertical, verticalPadding)//12)
            .padding(.horizontal, horizontalPadding)//20)
            .if(widthFlood){ view in
                view.frame(maxWidth: .infinity, alignment: .center)
            }
            .background(backgroundGradient)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderDark, lineWidth: 1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 2)
                    .stroke(borderBright, lineWidth: 1)
                    .blur(radius: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 2)
                    .stroke(borderBright, lineWidth: 1)
            )
    }
}

// PULSATION

extension View{
    func NG_Pulsating(pulsation: Binding<Bool>, scale: Binding<CGFloat> = .constant(1.2)) -> some View {
        self
            .if(pulsation.wrappedValue){ view in
                view.modifier(NG_Pulsation_Modifier(
                    pulsating: pulsation, baseScale: .constant(1.0), bigScale: scale
                ))
            }
    }
}

struct NG_Pulsation_Modifier: ViewModifier {
    @Binding var pulsating: Bool
    @Binding var baseScale: CGFloat
    @Binding var bigScale: CGFloat
    
    @State private var isPulse = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(pulsating ? (isPulse ? bigScale : baseScale) : baseScale)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isPulse = true
                }
            }
    }
}

//SHEET

extension View {
    func NG_sheetFormatting(transparent: Bool = false) -> some View {
        self.modifier(NG_Sheet_Modifier(transparent: transparent))
    }
}

struct NG_Sheet_Modifier: ViewModifier {
    @EnvironmentObject var theme: ThemeManager
    var transparent: Bool
    func body(content: Content) -> some View {
        content
            .NG_Card(.NG_CardStyle_Regular, theme: theme)
            .padding(.top)
            .padding(.horizontal)
            //.presentationBackground(Color.clear)
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(true)
            .ignoresSafeArea(.keyboard)
    }
}

//TEXT FIELD

extension View {
    func NG_textFieldStyling(_ style: NG_TextField, theme: ThemeManager) -> some View {
        return self
            .modifier(NG_textField_Modifier(
                backgroundColor: theme.currentTheme.NG_Color_TextField_Background,
                textColor: theme.currentTheme.NG_Color_TextField_Text,
                borderColor: theme.currentTheme.NG_Color_TextField_Border,
                innerShadow: theme.currentTheme.NG_Color_TextField_InnerShadow,
                outerGlare: style == .NG_TextField_Attention ? theme.currentTheme.NG_Color_TextField_OuterGlare : nil
            ))
            .NG_Pulsating(pulsation: .constant(style == .NG_TextField_Attention), scale: .constant(1.05))
    }
}

struct NG_textField_Modifier: ViewModifier {
    var backgroundColor: Color
    var textColor: Color
    var borderColor: Color
    var innerShadow: Color
    var outerGlare: Color?
    var cornerRadius: CGFloat = 6
    var padding: CGFloat = 5

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                ZStack {
                    backgroundColor
                    RoundedRectangle(cornerRadius: cornerRadius-5)
                        .inset(by: -6)
                        .offset(x: 5, y: 5)
                        .stroke(.red, lineWidth: 3)
                        .shadow(color: innerShadow, radius: 3, x: 0, y: 0)
                        
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            )
            .foregroundColor(textColor)
            .cornerRadius(cornerRadius)
            .if(outerGlare != nil){ view in
                view.shadow(color: outerGlare!, radius: 8, x: 0, y: 0)
            }
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}
