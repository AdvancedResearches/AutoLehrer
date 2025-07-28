//
//  ColorSchemas.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 11.02.24.
//

import Foundation
import SwiftUI

/*
extension Color {
    static let palette_bright_base_1        = Color(red: 0.576, green: 1.000, blue: 1.000, opacity: 1.0) // Исходный (Cyan-Light)
    static let palette_bright_base_2        = Color(red: 1.000, green: 0.576, blue: 1.000, opacity: 1.0) // Триадный (Magenta-Light)
    static let palette_bright_base_3        = Color(red: 1.000, green: 0.400, blue: 0.000, opacity: 1.0) // Супер-яркий оранжевый
    static let palette_bright_red           = Color(red: 1.000, green: 0.250, blue: 0.250, opacity: 1.0)
    static let palette_bright_orange        = Color(red: 1.000, green: 0.500, blue: 0.000, opacity: 1.0)
    static let palette_bright_green         = Color(red: 0.000, green: 1.000, blue: 0.000, opacity: 1.0)
    static let palette_bright_gray          = Color(red: 0.750, green: 0.750, blue: 0.750, opacity: 1.0)
    static let palette_bright_white         = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.0)
    
    static let palette_dark_base_1          = mixer(color1: palette_bright_base_1, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.6)
    static let palette_dark_base_2          = mixer(color1: palette_bright_base_2, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.6)
    static let palette_dark_base_3          = mixer(color1: palette_bright_base_3, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.6)
    static let palette_dark_red             = mixer(color1: palette_bright_red, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.3)
    static let palette_dark_orange          = mixer(color1: palette_bright_orange, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.3)
    static let palette_dark_green           = mixer(color1: palette_bright_green, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.3)
    static let palette_dark_gray            = mixer(color1: palette_bright_gray, color2: Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0), blendRatio: 0.3)
    static let palette_dark_black           = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.0)
    
    //Background
    static let background = Color(hex: "#D3D5DA")           // Светлый общий фон (чуть темнее)
    
    //Cards
    static let cardBackground = Color(hex: "#F5F5F6")                // Белый фон карточек
    static let cardShadow = Color.black.opacity(0.25)       // Тень карточки
    static let cardText = Color(hex: "#4A262C")
    static let cardBorderBright = Color(hex: "#FDFEFD")
    static let cardBorderDark = Color(hex: "#F1EFF0")
    
    static let appWizardBackground = Color(hex: "#F3E3E0")                // Белый фон карточек
    static let appWizardShadow = Color.black.opacity(0.25)       // Тень карточки
    static let appWizardText = Color(hex: "#4A262C")
    static let appWizardBorderBright = Color(hex: "#FCFBF7")
    static let appWizardBorderDark = Color(hex: "#DBACA2")
    
    //Buttons
    static let buttonText = Color.white                     // Белый текст на кнопках
    
    static let regularButtonStart = Color(hex: "#6692C3")  // Синий-фиолетовый (слева)
    static let regularButtonEnd = Color(hex: "#405C96")    // Голубой (справа)
    static let regularButtonBridghtBorder = Color(hex: "#CCD9E3")
    static let regularButtonDarkBorder = Color(hex: "#173A6B")
    
    static let serviceButtonStart = Color(hex: "#93A3BA") // темнее, графит с синевой
    static let serviceButtonEnd = Color(hex: "#607493")
    static let serviceButtonBridghtBorder = Color(hex: "#C9D4DF")
    static let serviceButtonDarkBorder = Color(hex: "#16396C")
    
    static let disabledButtonStart = Color(hex: "#C7CDD6") // темнее, графит с синевой
    static let disabledButtonEnd = Color(hex: "#AAB2C0")
    static let disabledButtonBridghtBorder = Color(hex: "#E4E7EC")
    static let disabledButtonDarkBorder = Color(hex: "#8D99A8")
    
    static let redButtonStart = Color(hex: "#C45B5B") // Красный (слева)
    static let redButtonEnd = Color(hex: "#912E2E")   // Красный (справа)
    static let redButtonBridghtBorder = Color(hex: "#E6A8A8")
    static let redButtonDarkBorder = Color(hex: "#6B1F1F")
    
    static let greenButtonStart = Color(hex: "#4AB672") // Зелёный (слева)
    static let greenButtonEnd = Color(hex: "#2D7B4A")   // Зелёный (справа)
    static let greenButtonBridghtBorder = Color(hex: "#B0D9C0")
    static let greenButtonDarkBorder = Color(hex: "#1F5633")
    
    //Texts
    static let titleText = Color(hex: "#3A4356")            // Тёмный текст
    static let textRed = Color(hex: "#D66B6B") // Мягкий красный для карточек
    
    static let highlightBorderBright = Color(hex: "#FF0000")
    static let highlightBorderDark = Color(hex: "#AA0000")

    static let highlightButtonBridghtBorder = Color(hex: "#C9D4DF")
    static let highlightButtonDarkBorder = Color(hex: "#16396C")
    
    private static func mixer(color1: Color, color2: Color, blendRatio: Float) -> Color {
        let blend = CGFloat(blendRatio)
        
        // Получаем компоненты первого цвета
        let components1 = color1.cgColor?.components ?? [0, 0, 0, 1]
        let r1 = components1[0], g1 = components1[1], b1 = components1[2], a1 = components1.count > 3 ? components1[3] : 1.0
        
        // Получаем компоненты второго цвета
        let components2 = color2.cgColor?.components ?? [0, 0, 0, 1]
        let r2 = components2[0], g2 = components2[1], b2 = components2[2], a2 = components2.count > 3 ? components2[3] : 1.0
        
        // Смешиваем цвета в нужной пропорции
        let r = r1 * (1 - blend) + r2 * blend
        let g = g1 * (1 - blend) + g2 * blend
        let b = b1 * (1 - blend) + b2 * blend
        let a = a1 * (1 - blend) + a2 * blend
        
        //print("mixing \(components1) and \(components2) result in \(r), \(g), \(b), \(a)")
        
        return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
}
*/

/*
struct MasterColorSchema{
    /*
    public static let mainBackground = LinearGradient(stops: [
        Gradient.Stop(color: Color.palette_dark_base_1,
                      location: 0.000),
        Gradient.Stop(color: Color.palette_dark_base_2,
                      location: 0.100),
        Gradient.Stop(color: Color.palette_dark_base_3,
                      location: 1.000),
    ], startPoint: .top, endPoint: .bottom)
     */
    public static let mainBackground = Color.background
    
    public static let mainTitle             = Color.palette_bright_base_1
    public static let mainSubTitle          = Color.palette_bright_base_2
    public static let popupTitle             = Color.palette_dark_base_1
    
    static let title = Font.system(size: 22, weight: .bold)
    static let sectionTitle = Font.system(size: 18, weight: .semibold)
    static let button = Font.system(size: 17, weight: .semibold)
    static let label = Font.system(size: 15, weight: .regular)
    
    public static let color_bright_1        = Color.palette_bright_base_1
    public static let color_bright_2        = Color.palette_bright_base_2
    public static let color_bright_red      = Color.palette_bright_red
    public static let color_bright_orange   = Color.palette_bright_orange
    public static let color_bright_green    = Color.palette_bright_green
    public static let color_bright_gray     = Color.palette_bright_gray
    public static let color_bright_most     = Color.palette_bright_white
    
    public static let color_dark_1          = Color.palette_dark_base_1
    public static let color_dark_2          = Color.palette_dark_base_2
    public static let color_dark_red        = Color.palette_dark_red
    public static let color_dark_orange     = Color.palette_dark_orange
    public static let color_dark_green      = Color.palette_dark_green
    public static let color_dark_gray       = Color.palette_dark_gray
    public static let color_dark_most       = Color.palette_dark_black
    
    public static let training_completed    = Color.palette_dark_green.opacity(0.3)
    public static let training_inprogress   = Color.palette_dark_orange.opacity(0.3)
    public static let training_future       = Color.palette_dark_gray.opacity(0.3)
    public static let training_passed       = Color.palette_dark_red.opacity(0.3)
    
    public static let metric_notdone_back   = Color.palette_bright_gray.opacity(0.7)
    public static let metric_easy_back      = Color.palette_bright_base_1.opacity(0.7)
    public static let metric_normal_back    = Color.palette_bright_green.opacity(0.7)
    public static let metric_hard_back      = Color.palette_bright_red.opacity(0.7)
    
    public static let metric_border         = color_dark_orange
    
    //.listRowBackground(MasterColorSchema.color_bright_most.opacity(0.7))
    public static let list_row_background   = MasterColorSchema.color_bright_most.opacity(0.7)
}
*/

/*
struct TaskStatusButtons {
    public static let redBackgroundOff  = MasterColorSchema.color_dark_gray
    public static let redForegroundOff  = MasterColorSchema.color_bright_red
    public static let redBackgroundOn  = MasterColorSchema.color_dark_red
    public static let redForegroundOn  = MasterColorSchema.color_bright_1
    
    public static let orangeBackgroundOff  = MasterColorSchema.color_dark_gray
    public static let orangeForegroundOff  = MasterColorSchema.color_bright_orange
    public static let orangeBackgroundOn  = MasterColorSchema.color_dark_orange
    public static let orangeForegroundOn  = MasterColorSchema.color_bright_1
    
    public static let greenBackgroundOff  = MasterColorSchema.color_dark_gray
    public static let greenForegroundOff  = MasterColorSchema.color_bright_green
    public static let greenBackgroundOn  = MasterColorSchema.color_dark_green
    public static let greenForegroundOn  = MasterColorSchema.color_bright_1
    
    public static let base1BackgroundOff  = MasterColorSchema.color_dark_1
    public static let base1ForegroundOff  = MasterColorSchema.color_bright_gray
    public static let base1BackgroundOn  = MasterColorSchema.color_dark_1
    public static let base1ForegroundOn  = MasterColorSchema.color_bright_1
    
    public static let base2BackgroundOff  = MasterColorSchema.color_dark_2
    public static let base2ForegroundOff  = MasterColorSchema.color_bright_gray
    public static let base2BackgroundOn  = MasterColorSchema.color_dark_2
    public static let base2ForegroundOn  = MasterColorSchema.color_bright_2
}
*/

/*
struct MasterColorSchemas_obsolete {
    public static let masterBackground = LinearGradient(stops: [
        Gradient.Stop(color: Color(red: 0.702, green: 0.702, blue: 0.702, opacity: 1.000),
                      location: 0.000),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 0.100),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 1.000),
    ], startPoint: .top, endPoint: .bottom)
    public static let masterForeground = Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 1.00)
    
    public static let timeBackground = LinearGradient(stops: [
        Gradient.Stop(color: Color(red: 0.000, green: 0.502, blue: 1.000, opacity: 1.000),
                      location: 0.000),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 0.100),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 1.000),
    ], startPoint: .top, endPoint: .bottom)
    public static let timeForeground = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    public static let timeButtonBackground = Color(red: 0.000, green: 0.502, blue: 1.000, opacity: 1.000)
    public static let timeButtonForeground = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    
    //public static let goalButtonBackground = Color(red: 0.2075, green: 0.547, blue: 0.6545, opacity: 1.000)
    public static let goalButtonBackground = Color(red: 0.7500, green: 0.2500, blue: 0.2500, opacity: 1.000)
    public static let goalButtonForeground = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    
    public static let motivationButtonBackground = Color(red: 1.0000, green: 0.6470, blue: 0.0000, opacity: 1.000)
    public static let motivationButtonForeground = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    
    public static let moneyBackground = LinearGradient(stops: [
        Gradient.Stop(color: Color(red: 0.415, green: 0.592, blue: 0.309, opacity: 1.000),
                      location: 0.000),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 0.100),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 1.000),
    ], startPoint: .top, endPoint: .bottom)
    public static let moneyForeground = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    public static let moneyButtonBackground = Color(red: 0.415, green: 0.592, blue: 0.309, opacity: 1.000)
    public static let moneyButtonForeground = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    
    public static let serviceBackground = LinearGradient(stops: [
        Gradient.Stop(color: Color(red: 0.533, green: 0.635, blue: 0.737, opacity: 1.000),
                      location: 0.000),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 0.100),
        Gradient.Stop(color: Color(red: 0.902, green: 0.902, blue: 0.902, opacity: 1.000),
                      location: 1.000),
    ], startPoint: .top, endPoint: .bottom)
    public static let serviceForeground = Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 1.00)
    public static let serviceButtonBackground = Color(red: 0.533, green: 0.635, blue: 0.737, opacity: 1.000)
    public static let serviceButtonForeground = Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 1.00)
}
*/

/*
struct OtherSchemas_obsolete {
    public static let fileBackground        = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 0.250)
    public static let fileForeground        = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.000)
    
    public static let defaultBackground     = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.00)
    public static let defaultForeground     = Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 1.0)
    
    public static let clearBackground       = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 0.00)
    public static let clearForeground       = Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.0)
    
    public static let backButtonColor       = Color(red: 0.098, green: 0.098, blue: 0.098, opacity: 1.000)
    
    public static let navigationTitleColor  = Color(red: 0.000, green: 0.118, blue: 0.220, opacity: 1.000)
}
 */

/*
struct textFieldFormatting_obsolete{
    public static let paddingSize: CGFloat = 7
    public static let borderColorDefault = Color(red: 0.00, green: 0.00, blue: 1.00, opacity: 1.00)
    public static let textColorDefault: Color = .white
}
 */

/*
struct hoverFormatting_obsolete{
    public static let backgroundColor_Default: Color = Color(red: 0.00, green: 0.00, blue: 0.00, opacity: 0.750)
    public static let backgroundColor_Add: Color = Color(red: 0.00, green: 0.10, blue: 0.00, opacity: 0.750)
    public static let backgroundColor_Remove: Color = Color(red: 0.10, green: 0.00, blue: 0.00, opacity: 0.750)
    public static let foregroundColor_Default: Color = Color(red: 1.00, green: 1.00, blue: 1.00, opacity: 1.000)
    public static let innerPadding: CGFloat = 10
    public static let outerPadding: CGFloat = 20
}
*/

/*
struct tableFormatting_obsolete{
    public static let headerBackground: Color = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.750)
    public static let contentBackground_level1: Color = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.500)
    public static let contentBackground_level2: Color = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 0.500)
    public static let innerPadding_Default: CGFloat = 5
    public static let innerPadding_Thin: CGFloat = 1
    public static let foregroundColor_Header: Color = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
    public static let foregroundColor_Content_level1: Color = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
    public static let foregroundColor_Content_level1_dimmed: Color = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 0.500)
    public static let foregroundColor_Content_level2: Color = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 1.000)
    public static let foregroundColor_Content_level2_dimmed: Color = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.500)
}
*/

/*
struct HoverMenuButtons_obsolete {
    public static let shineColor = Color(red: 1.000, green: 0.502, blue: 0.000, opacity: 1.000)
    
    public static let yesForegroundOn = Color(red: 0.000, green: 1.000, blue: 0.000, opacity: 1.000)
    public static let yesBackgroundOn = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.900)
    public static let yesForegroundOff = Color(red: 0.000, green: 1.000, blue: 0.000, opacity: 0.500)
    public static let yesBackgroundOff = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.500)
    
    public static let noForegroundOn = Color(red: 1.000, green: 0.000, blue: 0.000, opacity: 1.000)
    public static let noBackgroundOn = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.900)
    public static let noForegroundOff = Color(red: 1.000, green: 0.000, blue: 0.000, opacity: 0.500)
    public static let noBackgroundOff = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.500)
    
    public static let neutralForegroundOn = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 1.000)
    public static let neutralBackgroundOn = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.900)
    public static let neutralForegroundOff = Color(red: 1.000, green: 1.000, blue: 1.000, opacity: 0.500)
    public static let neutralBackgroundOff = Color(red: 0.000, green: 0.000, blue: 0.000, opacity: 0.500)
}
*/
