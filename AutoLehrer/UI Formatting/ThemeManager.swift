import SwiftUI
import CoreData

final class ThemeManager: ObservableObject {
    @Published var currentTheme: NG_Theme
    
    init(context: NSManagedObjectContext) {
        let storedTheme = Settings.getTheme(in: context)
        self.currentTheme = theme_regular_bright
        if(storedTheme == "Regular_Bright"){
            self.currentTheme = theme_regular_bright
        }
        if(storedTheme == "Regular_Dark"){
            self.currentTheme = theme_regular_dark
        }
        if(storedTheme == "Frauen_Bright"){
            self.currentTheme = theme_frauen_bright
        }
        if(storedTheme == "Frauen_Dark"){
            self.currentTheme = theme_frauen_dark
        }
        if(storedTheme == "Herren_Bright"){
            self.currentTheme = theme_herren_bright
        }
        if(storedTheme == "Herren_Dark"){
            self.currentTheme = theme_herren_dark
        }
        if(storedTheme == "Cyber_Bright"){
            self.currentTheme = theme_cyberpunk_bright
        }
        if(storedTheme == "Cyber_Dark"){
            self.currentTheme = theme_cyberpunk_dark
        }
        if(storedTheme == "Retrowave_Bright"){
            self.currentTheme = theme_retrowave_bright
        }
        if(storedTheme == "Retrowave_Dark"){
            self.currentTheme = theme_retrowave_dark
        }
    }
}

let theme_regular_bright = NG_Theme(
    themeStyle : Theme_Style.regular,
    themeOption : Theme_Option.bright,
    
        //  Colors for page
        //  options:
        //      only one option
        //  values:
        //      top background
        //      bottom background
        
         NG_Color_Page_Background_Top                                       : Color.NG_RawColor_White,
         NG_Color_Page_Background_Bottom                                    : Color.NG_RawColor_BrightGray,
        
        //  Colors for texts
        //  options:
        //      Regular
        //      Red
        //      Green
        //      Disabled
        //      AppWizard
        //      Title
        //      Sheet Title
        //  values:
        //      Text color
        //      Shadow
        //      Glare
        
         NG_Color_Text_Regular_Text                                         : Color.NG_RawColor_Black,
         NG_Color_Text_Regular_Shadow                                       : Color.NG_RawColor_MediumGray,
         NG_Color_Text_Regular_Glare                                        : Color.NG_RawColor_MediumGray,
        
         NG_Color_Text_Red_Text                                             : Color.NG_RawColor_VeryDarkRed,
         NG_Color_Text_Red_Shadow                                           : Color.NG_RawColor_MediumGray,
         NG_Color_Text_Red_Glare                                            : Color.NG_RawColor_BrightRed,
        
         NG_Color_Text_Green_Text                                           : Color.NG_RawColor_VeryDarkGreen,
         NG_Color_Text_Green_Shadow                                         : Color.NG_RawColor_MediumGray,
         NG_Color_Text_Green_Glare                                          : Color.NG_RawColor_MediumPureGreen,
        
         NG_Color_Text_Disabled_Text                                        : Color.NG_RawColor_BrightGray,
         NG_Color_Text_Disabled_Shadow                                      : Color.NG_RawColor_BrightGray,
         NG_Color_Text_Disabled_Glare                                       : Color.NG_RawColor_BrightGray,
        
         NG_Color_Text_AppWizard_Text                                       : Color.NG_RawColor_VeryDarkPink,
         NG_Color_Text_AppWizard_Shadow                                     : Color.NG_RawColor_MediumGray,
         NG_Color_Text_AppWizard_Glare                                      : Color.NG_RawColor_BrightPink,
    
        NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,
        NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,
    
        NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
        NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
        NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
        NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
        NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
        NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
        NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
        
        //  Colors for cards
        //  options:
        //      Regular
        //      AppWizard
        //      Red
        //      Green
        //      Completed
        //      InProgress
        //      Passed
        //      Future
        //      Today
        //  values:
        //      TopLeft background
        //      BottomRight background
        //      Shadow
        //      BorderDark
        //      BorderBright
        //      BorderBright2 (optional)
        
         NG_Color_Card_Background_TopLeft_Regular                     : Color.NG_RawColor_White,
         NG_Color_Card_Background_BottomRight_Regular                 : Color.NG_RawColor_BrightGray,
         NG_Color_Card_Shadow_Regular                                 : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Regular                            : Color.NG_RawColor_BrightGray,
         NG_Color_Card_Border_Bright_Regular                          : Color.NG_RawColor_White,
        
         NG_Color_Card_Background_TopLeft_AppWizard                   : Color.NG_RawColor_VeryBrightPink,
         NG_Color_Card_Background_BottomRight_AppWizard               : Color.NG_RawColor_BrightPink,
         NG_Color_Card_Shadow_AppWizard                               : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_AppWizard                          : Color.NG_RawColor_VeryDarkPink,
         NG_Color_Card_Border_Bright_AppWizard                        : Color.NG_RawColor_VeryBrightPink,
        
         NG_Color_Card_Background_TopLeft_Red                         : Color.NG_RawColor_VeryBrightRed,
         NG_Color_Card_Background_BottomRight_Red                     : Color.NG_RawColor_BrightRed,
         NG_Color_Card_Shadow_Red                                     : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Red                                : Color.NG_RawColor_VeryDarkRed,
         NG_Color_Card_Border_Bright_Red                              : Color.NG_RawColor_VeryBrightRed,
        
         NG_Color_Card_Background_TopLeft_Green                       : Color.NG_RawColor_VeryBrightGreen,
         NG_Color_Card_Background_BottomRight_Green                   : Color.NG_RawColor_BrightGreen,
         NG_Color_Card_Shadow_Green                                   : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Green                              : Color.NG_RawColor_VeryDarkGreen,
         NG_Color_Card_Border_Bright_Green                            : Color.NG_RawColor_VeryBrightGreen,
        
         NG_Color_Card_Background_TopLeft_Completed                   : Color.NG_RawColor_VeryBrightGreen,
         NG_Color_Card_Background_BottomRight_Completed               : Color.NG_RawColor_BrightGreen,
         NG_Color_Card_Shadow_Completed                               : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Completed                          : Color.NG_RawColor_VeryDarkGreen,
         NG_Color_Card_Border_Bright_Completed                        : Color.NG_RawColor_MediumPureGreen,
        
         NG_Color_Card_Background_TopLeft_InProgress                  : Color.NG_RawColor_VeryBrightBlue,
         NG_Color_Card_Background_BottomRight_InProgress              : Color.NG_RawColor_BrightGreen,
         NG_Color_Card_Shadow_InProgress                              : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_InProgress                         : Color.NG_RawColor_VeryDarkGreen,
         NG_Color_Card_Border_Bright_InProgress                       : Color.NG_RawColor_MediumPureBlue,
         NG_Color_Card_Border_Bright_InProgress_2                     : Color.NG_RawColor_MediumPureGreen,
        
         NG_Color_Card_Background_TopLeft_Passed                      : Color.NG_RawColor_VeryBrightRed,
         NG_Color_Card_Background_BottomRight_Passed                  : Color.NG_RawColor_BrightRed,
         NG_Color_Card_Shadow_Passed                                  : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Passed                             : Color.NG_RawColor_VeryDarkRed,
         NG_Color_Card_Border_Bright_Passed                           : Color.NG_RawColor_MediumPureRed,
        
         NG_Color_Card_Background_TopLeft_Future                      : Color.NG_RawColor_VeryBrightCyan,
         NG_Color_Card_Background_BottomRight_Future                  : Color.NG_RawColor_BrightCyan,
         NG_Color_Card_Shadow_Future                                  : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Future                             : Color.NG_RawColor_VeryDarkCyan,
         NG_Color_Card_Border_Bright_Future                           : Color.NG_RawColor_MediumCyan,
        
         NG_Color_Card_Background_TopLeft_Today                       : Color.NG_RawColor_VeryBrightBlue,
         NG_Color_Card_Background_BottomRight_Today                   : Color.NG_RawColor_BrightBlue,
         NG_Color_Card_Shadow_Today                                   : Color.NG_RawColor_MediumGray,
         NG_Color_Card_Border_Dark_Today                              : Color.NG_RawColor_VeryDarkBlue,
         NG_Color_Card_Border_Bright_Today                            : Color.NG_RawColor_MediumPureBlue,
    
    /*
     NG_Color_Button_Background_TopLeft_Disabled                  : Color.NG_RawColor_CloudedSteel,
     NG_Color_Button_Background_BottomRight_Disabled              : Color.NG_RawColor_MutedSteelBlue,
     NG_Color_Button_Shadow_Disabled                              : Color.NG_RawColor_MediumGray,
     NG_Color_Button_Border_Dark_Disabled                         : Color.NG_RawColor_SmokySteelBlue,
     NG_Color_Button_Border_Bright_Disabled                       : Color.NG_RawColor_FrostedSilver,
     */
    NG_Color_Card_Background_TopLeft_NotStarted                       : Color.NG_RawColor_CloudedSteel,
    NG_Color_Card_Background_BottomRight_NotStarted                   : Color.NG_RawColor_MutedSteelBlue,
    NG_Color_Card_Shadow_NotStarted                                   : Color.NG_RawColor_MediumGray,
    NG_Color_Card_Border_Dark_NotStarted                              : Color.NG_RawColor_SmokySteelBlue,
    NG_Color_Card_Border_Bright_NotStarted                            : Color.NG_RawColor_FrostedSilver,
    
    /*
     var NG_Color_Button_Background_TopLeft_Skipped: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Skipped: Color           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Shadow_Skipped: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Glare_Skipped: Color                            = Color.NG_RawColor_Black
     var NG_Color_Button_Border_Dark_Skipped: Color                      = Color.NG_RawColor_Black
     var NG_Color_Button_Border_Bright_Skipped: Color                    = Color.NG_RawColor_White
     var NG_Color_Button_Text_Skipped: Color                             = Color.NG_RawColor_Black
     */
    NG_Color_Card_Background_TopLeft_Skipped                       : Color.NG_RawColor_White,
    NG_Color_Card_Background_BottomRight_Skipped                   : Color.NG_RawColor_MediumGray,
    NG_Color_Card_Shadow_Skipped                                   : Color.NG_RawColor_MediumGray,
    NG_Color_Card_Border_Dark_Skipped                              : Color.NG_RawColor_Black,
    NG_Color_Card_Border_Bright_Skipped                            : Color.NG_RawColor_White,
     
    /*
     var NG_Color_Button_Background_TopLeft_Easy: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Easy: Color           = Color.NG_RawColor_MediumPureCyan
     var NG_Color_Button_Shadow_Easy: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Glare_Easy: Color                            = Color.NG_RawColor_MediumPureCyan
     var NG_Color_Button_Border_Dark_Easy: Color                      = Color.NG_RawColor_VeryDarkPureCyan
     var NG_Color_Button_Border_Bright_Easy: Color                    = Color.NG_RawColor_BrightPureCyan
     var NG_Color_Button_Text_Easy: Color                             = Color.NG_RawColor_Black
     */
    NG_Color_Card_Background_TopLeft_Easy                       : Color.NG_RawColor_White,
    NG_Color_Card_Background_BottomRight_Easy                   : Color.NG_RawColor_MediumPureCyan,
    NG_Color_Card_Shadow_Easy                                   : Color.NG_RawColor_MediumGray,
    NG_Color_Card_Border_Dark_Easy                              : Color.NG_RawColor_VeryDarkPureCyan,
    NG_Color_Card_Border_Bright_Easy                            : Color.NG_RawColor_BrightPureCyan,
    
    /*
     var NG_Color_Button_Background_TopLeft_Normal: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Normal: Color           = Color.NG_RawColor_MediumPureGreen
     var NG_Color_Button_Shadow_Normal: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Glare_Normal: Color                            = Color.NG_RawColor_MediumPureGreen
     var NG_Color_Button_Border_Dark_Normal: Color                      = Color.NG_RawColor_DarkPureGreen
     var NG_Color_Button_Border_Bright_Normal: Color                    = Color.NG_RawColor_BrightPureGreen
     var NG_Color_Button_Text_Normal: Color                             = Color.NG_RawColor_Black
     */
    NG_Color_Card_Background_TopLeft_Normal                       : Color.NG_RawColor_White,
    NG_Color_Card_Background_BottomRight_Normal                   : Color.NG_RawColor_MediumPureGreen,
    NG_Color_Card_Shadow_Normal                                   : Color.NG_RawColor_MediumGray,
    NG_Color_Card_Border_Dark_Normal                              : Color.NG_RawColor_DarkPureGreen,
    NG_Color_Card_Border_Bright_Normal                            : Color.NG_RawColor_BrightPureGreen,
     
    /*
     var NG_Color_Button_Background_TopLeft_Hard: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Hard: Color           = Color.NG_RawColor_MediumPureRed
     var NG_Color_Button_Shadow_Hard: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Border_Dark_Hard: Color                      = Color.NG_RawColor_DarkPureRed
     var NG_Color_Button_Border_Bright_Hard: Color                    = Color.NG_RawColor_BrightPureRed
     */
    NG_Color_Card_Background_TopLeft_Hard                       : Color.NG_RawColor_White,
    NG_Color_Card_Background_BottomRight_Hard                   : Color.NG_RawColor_MediumPureRed,
    NG_Color_Card_Shadow_Hard                                   : Color.NG_RawColor_MediumGray,
    NG_Color_Card_Border_Dark_Hard                              : Color.NG_RawColor_DarkPureRed,
    NG_Color_Card_Border_Bright_Hard                            : Color.NG_RawColor_BrightPureRed,
    
    NG_Color_Card_Background_TopLeft_Highlighted                       : Color(hex: "#FFEE58"),
    NG_Color_Card_Background_BottomRight_Highlighted                   : Color(hex: "#FFCA28"),
    NG_Color_Card_Shadow_Highlighted                                   : Color(hex: "#F57F17"),
    NG_Color_Card_Border_Dark_Highlighted                              : Color(hex: "#E65100"),
    NG_Color_Card_Border_Bright_Highlighted                            : Color(hex: "#FFD54F"),
    
        
        //  Colors for button
        //  options:
        //      Regular
        //      Red
        //      Green
        //      Service
        //      Disabled
        //      Highlighted
        //      DatePicker
        //      Skipped
        //      Easy
        //      Normal
        //      Hard
        //  values:
        //      TopLeft background
        //      BottomRight background
        //      Shadow
        //      Glare
        //      BorderDark
        //      BorderBright
        //      Text color
        
         NG_Color_Button_Background_TopLeft_Regular                   : Color.NG_RawColor_CoolCornflowerBlue,
         NG_Color_Button_Background_BottomRight_Regular               : Color.NG_RawColor_DeepSapphireBlue,
         NG_Color_Button_Shadow_Regular                               : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Regular                                : Color.NG_RawColor_IcyMistBlue,
         NG_Color_Button_Border_Dark_Regular                          : Color.NG_RawColor_MidnightIndigo,
         NG_Color_Button_Border_Bright_Regular                        : Color.NG_RawColor_IcyMistBlue,
         NG_Color_Button_Text_Regular                                 : Color.NG_RawColor_White,
        
         NG_Color_Button_Background_TopLeft_Red                       : Color.NG_RawColor_BrightRed,
         NG_Color_Button_Background_BottomRight_Red                   : Color.NG_RawColor_DarkRed,
         NG_Color_Button_Shadow_Red                                   : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Red                                    : Color.NG_RawColor_VeryBrightRed,
         NG_Color_Button_Border_Dark_Red                              : Color.NG_RawColor_DarkRed,
         NG_Color_Button_Border_Bright_Red                            : Color.NG_RawColor_BrightRed,
         NG_Color_Button_Text_Red                                     : Color.NG_RawColor_White,
        
         NG_Color_Button_Background_TopLeft_Green                     : Color.NG_RawColor_BrightGreen,
         NG_Color_Button_Background_BottomRight_Green                 : Color.NG_RawColor_DarkGreen,
         NG_Color_Button_Shadow_Green                                 : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Green                                  : Color.NG_RawColor_VeryBrightGreen,
         NG_Color_Button_Border_Dark_Green                            : Color.NG_RawColor_DarkGreen,
         NG_Color_Button_Border_Bright_Green                          : Color.NG_RawColor_BrightGreen,
         NG_Color_Button_Text_Green                                   : Color.NG_RawColor_White,
        
         NG_Color_Button_Background_TopLeft_Service                   : Color.NG_RawColor_SteelMistBlue,
         NG_Color_Button_Background_BottomRight_Service               : Color.NG_RawColor_SlateSkyBlue,
         NG_Color_Button_Shadow_Service                               : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Service                                : Color.NG_RawColor_PaleFrostBlue,
         NG_Color_Button_Border_Dark_Service                          : Color.NG_RawColor_MarineTwilightBlue,
         NG_Color_Button_Border_Bright_Service                        : Color.NG_RawColor_PaleFrostBlue,
         NG_Color_Button_Text_Service                                 : Color.NG_RawColor_White,
        
         NG_Color_Button_Background_TopLeft_Disabled                  : Color.NG_RawColor_CloudedSteel,
         NG_Color_Button_Background_BottomRight_Disabled              : Color.NG_RawColor_MutedSteelBlue,
         NG_Color_Button_Shadow_Disabled                              : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Disabled                               : .clear,
         NG_Color_Button_Border_Dark_Disabled                         : Color.NG_RawColor_SmokySteelBlue,
         NG_Color_Button_Border_Bright_Disabled                       : Color.NG_RawColor_FrostedSilver,
         NG_Color_Button_Text_Disabled                                : Color.NG_RawColor_White,
        
         NG_Color_Button_Background_TopLeft_Highlighted               : Color.NG_RawColor_VeryBrightRed,
         NG_Color_Button_Background_BottomRight_Highlighted           : Color.NG_RawColor_MediumRed,
         NG_Color_Button_Shadow_Highlighted                           : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Highlighted                            : Color.NG_RawColor_BrightRed,
         NG_Color_Button_Border_Dark_Highlighted                      : Color.NG_RawColor_DarkRed,
         NG_Color_Button_Border_Bright_Highlighted                    : Color.NG_RawColor_MediumRed,
         NG_Color_Button_Text_Highlighted                             : Color.NG_RawColor_White,
        
         NG_Color_Button_Background_TopLeft_DatePicker                : Color.NG_RawColor_White,
         NG_Color_Button_Background_BottomRight_DatePicker            : Color.NG_RawColor_BrightGray,
         NG_Color_Button_Shadow_DatePicker                            : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_DatePicker                             : Color.NG_RawColor_PaleFrostBlue,
         NG_Color_Button_Border_Dark_DatePicker                       : Color.NG_RawColor_BrightGray,
         NG_Color_Button_Border_Bright_DatePicker                     : Color.NG_RawColor_White,
         NG_Color_Button_Text_DatePicker                              : Color.NG_RawColor_Black,
        
         NG_Color_Button_Background_TopLeft_Skipped                : Color.NG_RawColor_White,
         NG_Color_Button_Background_BottomRight_Skipped            : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Shadow_Skipped                            : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Skipped                             : Color.NG_RawColor_Black,
         NG_Color_Button_Border_Dark_Skipped                       : Color.NG_RawColor_Black,
         NG_Color_Button_Border_Bright_Skipped                     : Color.NG_RawColor_White,
         NG_Color_Button_Text_Skipped                              : Color.NG_RawColor_Black,
        
         NG_Color_Button_Background_TopLeft_Easy                : Color.NG_RawColor_White,
         NG_Color_Button_Background_BottomRight_Easy            : Color.NG_RawColor_MediumPureCyan,
         NG_Color_Button_Shadow_Easy                            : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Easy                             : Color.NG_RawColor_MediumPureCyan,
         NG_Color_Button_Border_Dark_Easy                       : Color.NG_RawColor_VeryDarkPureCyan,
         NG_Color_Button_Border_Bright_Easy                     : Color.NG_RawColor_BrightPureCyan,
         NG_Color_Button_Text_Easy                              : Color.NG_RawColor_Black,
        
         NG_Color_Button_Background_TopLeft_Normal                : Color.NG_RawColor_White,
         NG_Color_Button_Background_BottomRight_Normal            : Color.NG_RawColor_MediumPureGreen,
         NG_Color_Button_Shadow_Normal                            : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Normal                             : Color.NG_RawColor_MediumPureGreen,
         NG_Color_Button_Border_Dark_Normal                       : Color.NG_RawColor_DarkPureGreen,
         NG_Color_Button_Border_Bright_Normal                     : Color.NG_RawColor_BrightPureGreen,
         NG_Color_Button_Text_Normal                              : Color.NG_RawColor_Black,
        
         NG_Color_Button_Background_TopLeft_Hard                : Color.NG_RawColor_White,
         NG_Color_Button_Background_BottomRight_Hard            : Color.NG_RawColor_MediumPureRed,
         NG_Color_Button_Shadow_Hard                            : Color.NG_RawColor_MediumGray,
         NG_Color_Button_Glare_Hard                             : Color.NG_RawColor_MediumPureRed,
         NG_Color_Button_Border_Dark_Hard                       : Color.NG_RawColor_DarkPureRed,
         NG_Color_Button_Border_Bright_Hard                     : Color.NG_RawColor_BrightPureRed,
         NG_Color_Button_Text_Hard                              : Color.NG_RawColor_Black,
        
        //  Colors for date picker
        //  options:
        //      only one option
        //  values:
        //      Background
        //      Foreground
        
         NG_Color_DatePicker_Background                               : Color.NG_RawColor_DarkGray,
         NG_Color_DatePicker_Foreground                               : Color.NG_RawColor_White,
        
        //  Colors for icon
        //  options:
        //      Red
        //      Green
        //      Regular
        //      Disabled
        //  values:
        //      TopLeft background
        //      BottomRight background
        //      Glare
        //      Icon color
        
         NG_Color_Icon_TopLeft_Red                                    : Color.NG_RawColor_BrightRed,
         NG_Color_Icon_BottomRight_Red                                : Color.NG_RawColor_DarkRed,
         NG_Color_Icon_Glare_Red                                      : Color.NG_RawColor_MediumRed,
        
         NG_Color_Icon_TopLeft_Green                                  : Color.NG_RawColor_BrightGreen,
         NG_Color_Icon_BottomRight_Green                              : Color.NG_RawColor_DarkGreen,
         NG_Color_Icon_Glare_Green                                    : Color.NG_RawColor_MediumGreen,
        
         NG_Color_Icon_TopLeft_Regular                                : Color.NG_RawColor_BrightGray,
         NG_Color_Icon_BottomRight_Regular                            : Color.NG_RawColor_DarkGray,
         NG_Color_Icon_Glare_Regular                                  : Color.NG_RawColor_MediumGray,
        
         NG_Color_Icon_TopLeft_Disabled                               : Color.NG_RawColor_BrightBlue,
         NG_Color_Icon_BottomRight_Disabled                           : Color.NG_RawColor_DarkBlue,
         NG_Color_Icon_Glare_Disabled                                 : Color.NG_RawColor_MediumBlue,
        
        //  Colors for list rows
        //  options:
        //      Top
        //      Top highlighted
        //      Second
        //      Second highlighted
        //  values:
        //      TopLeft background
        //      BottomRight background
        //      Text color
        
         NG_Color_ListRow_Separator                                   : Color.NG_RawColor_VeryDarkGray,
        
         NG_Color_ListRow_Background_TopLeft_Top                      : Color.NG_RawColor_White,
         NG_Color_ListRow_Background_BottomRight_Top                  : Color.NG_RawColor_BrightGray,
         NG_Color_ListRow_Text_Top                                    : Color.NG_RawColor_White,
        
         NG_Color_ListRow_Background_TopLeft_Top_Highlighted          : Color.NG_RawColor_White,
         NG_Color_ListRow_Background_BottomRight_Top_Highlighted      : Color.NG_RawColor_BrightLime,
         NG_Color_ListRow_Text_Top_Highlighted                        : Color.NG_RawColor_White,
        
         NG_Color_ListRow_Background_TopLeft_Second                   : Color.NG_RawColor_BrightGray,
         NG_Color_ListRow_Background_BottomRight_Second               : Color.NG_RawColor_VeryDarkGray,
         NG_Color_ListRow_Text_Second                                 : Color.NG_RawColor_Black,
        
         NG_Color_ListRow_Background_TopLeft_Second_Highlighted       : Color.NG_RawColor_BrightGray,
         NG_Color_ListRow_Background_BottomRight_Second_Highlighted   : Color.NG_RawColor_VeryDarkLime,
         NG_Color_ListRow_Text_Second_Highlighted                     : Color.NG_RawColor_Black,
        
        //  Colors for text field
        //  options:
        //      only one option
        //  values:
        //      background
        //      border
        //      inner shadow
        //      outer shadow
        //      text color
        
         NG_Color_TextField_Background                                : Color.NG_RawColor_White,
         NG_Color_TextField_Border                                    : Color.NG_RawColor_DarkGray,
         NG_Color_TextField_InnerShadow                               : Color.NG_RawColor_MediumGray,
         NG_Color_TextField_OuterGlare                                : Color.NG_RawColor_MediumRed,
         NG_Color_TextField_Text                                      : Color.NG_RawColor_Black,
        
        //  Colors for selector
        //  options:
        //      only one option
        //  values:
        //      selected background
        //      regular background
        //      text selected
        //      text normal
        
         NG_Color_Selector_selectedSegmentTintColor                   : Color.NG_RawColor_BrightGray,
         NG_Color_Selector_backgroundColor                            : Color.NG_RawColor_DarkGray,
         NG_Color_Selector_text_selected                              : Color.NG_RawColor_White,
         NG_Color_Selector_text_normal                                : Color.NG_RawColor_White,
        
        //  Colors for checkbox
        //  options:
        //      selected
        //      not selected
        //  values:
        //      tint
        //      glare
        
         NG_Color_Checkbox_selectedTintColor                          : Color.NG_RawColor_BrightGreen,
         NG_Color_Checkbox_selectedGlare                              : Color.NG_RawColor_MediumGreen,
        
         NG_Color_Checkbox_notSelectedTintColor                       : Color.NG_RawColor_DarkGray,
         NG_Color_Checkbox_notSelectedGlare                           : Color.NG_RawColor_Black,
        
        //  Colors for grids
        //  options:
        //      master header
        //      sub header
        //      rows
        //  values:
        //      background
        //      text
        
         NG_Color_Grid_MasterHeader_Background                        : Color.NG_RawColor_DarkGray,
         NG_Color_Grid_MasterHeader_Text                              : Color.NG_RawColor_White,
        
         NG_Color_Grid_SubHeader_Background                           : Color.NG_RawColor_MediumGray,
         NG_Color_Grid_SubHeader_Text                                 : Color.NG_RawColor_White,
        
         NG_Color_Grid_Rows_Background                                : Color.NG_RawColor_BrightGray,
         NG_Color_Grid_Rows_Text                                      : Color.NG_RawColor_Black,
)

let theme_regular_dark = NG_Theme(
    themeStyle : Theme_Style.regular,
    themeOption : Theme_Option.dark,
    
        //  Colors for page
        //  options:
        //      only one option
        //  values:
        //      top background
        //      bottom background
    
    NG_Color_Page_Background_Top                                       : Color(hex: "#252A33"),
    NG_Color_Page_Background_Bottom                                    : Color(hex: "#15191F"),
        
        //  Colors for texts
        //  options:
        //      Regular
        //      Red
        //      Green
        //      Disabled
        //      AppWizard
        //      Title
        //      Sheet Title
        //  values:
        //      Text color
        //      Shadow
        //      Glare
        
         NG_Color_Text_Regular_Text         : Color(hex: "#F0F2F5"),
         NG_Color_Text_Regular_Shadow       : Color(hex: "#1A1D24"),
         NG_Color_Text_Regular_Glare        : Color(hex: "#6A7380"),
        
         NG_Color_Text_Red_Text             : Color(hex: "#FF6B6B"),
         NG_Color_Text_Red_Shadow           : Color(hex: "#2B1212"),
         NG_Color_Text_Red_Glare            : Color(hex: "#FF9999"),
        
         NG_Color_Text_Green_Text           : Color(hex: "#3DDC84"),
         NG_Color_Text_Green_Shadow         : Color(hex: "#102A1C"),
         NG_Color_Text_Green_Glare          : Color(hex: "#78E08F"),
        
         NG_Color_Text_Disabled_Text        : Color(hex: "#666C74"),
         NG_Color_Text_Disabled_Shadow      : Color(hex: "#1C1F25"),
         NG_Color_Text_Disabled_Glare       : Color(hex: "#3D434B"),
        
         NG_Color_Text_AppWizard_Text       : Color(hex: "#FF77DD"),
         NG_Color_Text_AppWizard_Shadow     : Color(hex: "#331C2A"),
         NG_Color_Text_AppWizard_Glare      : Color(hex: "#FFB3F1"),
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
        
        //  Colors for cards
        //  options:
        //      Regular
        //      AppWizard
        //      Red
        //      Green
        //      Completed
        //      InProgress
        //      Passed
        //      Future
        //      Today
        //  values:
        //      TopLeft background
        //      BottomRight background
        //      Shadow
        //      BorderDark
        //      BorderBright
        //      BorderBright2 (optional)
        
         NG_Color_Card_Background_TopLeft_Regular                     : Color(hex: "#2F333B"),
         NG_Color_Card_Background_BottomRight_Regular                 : Color(hex: "#1A1E25"),
         NG_Color_Card_Shadow_Regular                                 : Color(hex: "#000000"),
         NG_Color_Card_Border_Dark_Regular                            : Color(hex: "#15191F"),
         NG_Color_Card_Border_Bright_Regular                          : Color(hex: "#3D434B"),
        
         NG_Color_Card_Background_TopLeft_AppWizard                   : Color(hex: "#4A2D3E"),
         NG_Color_Card_Background_BottomRight_AppWizard               : Color(hex: "#341F2D"),
         NG_Color_Card_Shadow_AppWizard                               : Color(hex: "#994C80"),
         NG_Color_Card_Border_Dark_AppWizard                          : Color(hex: "#260F1D"),
         NG_Color_Card_Border_Bright_AppWizard                        : Color(hex: "#FF77DD"),
        
         NG_Color_Card_Background_TopLeft_Red                         : Color(hex: "#5A1C1C"),
         NG_Color_Card_Background_BottomRight_Red                     : Color(hex: "#3C1010"),
         NG_Color_Card_Shadow_Red                                     : Color(hex: "#8C2B2B"),
         NG_Color_Card_Border_Dark_Red                                : Color(hex: "#260808"),
         NG_Color_Card_Border_Bright_Red                              : Color(hex: "#993333"),
        
         NG_Color_Card_Background_TopLeft_Green                       : Color(hex: "#2A4D2D"),
         NG_Color_Card_Background_BottomRight_Green                   : Color(hex: "#1C3920"),
         NG_Color_Card_Shadow_Green                                   : Color(hex: "#2C7A4F"),
         NG_Color_Card_Border_Dark_Green                              : Color(hex: "#12391F"),
         NG_Color_Card_Border_Bright_Green                            : Color(hex: "#3B9A5E"),
        
         NG_Color_Card_Background_TopLeft_Completed                   : Color(hex: "#1E3A29"),
         NG_Color_Card_Background_BottomRight_Completed               : Color(hex: "#162B20"),
         NG_Color_Card_Shadow_Completed                               : Color(hex: "#1A4F3C"),
         NG_Color_Card_Border_Dark_Completed                          : Color(hex: "#10201A"),
         NG_Color_Card_Border_Bright_Completed                        : Color(hex: "#1A4F3C"),
         
         NG_Color_Card_Background_TopLeft_InProgress                  : Color(hex: "#1B2A3A"),
         NG_Color_Card_Background_BottomRight_InProgress              : Color(hex: "#162B20"),
         NG_Color_Card_Shadow_InProgress                              : Color(hex: "#1F2A38"),
         NG_Color_Card_Border_Dark_InProgress                         : Color(hex: "#112133"),
         NG_Color_Card_Border_Bright_InProgress                       : Color(hex: "#3A5A8A"),
         NG_Color_Card_Border_Bright_InProgress_2                     : Color(hex: "#40A47A"),
         
         NG_Color_Card_Background_TopLeft_Passed                      : Color(hex: "#3A1B1B"),
         NG_Color_Card_Background_BottomRight_Passed                  : Color(hex: "#2A1414"),
         NG_Color_Card_Shadow_Passed                                  : Color(hex: "#4F1E1E"),
         NG_Color_Card_Border_Dark_Passed                             : Color(hex: "#291010"),
         NG_Color_Card_Border_Bright_Passed                           : Color(hex: "#4F1E1E"),
         
         NG_Color_Card_Background_TopLeft_Future                      : Color(hex: "#1C3B3F"),
         NG_Color_Card_Background_BottomRight_Future                  : Color(hex: "#162F33"),
         NG_Color_Card_Shadow_Future                                  : Color(hex: "#1F4B50"),
         NG_Color_Card_Border_Dark_Future                             : Color(hex: "#112B2F"),
         NG_Color_Card_Border_Bright_Future                           : Color(hex: "#1F4B50"),
         
         NG_Color_Card_Background_TopLeft_Today                       : Color(hex: "#1B2A3A"),
         NG_Color_Card_Background_BottomRight_Today                   : Color(hex: "#16233A"),
         NG_Color_Card_Shadow_Today                                   : Color(hex: "#1F2E48"),
         NG_Color_Card_Border_Dark_Today                              : Color(hex: "#11203A"),
         NG_Color_Card_Border_Bright_Today                            : Color(hex: "#1F2E48"),
    
    /*
     NG_Color_Button_Background_TopLeft_Disabled      : Color(hex: "#5A5F66"),
     NG_Color_Button_Background_BottomRight_Disabled  : Color(hex: "#3F4C5A"),
     NG_Color_Button_Shadow_Disabled                  : Color(hex: "#4F4F4F"),
     NG_Color_Button_Border_Dark_Disabled             : Color(hex: "#313A43"),
     NG_Color_Button_Border_Bright_Disabled           : Color(hex: "#6A737B"),
     */
    NG_Color_Card_Background_TopLeft_NotStarted                       : Color(hex: "#5A5F66"),
    NG_Color_Card_Background_BottomRight_NotStarted                   : Color(hex: "#3F4C5A"),
    NG_Color_Card_Shadow_NotStarted                                   : Color(hex: "#4F4F4F"),
    NG_Color_Card_Border_Dark_NotStarted                              : Color(hex: "#313A43"),
    NG_Color_Card_Border_Bright_NotStarted                            : Color(hex: "#6A737B"),
     
    /*
     NG_Color_Button_Background_TopLeft_Skipped                : Color(hex: "#2F333B"),
     NG_Color_Button_Background_BottomRight_Skipped            : Color(hex: "#1A1E25"),
     NG_Color_Button_Shadow_Skipped                            : Color(hex: "#111418"),
     NG_Color_Button_Border_Dark_Skipped                       : Color(hex: "#12161B"),
     NG_Color_Button_Border_Bright_Skipped                     : Color(hex: "#5A626B"),
    */
    NG_Color_Card_Background_TopLeft_Skipped                       : Color(hex: "#2F333B"),
    NG_Color_Card_Background_BottomRight_Skipped                   : Color(hex: "#1A1E25"),
    NG_Color_Card_Shadow_Skipped                                   : Color(hex: "#111418"),
    NG_Color_Card_Border_Dark_Skipped                              : Color(hex: "#12161B"),
    NG_Color_Card_Border_Bright_Skipped                            : Color(hex: "#5A626B"),
    
    /*
     NG_Color_Button_Background_TopLeft_Easy                : Color(hex: "#2A4F54"),
     NG_Color_Button_Background_BottomRight_Easy            : Color(hex: "#1B383D"),
     NG_Color_Button_Shadow_Easy                            : Color(hex: "#102225"),
     NG_Color_Button_Border_Dark_Easy                       : Color(hex: "#183338"),
     NG_Color_Button_Border_Bright_Easy                     : Color(hex: "#4D9BA3"),
    */
    NG_Color_Card_Background_TopLeft_Easy                       : Color(hex: "#2A4F54"),
    NG_Color_Card_Background_BottomRight_Easy                   : Color(hex: "#1B383D"),
    NG_Color_Card_Shadow_Easy                                   : Color(hex: "#102225"),
    NG_Color_Card_Border_Dark_Easy                              : Color(hex: "#183338"),
    NG_Color_Card_Border_Bright_Easy                            : Color(hex: "#4D9BA3"),
    
    /*
     NG_Color_Button_Background_TopLeft_Normal                : Color(hex: "#2A4D2D"),
     NG_Color_Button_Background_BottomRight_Normal            : Color(hex: "#1C3920"),
     NG_Color_Button_Shadow_Normal                            : Color(hex: "#102A1C"),
     NG_Color_Button_Border_Dark_Normal                       : Color(hex: "#12391F"),
     NG_Color_Button_Border_Bright_Normal                     : Color(hex: "#3DDC84"),
    */
    NG_Color_Card_Background_TopLeft_Normal                       : Color(hex: "#2A4D2D"),
    NG_Color_Card_Background_BottomRight_Normal                   : Color(hex: "#1C3920"),
    NG_Color_Card_Shadow_Normal                                   : Color(hex: "#102A1C"),
    NG_Color_Card_Border_Dark_Normal                              : Color(hex: "#12391F"),
    NG_Color_Card_Border_Bright_Normal                            : Color(hex: "#3DDC84"),
    
    /*
     NG_Color_Button_Background_TopLeft_Hard                : Color(hex: "#5A1C1C"),
     NG_Color_Button_Background_BottomRight_Hard            : Color(hex: "#3C1010"),
     NG_Color_Button_Shadow_Hard                            : Color(hex: "#2B1212"),
     NG_Color_Button_Border_Dark_Hard                       : Color(hex: "#260808"),
     NG_Color_Button_Border_Bright_Hard                     : Color(hex: "#FF6B6B"),
     */
    NG_Color_Card_Background_TopLeft_Hard                       : Color(hex: "#5A1C1C"),
    NG_Color_Card_Background_BottomRight_Hard                   : Color(hex: "#3C1010"),
    NG_Color_Card_Shadow_Hard                                   : Color(hex: "#2B1212"),
    NG_Color_Card_Border_Dark_Hard                              : Color(hex: "#260808"),
    NG_Color_Card_Border_Bright_Hard                            : Color(hex: "#FF6B6B"),
    
    NG_Color_Card_Background_TopLeft_Highlighted                       : Color(hex: "#FFEE58"),
    NG_Color_Card_Background_BottomRight_Highlighted                   : Color(hex: "#FFCA28"),
    NG_Color_Card_Shadow_Highlighted                                   : Color(hex: "#F57F17"),
    NG_Color_Card_Border_Dark_Highlighted                              : Color(hex: "#E65100"),
    NG_Color_Card_Border_Bright_Highlighted                            : Color(hex: "#FFD54F"),
        
        //  Colors for button
        //  options:
        //      Regular
        //      Red
        //      Green
        //      Service
        //      Disabled
        //      Highlighted
        //      DatePicker
        //      Skipped
        //      Easy
        //      Normal
        //      Hard
        //  values:
        //      TopLeft background
        //      BottomRight background
        //      Shadow
        //      Glare
        //      BorderDark
        //      BorderBright
        //      Text color
        
    NG_Color_Button_Background_TopLeft_Regular       : Color(hex: "#3A5A8A"),
    NG_Color_Button_Background_BottomRight_Regular   : Color(hex: "#20334D"),
    NG_Color_Button_Shadow_Regular                   : Color(hex: "#1A1D24"),
    NG_Color_Button_Glare_Regular                    : Color(hex: "#6A89B8"),
    NG_Color_Button_Border_Dark_Regular              : Color(hex: "#1F2E3F"),
    NG_Color_Button_Border_Bright_Regular            : Color(hex: "#6A89B8"),
    NG_Color_Button_Text_Regular                     : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Red           : Color(hex: "#CC4444"),
    NG_Color_Button_Background_BottomRight_Red       : Color(hex: "#8A1F1F"),
    NG_Color_Button_Shadow_Red                       : Color(hex: "#2B1212"),
    NG_Color_Button_Glare_Red                        : Color(hex: "#FF9999"),
    NG_Color_Button_Border_Dark_Red                  : Color(hex: "#5A1C1C"),
    NG_Color_Button_Border_Bright_Red                : Color(hex: "#FF6B6B"),
    NG_Color_Button_Text_Red                         : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Green         : Color(hex: "#40A47A"),
    NG_Color_Button_Background_BottomRight_Green     : Color(hex: "#2A4D2D"),
    NG_Color_Button_Shadow_Green                     : Color(hex: "#102A1C"),
    NG_Color_Button_Glare_Green                      : Color(hex: "#78E08F"),
    NG_Color_Button_Border_Dark_Green                : Color(hex: "#1D3C26"),
    NG_Color_Button_Border_Bright_Green              : Color(hex: "#3DDC84"),
    NG_Color_Button_Text_Green                       : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Service       : Color(hex: "#47596F"),
    NG_Color_Button_Background_BottomRight_Service   : Color(hex: "#2D3B4C"),
    NG_Color_Button_Shadow_Service                   : Color(hex: "#1A1D24"),
    NG_Color_Button_Glare_Service                    : Color(hex: "#6A7380"),
    NG_Color_Button_Border_Dark_Service              : Color(hex: "#1C2630"),
    NG_Color_Button_Border_Bright_Service            : Color(hex: "#6A7380"),
    NG_Color_Button_Text_Service                     : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Disabled      : Color(hex: "#5A5F66"),
    NG_Color_Button_Background_BottomRight_Disabled  : Color(hex: "#3F4C5A"),
    NG_Color_Button_Shadow_Disabled                  : Color(hex: "#4F4F4F"),
    NG_Color_Button_Glare_Disabled                   : .clear,
    NG_Color_Button_Border_Dark_Disabled             : Color(hex: "#313A43"),
    NG_Color_Button_Border_Bright_Disabled           : Color(hex: "#6A737B"),
    NG_Color_Button_Text_Disabled                    : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Highlighted   : Color(hex: "#FF4D4D"),
    NG_Color_Button_Background_BottomRight_Highlighted : Color(hex: "#B22222"),
    NG_Color_Button_Shadow_Highlighted               : Color(hex: "#2B1212"),
    NG_Color_Button_Glare_Highlighted                : Color(hex: "#FF8888"),
    NG_Color_Button_Border_Dark_Highlighted          : Color(hex: "#8A1F1F"),
    NG_Color_Button_Border_Bright_Highlighted        : Color(hex: "#FF6B6B"),
    NG_Color_Button_Text_Highlighted                 : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_DatePicker                : Color(hex: "#2C3A4A"),
    NG_Color_Button_Background_BottomRight_DatePicker            : Color(hex: "#1A2430"),
    NG_Color_Button_Shadow_DatePicker                            : Color(hex: "#151B24"),
    NG_Color_Button_Glare_DatePicker                             : Color(hex: "#495A6C"),
    NG_Color_Button_Border_Dark_DatePicker                       : Color(hex: "#151B24"),
    NG_Color_Button_Border_Bright_DatePicker                     : Color(hex: "#495A6C"),
    NG_Color_Button_Text_DatePicker                              : Color(hex: "#E5E9EF"),
   
    NG_Color_Button_Background_TopLeft_Skipped                : Color(hex: "#2F333B"),
    NG_Color_Button_Background_BottomRight_Skipped            : Color(hex: "#1A1E25"),
    NG_Color_Button_Shadow_Skipped                            : Color(hex: "#111418"),
    NG_Color_Button_Glare_Skipped                             : Color(hex: "#3D434B"),
    NG_Color_Button_Border_Dark_Skipped                       : Color(hex: "#12161B"),
    NG_Color_Button_Border_Bright_Skipped                     : Color(hex: "#5A626B"),
    NG_Color_Button_Text_Skipped                              : Color(hex: "#E0E3E7"),
   
    NG_Color_Button_Background_TopLeft_Easy                : Color(hex: "#2A4F54"),
    NG_Color_Button_Background_BottomRight_Easy            : Color(hex: "#1B383D"),
    NG_Color_Button_Shadow_Easy                            : Color(hex: "#102225"),
    NG_Color_Button_Glare_Easy                             : Color(hex: "#4D9BA3"),
    NG_Color_Button_Border_Dark_Easy                       : Color(hex: "#183338"),
    NG_Color_Button_Border_Bright_Easy                     : Color(hex: "#4D9BA3"),
    NG_Color_Button_Text_Easy                              : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Normal                : Color(hex: "#2A4D2D"),
    NG_Color_Button_Background_BottomRight_Normal            : Color(hex: "#1C3920"),
    NG_Color_Button_Shadow_Normal                            : Color(hex: "#102A1C"),
    NG_Color_Button_Glare_Normal                             : Color(hex: "#78E08F"),
    NG_Color_Button_Border_Dark_Normal                       : Color(hex: "#12391F"),
    NG_Color_Button_Border_Bright_Normal                     : Color(hex: "#3DDC84"),
    NG_Color_Button_Text_Normal                              : Color(hex: "#FFFFFF"),
   
    NG_Color_Button_Background_TopLeft_Hard                : Color(hex: "#5A1C1C"),
    NG_Color_Button_Background_BottomRight_Hard            : Color(hex: "#3C1010"),
    NG_Color_Button_Shadow_Hard                            : Color(hex: "#2B1212"),
    NG_Color_Button_Glare_Hard                             : Color(hex: "#993333"),
    NG_Color_Button_Border_Dark_Hard                       : Color(hex: "#260808"),
    NG_Color_Button_Border_Bright_Hard                     : Color(hex: "#FF6B6B"),
    NG_Color_Button_Text_Hard                              : Color(hex: "#FFFFFF"),
   
   //  Colors for date picker
   //  options:
   //      only one option
   //  values:
   //      Background
   //      Foreground
   
    NG_Color_DatePicker_Background                               : Color(hex: "#1E232C"),
    NG_Color_DatePicker_Foreground                               : Color(hex: "#E0E6ED"),
   
   //  Colors for icon
   //  options:
   //      Red
   //      Green
   //      Regular
   //      Disabled
   //  values:
   //      TopLeft background
   //      BottomRight background
   //      Glare
   //      Icon color
   
    NG_Color_Icon_TopLeft_Red                                    : Color(hex: "#FF8A8A"),
    NG_Color_Icon_BottomRight_Red                                : Color(hex: "#FF5252"),
    NG_Color_Icon_Glare_Red                                      : Color(hex: "#FFB3B3"),
   
    NG_Color_Icon_TopLeft_Green                                  : Color(hex: "#8AFF8A"),
    NG_Color_Icon_BottomRight_Green                              : Color(hex: "#52FF52"),
    NG_Color_Icon_Glare_Green                                    : Color(hex: "#B3FFB3"),
   
    NG_Color_Icon_TopLeft_Regular                                : Color(hex: "#D3D3D3"),
    NG_Color_Icon_BottomRight_Regular                            : Color(hex: "#A9A9A9"),
    NG_Color_Icon_Glare_Regular                                  : Color(hex: "#C0C0C0"),
   
    NG_Color_Icon_TopLeft_Disabled                               : Color(hex: "#8AAFFF"),
    NG_Color_Icon_BottomRight_Disabled                           : Color(hex: "#5277FF"),
    NG_Color_Icon_Glare_Disabled                                 : Color(hex: "#B3CFFF"),
   
   //  Colors for list rows
   //  options:
   //      Top
   //      Top highlighted
   //      Second
   //      Second highlighted
   //  values:
   //      TopLeft background
   //      BottomRight background
   //      Text color
   
    NG_Color_ListRow_Separator                                   : Color(hex: "#1F242B"),
   
    NG_Color_ListRow_Background_TopLeft_Top                      : Color(hex: "#2A2F37"),
    NG_Color_ListRow_Background_BottomRight_Top                  : Color(hex: "#1A1E25"),
    NG_Color_ListRow_Text_Top                                    : Color(hex: "#E6E9ED"),
   
    NG_Color_ListRow_Background_TopLeft_Top_Highlighted          : Color(hex: "#3A4F2D"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted      : Color(hex: "#284023"),
    NG_Color_ListRow_Text_Top_Highlighted                        : Color(hex: "#FFFFFF"),
   
    NG_Color_ListRow_Background_TopLeft_Second                   : Color(hex: "#1F232A"),
    NG_Color_ListRow_Background_BottomRight_Second               : Color(hex: "#15191F"),
    NG_Color_ListRow_Text_Second                                 : Color(hex: "#C8CDD4"),
   
    NG_Color_ListRow_Background_TopLeft_Second_Highlighted       : Color(hex: "#4F2D4F"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted   : Color(hex: "#3A1F3A"),
    NG_Color_ListRow_Text_Second_Highlighted                     : Color(hex: "#FFFFFF"),
   
   //  Colors for text field
   //  options:
   //      only one option
   //  values:
   //      background
   //      border
   //      inner shadow
   //      outer shadow
   //      text color
   
    NG_Color_TextField_Background                                : Color(hex: "#1F232A"),
    NG_Color_TextField_Border                                    : Color(hex: "#3D434B"),
         NG_Color_TextField_InnerShadow                               : Color(hex: "#2A2F37"),
    NG_Color_TextField_OuterGlare                                : Color(hex: "#5A1C1C"),
    NG_Color_TextField_Text                                      : Color(hex: "#F0F2F5"),
   
   //  Colors for selector
   //  options:
   //      only one option
   //  values:
   //      selected background
   //      regular background
   //      text selected
   //      text normal
   
    NG_Color_Selector_selectedSegmentTintColor                   : Color(hex: "#5A5A5A"),
    NG_Color_Selector_backgroundColor                            : Color(hex: "#2B2B2B"),
    NG_Color_Selector_text_selected                              : Color(hex: "#FFFFFF"),
    NG_Color_Selector_text_normal                                : Color(hex: "#AAAAAA"),
   
   //  Colors for checkbox
   //  options:
   //      selected
   //      not selected
   //  values:
   //      tint
   //      glare
   
    NG_Color_Checkbox_selectedTintColor                          : Color(hex: "#3DDC84"),
    NG_Color_Checkbox_selectedGlare                              : Color(hex: "#78E08F"),
   
    NG_Color_Checkbox_notSelectedTintColor                       : Color(hex: "#3D434B"),
    NG_Color_Checkbox_notSelectedGlare                           : Color(hex: "#1A1D24"),
   
   //  Colors for grids
   //  options:
   //      master header
   //      sub header
   //      rows
   //  values:
   //      background
   //      text
   
    NG_Color_Grid_MasterHeader_Background : Color(hex: "#2B2F36"),
    NG_Color_Grid_MasterHeader_Text       : Color(hex: "#F0F2F5"),
   
    NG_Color_Grid_SubHeader_Background   : Color(hex: "#1F232A"),
    NG_Color_Grid_SubHeader_Text         : Color(hex: "#D0D4DB"),
   
    NG_Color_Grid_Rows_Background        : Color(hex: "#15191F"),
    NG_Color_Grid_Rows_Text              : Color(hex: "#C0C4CC")
)

let theme_herren_bright = NG_Theme(
    themeStyle : Theme_Style.herren,
    themeOption : Theme_Option.bright,
    
    NG_Color_Page_Background_Top: Color(hex: "#E8ECF1"),       // светлый аналог #1B2129
    NG_Color_Page_Background_Bottom: Color(hex: "#DCE0E6"),    // светлый аналог #0F131A
        
    NG_Color_Text_Regular_Text: Color(hex: "#2B323A"),
    NG_Color_Text_Regular_Shadow: Color(hex: "#BFC5CD"),
    NG_Color_Text_Regular_Glare: Color(hex: "#8E99A5"),

    NG_Color_Text_Red_Text: Color(hex: "#4B5A68"),
    NG_Color_Text_Red_Shadow: Color(hex: "#CAD1D8"),
    NG_Color_Text_Red_Glare: Color(hex: "#7A8B9C"),

    NG_Color_Text_Green_Text: Color(hex: "#3D6B73"),
    NG_Color_Text_Green_Shadow: Color(hex: "#C2D9DD"),
    NG_Color_Text_Green_Glare: Color(hex: "#73B7C1"),

    NG_Color_Text_Disabled_Text: Color(hex: "#A4AAB2"),
    NG_Color_Text_Disabled_Shadow: Color(hex: "#E3E6EA"),
    NG_Color_Text_Disabled_Glare: Color(hex: "#CBD1D8"),

    NG_Color_Text_AppWizard_Text: Color(hex: "#4976A6"),
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#C7D6E8"),
    NG_Color_Text_AppWizard_Glare: Color(hex: "#7DA9DB"),
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#E3E6EA"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#C5C9D0"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#9AA0A8"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#B0B5BB"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#D1D5DB"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#D8E2F4"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#C5D0E2"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#6A89B8"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#A8B7CC"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#C3D1E6"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#E6D6D6"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#D4BEBE"),
    NG_Color_Card_Shadow_Red: Color(hex: "#B89A9A"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#C0A0A0"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#E2B8B8"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#D8E7E1"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#C4D7CE"),
    NG_Color_Card_Shadow_Green: Color(hex: "#A5C5B7"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#B0D0C0"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#ADD8E0"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#D6EAD9"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#C4DACB"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#A3C5AC"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#B5D8B7"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#92CBA6"),

    // In Progress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#D7E3F2"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#C5D3E5"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#9BB2CC"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#B0C7DA"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#A5C5F0"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#ADD8E0"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#E4D4D4"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#D6C4C4"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#C4A5A5"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#CBB3B3"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#D8B8B8"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#D5E4F2"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#C4D4E5"),
    NG_Color_Card_Shadow_Future: Color(hex: "#9CB4CC"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#A8C2DA"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#B0CCE6"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#D7E3F2"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#C5D3E5"),
    NG_Color_Card_Shadow_Today: Color(hex: "#9BB2CC"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#B0C7DA"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#A5C5F0"),

    // Not Started
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#D3D7DD"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#C1C8D0"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#A9AFB7"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#B8BCC5"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#D1D5DB"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#E3E6EA"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#C5C9D0"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#9AA0A8"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#B0B5BB"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#C8CCD2"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#D1E4E8"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#BED3D8"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#9FC5CC"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#A9D0D5"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#ADD8E0"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#D8E7DA"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#C5D7C7"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#A5C5A7"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#B5D8B7"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#B8EAC8"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#E6D6D6"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#D4BEBE"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#B89A9A"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#C0A0A0"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#E19999"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#B8CCFF"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#8AADFF"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#6A8ACC"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#5A7ACC"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#A5C8FF"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#D9E2F0"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#B5BEC9"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#A0A8B3"),
    NG_Color_Button_Glare_Regular: Color(hex: "#A5C5F0"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#B0B7C0"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#A5C5F0"),
    NG_Color_Button_Text_Regular: Color(hex: "#1A1D24"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#E3C1C1"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#D1B0B0"),
    NG_Color_Button_Shadow_Red: Color(hex: "#C0A0A0"),
    NG_Color_Button_Glare_Red: Color(hex: "#D6A0A0"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#B88A8A"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#E2B4B4"),
    NG_Color_Button_Text_Red: Color(hex: "#12161B"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#C0E2CF"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#A0D1B8"),
    NG_Color_Button_Shadow_Green: Color(hex: "#90C0A8"),
    NG_Color_Button_Glare_Green: Color(hex: "#78E0B7"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#99C9B0"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#8DD8B7"),
    NG_Color_Button_Text_Green: Color(hex: "#121820"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#D8E2F4"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#C4D0E2"),
    NG_Color_Button_Shadow_Service: Color(hex: "#A5B2C0"),
    NG_Color_Button_Glare_Service: Color(hex: "#A5C5F0"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#A5B0C0"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#A5C5F0"),
    NG_Color_Button_Text_Service: Color(hex: "#1A1D24"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#CDD2D8"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#B5BEC9"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#A0A5AD"),
    NG_Color_Button_Glare_Disabled: .clear,
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#A5ADB5"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#C8D0D8"),
    NG_Color_Button_Text_Disabled: Color(hex: "#878F97"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#A5C5F0"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#7FA8D1"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#6A7380"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#BDD6F7"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#9CB4CC"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#BDD6F7"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#121820"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#D9E2F0"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#C5D0E2"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#A8B5C0"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#A5C5F0"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#A8B5C0"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#A5C5F0"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#1A1D24"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#E3E6EA"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#C5C9D0"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#9AA0A8"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#C8CCD2"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#B0B5BB"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#C8CCD2"),
    NG_Color_Button_Text_Skipped: Color(hex: "#3D434B"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#C8E7EC"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#B0D7DB"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#90C0C5"),
    NG_Color_Button_Glare_Easy: Color(hex: "#A5E0E7"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#A0D0D5"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#A5E0E7"),
    NG_Color_Button_Text_Easy: Color(hex: "#121820"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#D8E7DA"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#C5D7C7"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#A5C5A7"),
    NG_Color_Button_Glare_Normal: Color(hex: "#78E08F"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#A5D0B0"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#8FDCA0"),
    NG_Color_Button_Text_Normal: Color(hex: "#121820"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#E6D6D6"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#D4BEBE"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#B89A9A"),
    NG_Color_Button_Glare_Hard: Color(hex: "#D6A0A0"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#C0A0A0"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#E19999"),
    NG_Color_Button_Text_Hard: Color(hex: "#121820"),
   
    // DatePicker
    NG_Color_DatePicker_Background: Color(hex: "#EEF1F6"),
    NG_Color_DatePicker_Foreground: Color(hex: "#1A1D24"),

    // Icons
    NG_Color_Icon_TopLeft_Red: Color(hex: "#D67A7A"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#B85555"),
    NG_Color_Icon_Glare_Red: Color(hex: "#E8A0A0"),

    NG_Color_Icon_TopLeft_Green: Color(hex: "#7FDBA9"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#52C98A"),
    NG_Color_Icon_Glare_Green: Color(hex: "#A4EEC5"),

    NG_Color_Icon_TopLeft_Regular: Color(hex: "#C5CAD0"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#B0B6BD"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#D8DCE2"),

    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#A0B8E0"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#7A99CC"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#C5D6F0"),

    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#D5D9DE"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#EEF1F6"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#DDE2EA"),
    NG_Color_ListRow_Text_Top: Color(hex: "#1A1D24"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#B5C7DB"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#9AB0C6"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#12161B"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#E5E8ED"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#D5D9DE"),
    NG_Color_ListRow_Text_Second: Color(hex: "#2A2F37"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#A8BACF"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#90A4BA"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#12161B"),

    // TextField
    NG_Color_TextField_Background: Color(hex: "#F2F4F8"),
    NG_Color_TextField_Border: Color(hex: "#B0B6BD"),
    NG_Color_TextField_InnerShadow: Color(hex: "#D8DCE2"),
    NG_Color_TextField_OuterGlare: Color(hex: "#A5C5F0"),
    NG_Color_TextField_Text: Color(hex: "#1A1D24"),

    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#C5CAD0"),
    NG_Color_Selector_backgroundColor: Color(hex: "#EEF1F6"),
    NG_Color_Selector_text_selected: Color(hex: "#12161B"),
    NG_Color_Selector_text_normal: Color(hex: "#7A7F87"),

    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#78E08F"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#A0EDBF"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#C0C6CC"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#D8DCE2"),

    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#D5D9DE"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#1A1D24"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#EEF1F6"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#2A2F37"),

    NG_Color_Grid_Rows_Background: Color(hex: "#F5F7FA"),
    NG_Color_Grid_Rows_Text: Color(hex: "#3D434B"),
)

let theme_herren_dark = NG_Theme(
    themeStyle : Theme_Style.herren,
    themeOption : Theme_Option.dark,
    
    NG_Color_Page_Background_Top: Color(hex: "#1B2129"),
    NG_Color_Page_Background_Bottom: Color(hex: "#0F131A"),
        
    NG_Color_Text_Regular_Text: Color(hex: "#DDE3EA"),
    NG_Color_Text_Regular_Shadow: Color(hex: "#12161B"),
    NG_Color_Text_Regular_Glare: Color(hex: "#6A7380"),

    NG_Color_Text_Red_Text: Color(hex: "#7C90A0"),
    NG_Color_Text_Red_Shadow: Color(hex: "#12161B"),
    NG_Color_Text_Red_Glare: Color(hex: "#A8BBCB"),

    NG_Color_Text_Green_Text: Color(hex: "#669BA5"),
    NG_Color_Text_Green_Shadow: Color(hex: "#122327"),
    NG_Color_Text_Green_Glare: Color(hex: "#9FD4DD"),

    NG_Color_Text_Disabled_Text: Color(hex: "#5A6068"),
    NG_Color_Text_Disabled_Shadow: Color(hex: "#1C1F25"),
    NG_Color_Text_Disabled_Glare: Color(hex: "#3D434B"),

    NG_Color_Text_AppWizard_Text: Color(hex: "#7EA9D6"),
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#1D2733"),
    NG_Color_Text_AppWizard_Glare: Color(hex: "#A5C8F0"),
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#2A2E34"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#161A20"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#000000"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#12161B"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#3D434B"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#2D3B4C"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#1A2330"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#3A5A8A"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#101520"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#6A89B8"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#3B2B2B"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#2A1B1B"),
    NG_Color_Card_Shadow_Red: Color(hex: "#4D3333"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#1A1010"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#7C4A4A"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#2A3D34"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#1C2A24"),
    NG_Color_Card_Shadow_Green: Color(hex: "#2F4F3C"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#12241C"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#4D9BA3"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#1A2F24"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#13201A"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#1F3C2F"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#0D1813"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#2C6048"),

    // In Progress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#1A2A3A"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#121F2A"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#1F2E38"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#101C24"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#547DA8"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#4D9BA3"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#302222"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#221818"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#4F1E1E"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#1A1010"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#704848"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#1C2F3B"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#12232F"),
    NG_Color_Card_Shadow_Future: Color(hex: "#1F3C50"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#0F1D26"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#3C6A8A"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#1A2A3A"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#121F2F"),
    NG_Color_Card_Shadow_Today: Color(hex: "#1F2E48"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#101A24"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#547DA8"),

    // Not Started
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#464D56"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#303A45"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#3D434B"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#232A33"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#6A737B"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#2A2E34"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#161A20"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#111418"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#12161B"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#4A535B"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#24484F"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#183338"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#102225"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#183338"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#4D9BA3"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#2A3D2D"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#1C2A20"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#12281C"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#12391F"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#3DDC84"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#3B2A2A"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#291A1A"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#2B1212"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#1A0C0C"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#993333"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#5588FF"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#3366CC"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#1A2A4F"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#0F1A3A"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#5C8BFF"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#2C3A4A"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#182230"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#0F141A"),
    NG_Color_Button_Glare_Regular: Color(hex: "#547DA8"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#121820"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#547DA8"),
    NG_Color_Button_Text_Regular: Color(hex: "#E0E6ED"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#4A2A2A"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#2A1A1A"),
    NG_Color_Button_Shadow_Red: Color(hex: "#1A1010"),
    NG_Color_Button_Glare_Red: Color(hex: "#804040"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#261010"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#A85454"),
    NG_Color_Button_Text_Red: Color(hex: "#F0F2F5"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#2A4F3A"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#1B3826"),
    NG_Color_Button_Shadow_Green: Color(hex: "#102218"),
    NG_Color_Button_Glare_Green: Color(hex: "#40A47A"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#12391F"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#3DDC84"),
    NG_Color_Button_Text_Green: Color(hex: "#E0E6ED"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#2D3B4C"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#1A2330"),
    NG_Color_Button_Shadow_Service: Color(hex: "#121820"),
    NG_Color_Button_Glare_Service: Color(hex: "#547DA8"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#10151F"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#547DA8"),
    NG_Color_Button_Text_Service: Color(hex: "#E0E6ED"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#40464D"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#2D333B"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#1C1F25"),
    NG_Color_Button_Glare_Disabled: .clear,
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#232A33"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#5A626B"),
    NG_Color_Button_Text_Disabled: Color(hex: "#7A838B"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#547DA8"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#3A5A8A"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#1A1D24"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#7FA8D1"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#1C2630"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#7FA8D1"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#F0F2F5"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#2C3A4A"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#1A2430"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#151B24"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#547DA8"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#151B24"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#547DA8"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#E5E9EF"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#2C2F34"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#16191D"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#111418"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#3D434B"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#12161B"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#4A535B"),
    NG_Color_Button_Text_Skipped: Color(hex: "#C0C4CC"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#24484F"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#1B383D"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#102225"),
    NG_Color_Button_Glare_Easy: Color(hex: "#4D9BA3"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#183338"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#4D9BA3"),
    NG_Color_Button_Text_Easy: Color(hex: "#F0F2F5"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#2A4D2D"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#1C3920"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#102A1C"),
    NG_Color_Button_Glare_Normal: Color(hex: "#40A47A"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#12391F"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#3DDC84"),
    NG_Color_Button_Text_Normal: Color(hex: "#E0E6ED"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#3B2A2A"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#291A1A"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#2B1212"),
    NG_Color_Button_Glare_Hard: Color(hex: "#804040"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#1A0C0C"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#993333"),
    NG_Color_Button_Text_Hard: Color(hex: "#F0F2F5"),
   
    // DatePicker
    NG_Color_DatePicker_Background: Color(hex: "#1B2128"),
    NG_Color_DatePicker_Foreground: Color(hex: "#DCE2EA"),

    // Icons
    NG_Color_Icon_TopLeft_Red: Color(hex: "#B85555"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#8A3939"),
    NG_Color_Icon_Glare_Red: Color(hex: "#D67A7A"),

    NG_Color_Icon_TopLeft_Green: Color(hex: "#52C98A"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#3A9C66"),
    NG_Color_Icon_Glare_Green: Color(hex: "#7FDBA9"),

    NG_Color_Icon_TopLeft_Regular: Color(hex: "#B0B6BD"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#8C9399"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#C5CAD0"),

    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#7A99CC"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#4A70AA"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#A0B8E0"),

    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#262B33"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#1E242C"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#12161C"),
    NG_Color_ListRow_Text_Top: Color(hex: "#E0E6ED"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#2B3F4D"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#1D2F3A"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#FFFFFF"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#1A1E25"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#101419"),
    NG_Color_ListRow_Text_Second: Color(hex: "#C0C6CC"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#35445A"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#243447"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#FFFFFF"),

    // TextField
    NG_Color_TextField_Background: Color(hex: "#1A1E24"),
    NG_Color_TextField_Border: Color(hex: "#3A424B"),
    NG_Color_TextField_InnerShadow: Color(hex: "#20242B"),
    NG_Color_TextField_OuterGlare: Color(hex: "#3A5A8A"),
    NG_Color_TextField_Text: Color(hex: "#E0E6ED"),

    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#3A3F47"),
    NG_Color_Selector_backgroundColor: Color(hex: "#1E2127"),
    NG_Color_Selector_text_selected: Color(hex: "#FFFFFF"),
    NG_Color_Selector_text_normal: Color(hex: "#7A7F87"),

    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#3DDC84"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#78E08F"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#3D434B"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#1A1D24"),

    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#262B33"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#F0F2F5"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#1A1E24"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#C0C6CC"),

    NG_Color_Grid_Rows_Background: Color(hex: "#101419"),
    NG_Color_Grid_Rows_Text: Color(hex: "#B0B6BD"),
)

let theme_frauen_bright = NG_Theme(
    themeStyle : Theme_Style.frauen,
    themeOption : Theme_Option.bright,
    
    NG_Color_Page_Background_Top: Color(hex: "#FFEAF1"),    // Светлый сливочно-розовый
    NG_Color_Page_Background_Bottom: Color(hex: "#FFD6E3"), // Мягкий розовый
        
    // Тексты для светлой розовой темы
    NG_Color_Text_Regular_Text: Color(hex: "#4A2D3E"),   // Глубокий розово-сливочный для текста
    NG_Color_Text_Regular_Shadow: Color(hex: "#D8B7C8"), // Лёгкая сиреневая тень для светлой темы
    NG_Color_Text_Regular_Glare: Color(hex: "#FFD8E0"),  // Блик оставляем

    NG_Color_Text_Red_Text: Color(hex: "#B33666"),       // Более сочный малиново-розовый для светлого фона
    NG_Color_Text_Red_Shadow: Color(hex: "#EAC2DF"),     // Мягкая розовая тень
    NG_Color_Text_Red_Glare: Color(hex: "#F4C7D3"),      // Блик оставить

    NG_Color_Text_Green_Text: Color(hex: "#AA7D9B"),     // Сиреневый, приглушённый под светлую гамму
    NG_Color_Text_Green_Shadow: Color(hex: "#EBCEDF"),   // Лёгкая подсветка для тени
    NG_Color_Text_Green_Glare: Color(hex: "#F5D6E6"),    // Чуть усиленный бликовый оттенок

    NG_Color_Text_Disabled_Text: Color(hex: "#C7ABB9"),  // Оставляем: бледно-розовый подходит
    NG_Color_Text_Disabled_Shadow: Color(hex: "#EBCEDF"),// Светлая сиреневая тень
    NG_Color_Text_Disabled_Glare: Color(hex: "#FFFFFF"), // Чистый светлый блик для выключенных

    NG_Color_Text_AppWizard_Text: Color(hex: "#B33666"),   // Более яркий ягодно-розовый под светлый фон
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#EBCEDF"), // Светлая сиреневая тень
    NG_Color_Text_AppWizard_Glare: Color(hex: "#FFD8E0"),  // Оставляем
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
    
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#FFFFFF"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#FFEAF1"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#FFD6E3"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#FFC1CF"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#EAC2CF"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#FFD8E0"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#FFE5EC"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#FFC2D0"),
    NG_Color_Card_Shadow_Red: Color(hex: "#F4C7D3"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#FFD8E0"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#FAE2F1"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#F2D1E4"),
    NG_Color_Card_Shadow_Green: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#F5D6E6"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#F4D8E4"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#EBCEDF"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#D8B7C8"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#C7ABB9"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#F2D1E4"),

    // In Progress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#FFE5EC"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#FFD8E0"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#F2D1E4"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#FFE5EC"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#FFC2D0"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#F4C7D3"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#F7A8C0"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#FAE2F1"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#F2D1E4"),
    NG_Color_Card_Shadow_Future: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#F5D6E6"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#FFC1CF"),
    NG_Color_Card_Shadow_Today: Color(hex: "#EAC2CF"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#FFD8E0"),

    // Not Started
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#FFFFFF"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#FFEAF1"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#FFD6E3"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#FFFFFF"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#FFEAF1"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#FFD6E3"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#FFFFFF"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#FFEAF1"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#FFD6E3"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#FFC1CF"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#EAC2CF"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#FFD8E0"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#F4B4C8"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#E39AAE"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#D68FA1"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#B36A7F"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#FFD8E0"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#FFC1CF"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#EAC2CF"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#D6A5B6"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#FFD8E0"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#FFFFFF"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#FFEAF1"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#EBCEDF"),
    NG_Color_Button_Glare_Regular: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#EBCEDF"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_Regular: Color(hex: "#5C4A54"),


    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#FFE5EC"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#FFC2D0"),
    NG_Color_Button_Shadow_Red: Color(hex: "#F4C7D3"),
    NG_Color_Button_Glare_Red: Color(hex: "#FFCEDD"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#D68FA1"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Red: Color(hex: "#5C4A54"),


    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#FAE2F1"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#F2D1E4"),
    NG_Color_Button_Shadow_Green: Color(hex: "#EBCEDF"),
    NG_Color_Button_Glare_Green: Color(hex: "#EAC2DF"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#F5D6E6"),
    NG_Color_Button_Text_Green: Color(hex: "#5C4A54"),


    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#FAE2F1"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#F2D1E4"),
    NG_Color_Button_Shadow_Service: Color(hex: "#EBCEDF"),
    NG_Color_Button_Glare_Service: Color(hex: "#F7E2EE"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Service: Color(hex: "#5C4A54"),


    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#F7EEF3"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#ECD8E2"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#E0C9D6"),
    NG_Color_Button_Glare_Disabled: Color(hex: "#EBD5E0"),
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#EAD3DF"),
    NG_Color_Button_Text_Disabled: Color(hex: "#C7ABB9"),


    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#FFE5EC"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#FFC1CF"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#EAC2CF"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#5C4A54"),


    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#FFFFFF"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#FFEAF1"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#EBCEDF"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#EBCEDF"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#5C4A54"),


    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#FFFFFF"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#FFEAF1"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#EBCEDF"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#EAD3DF"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_Skipped: Color(hex: "#5C4A54"),


    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#FFFFFF"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#FFEAF1"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#EBCEDF"),
    NG_Color_Button_Glare_Easy: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_Easy: Color(hex: "#5C4A54"),


    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#FFE5EC"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#FFC1CF"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#EAC2CF"),
    NG_Color_Button_Glare_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#D6A5B6"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Normal: Color(hex: "#5C4A54"),


    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#F7C2D6"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#E8A6B9"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#D68FA1"),
    NG_Color_Button_Glare_Hard: Color(hex: "#F7A8C0"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#B36A7F"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Hard: Color(hex: "#5C4A54"),
        
    // DatePicker
    NG_Color_DatePicker_Background: Color(hex: "#FFFFFF"),
    NG_Color_DatePicker_Foreground: Color(hex: "#5C4A54"),


    // Red Icon
    NG_Color_Icon_TopLeft_Red: Color(hex: "#FFD4E0"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#F2B2C2"),
    NG_Color_Icon_Glare_Red: Color(hex: "#FFE5EC"),


    // Green Icon (в сиреневый уходящий)
    NG_Color_Icon_TopLeft_Green: Color(hex: "#F7E1ED"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#EAC2DF"),
    NG_Color_Icon_Glare_Green: Color(hex: "#FCE9F2"),


    // Regular Icon
    NG_Color_Icon_TopLeft_Regular: Color(hex: "#FFEAF1"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#F5D6E3"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#FFF0F5"),


    // Disabled Icon
    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#F8E4ED"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#E6C3D4"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#F2DCE7"),


    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#D6B3C9"),


    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#FFEAF1"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#FFD6E3"),
    NG_Color_ListRow_Text_Top: Color(hex: "#5C4A54"),


    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#FFB6C1"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#5C4A54"),


    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#FFEAF1"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#FFD6E3"),
    NG_Color_ListRow_Text_Second: Color(hex: "#5C4A54"),


    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#FFB6C1"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#5C4A54"),


    // TextField
    NG_Color_TextField_Background: Color(hex: "#FFFFFF"),
    NG_Color_TextField_Border: Color(hex: "#D6B3C9"),
    NG_Color_TextField_InnerShadow: Color(hex: "#EAD3DF"),
    NG_Color_TextField_OuterGlare: Color(hex: "#FFD8E0"),
    NG_Color_TextField_Text: Color(hex: "#5C4A54"),


    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#FFD8E0"),
    NG_Color_Selector_backgroundColor: Color(hex: "#FFFFFF"),
    NG_Color_Selector_text_selected: Color(hex: "#5C4A54"),
    NG_Color_Selector_text_normal: Color(hex: "#BDA6B6"),


    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#D68FA1"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#F2C3D4"),


    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#EBCEDF"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#FFEAF1"),


    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#FFD8E0"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#5C4A54"),


    NG_Color_Grid_SubHeader_Background: Color(hex: "#FFE5EC"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#5C4A54"),


    NG_Color_Grid_Rows_Background: Color(hex: "#FFFFFF"),
    NG_Color_Grid_Rows_Text: Color(hex: "#5C4A54")
)

let theme_frauen_dark = NG_Theme(
    themeStyle : Theme_Style.frauen,
    themeOption : Theme_Option.dark,
    
    NG_Color_Page_Background_Top: Color(hex: "#4A2D3E"),    // Тёмный сливочно-розовый
    NG_Color_Page_Background_Bottom: Color(hex: "#341F2D"), // Глубокий бордово-розовый
        
    // Тексты для настоящей тёмной розовой темы
    NG_Color_Text_Regular_Text: Color(hex: "#7A5E6D"),   // Глубокий приглушённый розовый-пыльный оттенок
    NG_Color_Text_Regular_Shadow: Color(hex: "#4A2D3E"), // Более плотная тень
    NG_Color_Text_Regular_Glare: Color(hex: "#FFD8E0"),  // Мягкий розовый блик можно оставить

    NG_Color_Text_Red_Text: Color(hex: "#F29BB7"),       // Яркий розовый текст
    NG_Color_Text_Red_Shadow: Color(hex: "#5C4A54"),
    NG_Color_Text_Red_Glare: Color(hex: "#F4C7D3"),

    NG_Color_Text_Green_Text: Color(hex: "#E3B4D8"),     // Переход в сиреневый
    NG_Color_Text_Green_Shadow: Color(hex: "#5C4A54"),
    NG_Color_Text_Green_Glare: Color(hex: "#EBCEDF"),

    NG_Color_Text_Disabled_Text: Color(hex: "#C7ABB9"),  // Бледно-розовый для выключенных
    NG_Color_Text_Disabled_Shadow: Color(hex: "#5C4A54"),
    NG_Color_Text_Disabled_Glare: Color(hex: "#EBCEDF"),

    NG_Color_Text_AppWizard_Text: Color(hex: "#83384C"),   // Глубокий ягодно-розовый, хорошо контрастирует
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#4A2D3E"), // Остался, так как хорошо подходит
    NG_Color_Text_AppWizard_Glare: Color(hex: "#FFD8E0"),  // Можно оставить, подчёркивает тему
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#FFEAF1"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#FFD6E3"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#C7ABB9"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#FFFFFF"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#FFB6C1"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#C78A99"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#B36A7F"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#FFD8E0"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#FAD1DA"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#F6B0C2"),
    NG_Color_Card_Shadow_Red: Color(hex: "#D68FA1"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#C26E84"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#FFCEDD"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#F4D0EA"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#E8B7D8"),
    NG_Color_Card_Shadow_Green: Color(hex: "#C99BB8"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#AA7D9B"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#EAC2DF"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#EED0E2"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#E3B7CD"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#C99BB8"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#A97A96"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#D8A8C2"),

    // In Progress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#FFD6E3"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#C7ABB9"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#B38A9E"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#FFD8E0"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#EAC2DF"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#FAD1DA"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#F6B0C2"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#D68FA1"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#C26E84"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#F7A8C0"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#F4D0EA"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#E8B7D8"),
    NG_Color_Card_Shadow_Future: Color(hex: "#C99BB8"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#AA7D9B"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#EAC2DF"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#FFB6C1"),
    NG_Color_Card_Shadow_Today: Color(hex: "#C78A99"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#B36A7F"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#FFD8E0"),

    // Not Started
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#FFEAF1"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#FFD6E3"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#C7ABB9"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#EBCEDF"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#FFFFFF"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#FFEAF1"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#FFD6E3"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#C7ABB9"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#BDA6B6"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#FFFFFF"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#FFEAF1"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#FFD6E3"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#C7ABB9"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#BDA6B6"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#FFFFFF"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#FFB6C1"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#C78A99"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#B36A7F"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#FFD8E0"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#F4B4C8"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#E39AAE"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#C17B90"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#A6647B"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#FFD8E0"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#FFB6C1"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#C78A99"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#B36A7F"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#FFD8E0"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#FFEAF1"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#FFD6E3"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#C7ABB9"),
    NG_Color_Button_Glare_Regular: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#BDA6B6"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_Regular: Color(hex: "#5C4A54"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#FAD1DA"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#F6B0C2"),
    NG_Color_Button_Shadow_Red: Color(hex: "#D68FA1"),
    NG_Color_Button_Glare_Red: Color(hex: "#FFCEDD"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#C26E84"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#FFCEDD"),
    NG_Color_Button_Text_Red: Color(hex: "#5C4A54"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#F4D0EA"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#E8B7D8"),
    NG_Color_Button_Shadow_Green: Color(hex: "#C99BB8"),
    NG_Color_Button_Glare_Green: Color(hex: "#EAC2DF"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#AA7D9B"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#EAC2DF"),
    NG_Color_Button_Text_Green: Color(hex: "#5C4A54"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#F8D8E8"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#EBCEDF"),
    NG_Color_Button_Shadow_Service: Color(hex: "#C7ABB9"),
    NG_Color_Button_Glare_Service: Color(hex: "#F7E2EE"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#C7ABB9"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Service: Color(hex: "#5C4A54"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#F2E2EB"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#E6CCD8"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#D6B3C9"),
    NG_Color_Button_Glare_Disabled: Color(hex: "#EBD5E0"),
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#C7ABB9"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#EAD3DF"),
    NG_Color_Button_Text_Disabled: Color(hex: "#D8C3D0"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#FFB6C1"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#C78A99"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#B36A7F"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#5C4A54"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#FFEAF1"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#FFD6E3"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#C7ABB9"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#BDA6B6"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#5C4A54"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#FFEAF1"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#FFD6E3"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#C7ABB9"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#EAD3DF"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#BDA6B6"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_Skipped: Color(hex: "#5C4A54"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#FFEAF1"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#FFD6E3"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#C7ABB9"),
    NG_Color_Button_Glare_Easy: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#BDA6B6"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#FFFFFF"),
    NG_Color_Button_Text_Easy: Color(hex: "#5C4A54"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#FFB6C1"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#C78A99"),
    NG_Color_Button_Glare_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#B36A7F"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Normal: Color(hex: "#5C4A54"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#F4B4C8"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#E39AAE"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#C17B90"),
    NG_Color_Button_Glare_Hard: Color(hex: "#F7A8C0"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#A6647B"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#FFD8E0"),
    NG_Color_Button_Text_Hard: Color(hex: "#5C4A54"),
        
    // DatePicker
    NG_Color_DatePicker_Background: Color(hex: "#FFEAF1"),
    NG_Color_DatePicker_Foreground: Color(hex: "#5C4A54"),

    // Red Icon
    NG_Color_Icon_TopLeft_Red: Color(hex: "#F8B7C8"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#E59AAC"),
    NG_Color_Icon_Glare_Red: Color(hex: "#FFD4E0"),

    // Green Icon
    NG_Color_Icon_TopLeft_Green: Color(hex: "#E9BDD9"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#D29EBC"),
    NG_Color_Icon_Glare_Green: Color(hex: "#F2D1E4"),

    // Regular Icon
    NG_Color_Icon_TopLeft_Regular: Color(hex: "#F1D9E4"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#D8B7C8"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#F5E1EB"),

    // Disabled Icon
    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#EED9E4"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#CFA9BD"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#E6C3D4"),

    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#9D7E8D"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#5C4A54"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#4A3A41"),
    NG_Color_ListRow_Text_Top: Color(hex: "#FFEAF1"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#7A5E6D"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#624857"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#FFEAF1"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#4A3A41"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#3A2C32"),
    NG_Color_ListRow_Text_Second: Color(hex: "#FFD6E3"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#624857"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#503B46"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#FFD6E3"),

    // TextField
    NG_Color_TextField_Background: Color(hex: "#4A3A41"),
    NG_Color_TextField_Border: Color(hex: "#6E5A66"),
    NG_Color_TextField_InnerShadow: Color(hex: "#3A2C32"),
    NG_Color_TextField_OuterGlare: Color(hex: "#7A5E6D"),
    NG_Color_TextField_Text: Color(hex: "#FFEAF1"),

    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#7A5E6D"),
    NG_Color_Selector_backgroundColor: Color(hex: "#4A3A41"),
    NG_Color_Selector_text_selected: Color(hex: "#FFEAF1"),
    NG_Color_Selector_text_normal: Color(hex: "#BDA6B6"),

    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#B36A7F"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#D6A5B6"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#7A5E6D"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#4A3A41"),

    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#B36A7F"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#FFEAF1"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#7A5E6D"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#EBCEDF"),

    NG_Color_Grid_Rows_Background: Color(hex: "#5C4A54"),
    NG_Color_Grid_Rows_Text: Color(hex: "#EBCEDF")
)

let theme_cyberpunk_bright = NG_Theme(
    themeStyle : Theme_Style.cyberpunk,
    themeOption : Theme_Option.bright,
    
    NG_Color_Page_Background_Top: Color(hex: "#DDE6FF"),    // светлый голубовато-сиреневый верх
    NG_Color_Page_Background_Bottom: Color(hex: "#EAF0FF"), // почти белый с голубым оттенком
        
    // Regular
    NG_Color_Text_Regular_Text: Color(hex: "#003366"),       // насыщенный сине-неоновый для читаемости
    NG_Color_Text_Regular_Shadow: Color(hex: "#BBD6FF"),     // мягкая светлая тень
    NG_Color_Text_Regular_Glare: Color(hex: "#5A8BFF"),      // электро-голубой остаётся

    // Red
    NG_Color_Text_Red_Text: Color(hex: "#FF1A75"),           // насыщенно-розовый, с кислотным уклоном
    NG_Color_Text_Red_Shadow: Color(hex: "#FFB3D6"),         // мягкий розоватый ореол
    NG_Color_Text_Red_Glare: Color(hex: "#FF99CC"),          // сияющий розовый блик

    // Green
    NG_Color_Text_Green_Text: Color(hex: "#00BFA5"),         // ядреная лазурь, хорошо читается на светлом
    NG_Color_Text_Green_Shadow: Color(hex: "#A8FFF2"),       // яркое ореольное свечение
    NG_Color_Text_Green_Glare: Color(hex: "#66FFE4"),        // остался — идеально подчёркивает стиль

    // Disabled
    NG_Color_Text_Disabled_Text: Color(hex: "#94A5B8"),      // серо-голубой, читаемый, но явно неактивный
    NG_Color_Text_Disabled_Shadow: Color(hex: "#DDE4EF"),    // лёгкая голубая тень
    NG_Color_Text_Disabled_Glare: Color(hex: "#B8C6D8"),     // мягкий холодный блик

    // AppWizard
    NG_Color_Text_AppWizard_Text: Color(hex: "#CC0099"),     // чуть темнее, чтобы сохранять кислотный акцент на светлом
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#FFCCF2"),   // светлый ореол
    NG_Color_Text_AppWizard_Glare: Color(hex: "#FF99EE"),    // не трогаем — идеально
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#DCEBFF"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#C2D4FF"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#A3B5FF"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#B8C8FF"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#3740A3"), // контрастный синий

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#F3D2FF"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#E5B3FF"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#CC33FF"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#CE9BFF"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#FF33CC"), // сохраняем кислоту

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#FFD6E0"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#FFB3C7"),
    NG_Color_Card_Shadow_Red: Color(hex: "#FF6E9A"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#FFA8C6"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#FF4F7A"), // для пинка

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#C3FFF3"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#A3F7E5"),
    NG_Color_Card_Shadow_Green: Color(hex: "#66FFE4"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#99FFF0"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#00FFC3"), // яркая лазурь

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#D6F0FF"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#BEE3FF"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#3399FF"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#B5DAFF"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#3399FF"), // чистый голубой

    // InProgress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#E0D6FF"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#C5B3FF"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#7A5CFF"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#C5B3FF"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#7A5CFF"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#00FFC3"), // лазурный акцент

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#FFD0E5"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#F5B2D4"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#CC5588"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#F199BF"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#A23366"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#D6F0FF"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#BEE3FF"),
    NG_Color_Card_Shadow_Future: Color(hex: "#3399FF"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#A3D8FF"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#3399FF"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#E0D6FF"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#C5B3FF"),
    NG_Color_Card_Shadow_Today: Color(hex: "#7A5CFF"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#BBA8FF"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#5544FF"),

    // NotStarted
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#E9D9FF"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#D5C0FF"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#B399FF"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#D0BBFF"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#6B4DFF"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#DCEBFF"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#C2D4FF"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#A3B5FF"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#B5C9FF"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#3740A3"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#D6F8FF"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#B8EAF5"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#99E0FF"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#A3ECFF"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#3DDCFF"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#D6FFEB"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#BBF7D8"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#88FFD0"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#A0FFE2"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#00FFAA"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#FFD6E0"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#FFB3C7"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#FF5CA8"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#F099BB"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#FF77AA"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#FFB3F1"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#FF80E0"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#CC3399"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#AA2280"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#FF66E9"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#DAD9FF"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#B8B3FF"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#A3A0E6"),
    NG_Color_Button_Glare_Regular: Color(hex: "#6A4DFF"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#8C84FF"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#6A4DFF"),
    NG_Color_Button_Text_Regular: Color(hex: "#1B1033"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#FFB3CC"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#FF99B8"),
    NG_Color_Button_Shadow_Red: Color(hex: "#FF7FA3"),
    NG_Color_Button_Glare_Red: Color(hex: "#FF66A1"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#FF4F99"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#FF4F99"),
    NG_Color_Button_Text_Red: Color(hex: "#330518"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#A8FFEF"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#80FFE0"),
    NG_Color_Button_Shadow_Green: Color(hex: "#66CCB5"),
    NG_Color_Button_Glare_Green: Color(hex: "#33FFD9"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#00CCAA"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#00FFC3"),
    NG_Color_Button_Text_Green: Color(hex: "#00382E"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#E3D8FF"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#C6B3FF"),
    NG_Color_Button_Shadow_Service: Color(hex: "#B39EFF"),
    NG_Color_Button_Glare_Service: Color(hex: "#7A66FF"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#8C70FF"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#7A66FF"),
    NG_Color_Button_Text_Service: Color(hex: "#1A1033"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#E6E6F0"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#D0D0E0"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#C0C0D0"),
    NG_Color_Button_Glare_Disabled: .clear,
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#BBBBCC"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#DDDDFF"),
    NG_Color_Button_Text_Disabled: Color(hex: "#8888AA"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#FFB3F1"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#FF99E6"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#E652C2"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#1A102F"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#E3DBFF"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#C5B9FF"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#B0A0E6"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#7A5CFF"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#8C84FF"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#7A5CFF"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#1A1033"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#D9CCFF"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#BFAAFF"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#A690E6"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#A499FF"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#8A70FF"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#6B4DFF"),
    NG_Color_Button_Text_Skipped: Color(hex: "#1A0F2E"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#C6F5FF"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#B3EBFF"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#99D9FF"),
    NG_Color_Button_Glare_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#33BBDD"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Text_Easy: Color(hex: "#0A1C26"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#A6FFE3"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#80FFD1"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#66CCA6"),
    NG_Color_Button_Glare_Normal: Color(hex: "#40FFD4"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#00DDAA"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#00FFC3"),
    NG_Color_Button_Text_Normal: Color(hex: "#003D33"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#FFB3CC"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#FF99BA"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#FF77AA"),
    NG_Color_Button_Glare_Hard: Color(hex: "#FF5CA8"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#CC4488"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#FF77AA"),
    NG_Color_Button_Text_Hard: Color(hex: "#330518"),
   
    NG_Color_DatePicker_Background: Color(hex: "#E9E6FF"),
    NG_Color_DatePicker_Foreground: Color(hex: "#1A0F33"),

    // Icons
    NG_Color_Icon_TopLeft_Red: Color(hex: "#FF99C2"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#FF66A3"),
    NG_Color_Icon_Glare_Red: Color(hex: "#FFCCE0"),

    NG_Color_Icon_TopLeft_Green: Color(hex: "#99FFE9"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#66FFD9"),
    NG_Color_Icon_Glare_Green: Color(hex: "#CCFFF5"),

    NG_Color_Icon_TopLeft_Regular: Color(hex: "#C0C3FF"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#999CFF"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#E0E2FF"),

    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#D0C6F5"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#A89EE0"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#E6DDFF"),

    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#A399CC"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#F0EEFF"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#E1DEFF"),
    NG_Color_ListRow_Text_Top: Color(hex: "#1A0D33"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#FDD0FF"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#F5B8FF"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#1A0D33"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#EAE6FF"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#DAD3FF"),
    NG_Color_ListRow_Text_Second: Color(hex: "#3A2C66"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#F4CCFF"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#E3B3FF"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#1A0D33"),

    // TextField
    NG_Color_TextField_Background: Color(hex: "#F2EFFF"),
    NG_Color_TextField_Border: Color(hex: "#AA99FF"),
    NG_Color_TextField_InnerShadow: Color(hex: "#DAD3FF"),
    NG_Color_TextField_OuterGlare: Color(hex: "#FF99EE"),
    NG_Color_TextField_Text: Color(hex: "#1A0D33"),

    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#C6B3FF"),
    NG_Color_Selector_backgroundColor: Color(hex: "#ECE9FF"),
    NG_Color_Selector_text_selected: Color(hex: "#FF33CC"),
    NG_Color_Selector_text_normal: Color(hex: "#A088FF"),

    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#FF66E9"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#FFB3F1"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#B8B0DD"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#DDD9F5"),

    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#E9D6FF"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#1A0D33"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#F1E4FF"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#3A2C66"),

    NG_Color_Grid_Rows_Background: Color(hex: "#FAF8FF"),
    NG_Color_Grid_Rows_Text: Color(hex: "#1A0D33")
)

let theme_cyberpunk_dark = NG_Theme(
    themeStyle : Theme_Style.cyberpunk,
    themeOption : Theme_Option.dark,
    
    NG_Color_Page_Background_Top: Color(hex: "#050A1F"),    // тёмно-синий верх, почти космос
    NG_Color_Page_Background_Bottom: Color(hex: "#010512"), // глубокий чернильный низ
        
    NG_Color_Text_Regular_Text: Color(hex: "#B0C9FF"),       // холодный светло-голубой неон
    NG_Color_Text_Regular_Shadow: Color(hex: "#0A0F1F"),     // глубокая синяя тень
    NG_Color_Text_Regular_Glare: Color(hex: "#5A8BFF"),      // яркий электро-голубой блик

    NG_Color_Text_Red_Text: Color(hex: "#FF3F7F"),           // агрессивная кислотно-розовая
    NG_Color_Text_Red_Shadow: Color(hex: "#1A0614"),         // бордово-чёрная тень
    NG_Color_Text_Red_Glare: Color(hex: "#FF7FB3"),          // светлый неон-розовый

    NG_Color_Text_Green_Text: Color(hex: "#00FFC3"),         // яркий неон-лазурь
    NG_Color_Text_Green_Shadow: Color(hex: "#002F24"),       // тёмный изумрудный
    NG_Color_Text_Green_Glare: Color(hex: "#66FFE4"),        // лазурный светлый

    NG_Color_Text_Disabled_Text: Color(hex: "#6A7A8B"),      // холодный серо-синий
    NG_Color_Text_Disabled_Shadow: Color(hex: "#13161F"),    // сине-чёрная глубокая тень
    NG_Color_Text_Disabled_Glare: Color(hex: "#4A5A6B"),     // мягкий синий блик

    NG_Color_Text_AppWizard_Text: Color(hex: "#FF33CC"),     // чистая кислотная магента
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#19081A"),   // насыщенно-фиолетовая тень
    NG_Color_Text_AppWizard_Glare: Color(hex: "#FF99EE"),    // яркий неоновый блик
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#1A1B2F"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#0F1024"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#050518"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#0A0C1A"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#3740A3"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#311A4F"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#1E0D3F"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#B300FF"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#110828"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#FF33CC"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#7F1033"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#4D0A1F"),
    NG_Color_Card_Shadow_Red: Color(hex: "#BF2B55"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#1A0610"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#FF4F7A"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#10685A"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#0A4037"),
    NG_Color_Card_Shadow_Green: Color(hex: "#33FFD2"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#07322A"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#00FFC3"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#10455A"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#0A3040"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#3399FF"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#072633"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#3399FF"),

    // InProgress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#1A1B4D"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#0F1033"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#5544FF"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#0D0D33"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#7A5CFF"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#00FFC3"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#5A1040"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#330A26"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#A23366"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#1A0610"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#A23366"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#10455A"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#0A3040"),
    NG_Color_Card_Shadow_Future: Color(hex: "#3399FF"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#072633"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#3399FF"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#1A1B4D"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#0F1033"),
    NG_Color_Card_Shadow_Today: Color(hex: "#5544FF"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#0D0D33"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#5544FF"),

    // NotStarted
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#2E1A4D"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#1A0D3D"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#110A26"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#110C26"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#6B4DFF"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#1A1B2F"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#0F1024"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#0A0618"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#0A0D20"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#3740A3"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#10455A"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#0A3040"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#073244"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#07404F"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#3DDCFF"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#104D3A"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#0A3926"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#07331F"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#074429"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#00FFAA"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#7F1033"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#4D0A1F"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#330D1F"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#1A0610"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#FF5CA8"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#FF33CC"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#CC00AA"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#990066"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#660044"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#FF66E9"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#2A1B4D"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#1A0D3A"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#0A061F"),
    NG_Color_Button_Glare_Regular: Color(hex: "#6A4DFF"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#140D33"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#6A4DFF"),
    NG_Color_Button_Text_Regular: Color(hex: "#D0C9FF"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#991540"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#660A2A"),
    NG_Color_Button_Shadow_Red: Color(hex: "#330518"),
    NG_Color_Button_Glare_Red: Color(hex: "#FF66A1"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#330518"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#FF4F99"),
    NG_Color_Button_Text_Red: Color(hex: "#FFE5F0"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#00D6A6"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#008069"),
    NG_Color_Button_Shadow_Green: Color(hex: "#004D3D"),
    NG_Color_Button_Glare_Green: Color(hex: "#33FFD9"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#00534A"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#00FFC3"),
    NG_Color_Button_Text_Green: Color(hex: "#E0FFFB"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#382A6E"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#1F134A"),
    NG_Color_Button_Shadow_Service: Color(hex: "#0F0A26"),
    NG_Color_Button_Glare_Service: Color(hex: "#7A66FF"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#0D0A33"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#7A66FF"),
    NG_Color_Button_Text_Service: Color(hex: "#D0C9FF"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#403D5A"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#26243A"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#191729"),
    NG_Color_Button_Glare_Disabled: .clear,
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#2A2633"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#666080"),
    NG_Color_Button_Text_Disabled: Color(hex: "#8888AA"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#FF1ACC"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#B00088"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#660066"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#7A0070"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#FFFFFF"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#2A1B4D"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#140D33"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#0D0A26"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#7A5CFF"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#0D0A26"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#7A5CFF"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#E0D7FF"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#1A0D3A"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#0D061F"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#070414"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#554C9B"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#110A26"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#6B4DFF"),
    NG_Color_Button_Text_Skipped: Color(hex: "#C0BCFF"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#105A6E"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#0A3A4D"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#052633"),
    NG_Color_Button_Glare_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#0D394A"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Text_Easy: Color(hex: "#D0F5FF"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#10684D"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#0A4D33"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#05331F"),
    NG_Color_Button_Glare_Normal: Color(hex: "#40FFD4"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#074429"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#00FFC3"),
    NG_Color_Button_Text_Normal: Color(hex: "#E0FFEB"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#991540"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#660A2A"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#330518"),
    NG_Color_Button_Glare_Hard: Color(hex: "#FF5CA8"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#330518"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#FF77AA"),
    NG_Color_Button_Text_Hard: Color(hex: "#FFE5F0"),
   
    NG_Color_DatePicker_Background: Color(hex: "#140A26"),
    NG_Color_DatePicker_Foreground: Color(hex: "#C0BCFF"),

    // Icons
    NG_Color_Icon_TopLeft_Red: Color(hex: "#FF3380"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#B30059"),
    NG_Color_Icon_Glare_Red: Color(hex: "#FF66A3"),

    NG_Color_Icon_TopLeft_Green: Color(hex: "#00FFC3"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#00B58F"),
    NG_Color_Icon_Glare_Green: Color(hex: "#66FFE0"),

    NG_Color_Icon_TopLeft_Regular: Color(hex: "#8C8FFF"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#5558CC"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#AAAAFF"),

    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#7A66CC"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#4C3D99"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#A890FF"),

    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#33204D"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#1F1A3D"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#120D26"),
    NG_Color_ListRow_Text_Top: Color(hex: "#D0C9FF"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#400D66"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#29094D"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#FFFFFF"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#1C1A3A"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#100D26"),
    NG_Color_ListRow_Text_Second: Color(hex: "#B8A8FF"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#5C0DAA"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#400D7A"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#FFFFFF"),

    // TextField
    NG_Color_TextField_Background: Color(hex: "#1F1A3D"),
    NG_Color_TextField_Border: Color(hex: "#443377"),
    NG_Color_TextField_InnerShadow: Color(hex: "#120D26"),
    NG_Color_TextField_OuterGlare: Color(hex: "#FF66E9"),
    NG_Color_TextField_Text: Color(hex: "#D0C9FF"),

    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#7A4DFF"),
    NG_Color_Selector_backgroundColor: Color(hex: "#120D26"),
    NG_Color_Selector_text_selected: Color(hex: "#FF66E9"),
    NG_Color_Selector_text_normal: Color(hex: "#AA88FF"),

    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#FF66E9"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#FFB3F1"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#4A4077"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#1A1333"),

    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#29094D"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#FF66E9"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#1A0D33"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#DD99FF"),

    NG_Color_Grid_Rows_Background: Color(hex: "#100A26"),
    NG_Color_Grid_Rows_Text: Color(hex: "#C099FF"),
)

let theme_retrowave_bright = NG_Theme(
    themeStyle : Theme_Style.retrowave,
    themeOption : Theme_Option.bright,
    
    NG_Color_Page_Background_Top: Color(hex: "#EBD6FF"),    // светлый фиолетовый верх для ретро-вейва
    NG_Color_Page_Background_Bottom: Color(hex: "#D4C2F5"), // мягкий светлый фиолетовый низ
        
    NG_Color_Text_Regular_Text: Color(hex: "#4B3A71"),       // мягкий фиолетовый текст
    NG_Color_Text_Regular_Shadow: Color(hex: "#D3C8F5"),     // светлая фиолетовая тень
    NG_Color_Text_Regular_Glare: Color(hex: "#9787C8"),      // приглушённый светло-неоновый блик

    NG_Color_Text_Red_Text: Color(hex: "#B0206D"),           // глубокая ретро-розовая
    NG_Color_Text_Red_Shadow: Color(hex: "#F5D0E3"),         // нежная светлая тень
    NG_Color_Text_Red_Glare: Color(hex: "#FF99C8"),          // оставила тот же блик — он идеально подходит

    NG_Color_Text_Green_Text: Color(hex: "#1FB292"),         // свежая светлая бирюза
    NG_Color_Text_Green_Shadow: Color(hex: "#D2F6EC"),       // бледная бирюзовая тень
    NG_Color_Text_Green_Glare: Color(hex: "#84FFE2"),        // тоже оставила, он шикарный

    NG_Color_Text_Disabled_Text: Color(hex: "#A7A9B8"),      // мягкий серо-лавандовый
    NG_Color_Text_Disabled_Shadow: Color(hex: "#E3E5EC"),    // светло-серо-голубая тень
    NG_Color_Text_Disabled_Glare: Color(hex: "#C0C4D1"),     // нежный серо-голубой блик

    NG_Color_Text_AppWizard_Text: Color(hex: "#C63FA9"),     // яркая светлая магента
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#F6D6ED"),   // мягкая светлая тень
    NG_Color_Text_AppWizard_Glare: Color(hex: "#FFB3F1"),    // блик оставила — он в цвет
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Light,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Light,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#D8C7F0"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#C6B3E6"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#E9E2F7"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#B8A3D9"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#E3D7F7"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#E1B8F0"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#CFA6E0"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#FF99EE"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#C3A0D9"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#FF66E9"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#F4A8C0"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#E08AA7"),
    NG_Color_Card_Shadow_Red: Color(hex: "#FFB2D2"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#D07A97"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#FF99C8"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#A4F5E5"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#89D4C8"),
    NG_Color_Card_Shadow_Green: Color(hex: "#B8FFF2"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#73C4B1"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#38FFC6"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#B3D4F2"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#9FC3E6"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#CCE5FF"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#8AB0D9"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#5CA2E2"),

    // InProgress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#D0C0F5"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#C0A9F0"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#E6DBFF"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#B099E6"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#A38CFF"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#38FFC6"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#F4A8C0"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#E08AA7"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#FFB2D2"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#D07A97"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#F7A0C8"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#B3D4F2"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#9FC3E6"),
    NG_Color_Card_Shadow_Future: Color(hex: "#CCE5FF"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#8AB0D9"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#5CA2E2"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#D0C0F5"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#C0A9F0"),
    NG_Color_Card_Shadow_Today: Color(hex: "#E6DBFF"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#B099E6"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#A38CFF"),

    // NotStarted
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#D3C0F0"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#B8A3D9"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#E6DFFF"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#B8A3D9"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#D8C3F2"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#D8C7F0"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#C6B3E6"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#E9E2F7"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#B8A3D9"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#E3D7F7"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#A4D9F2"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#89C3E0"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#BEE5FF"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#73B1C4"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#3DDCFF"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#A4F2CC"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#89D9B8"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#B8FFE2"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#6FC4A3"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#3DDC84"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#F4A8C0"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#E08AA7"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#FFB2D2"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#D07A97"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#FF99C8"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#FFB3F1"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#FF99E9"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#D680C1"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#B366A3"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#FFB3F1"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#D3B8FF"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#B89CFF"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#E8DFFF"),
    NG_Color_Button_Glare_Regular: Color(hex: "#C4A3FF"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#B3A0E6"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#8A4DFF"),
    NG_Color_Button_Text_Regular: Color(hex: "#4A2D66"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#FFB2C8"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#FF94B6"),
    NG_Color_Button_Shadow_Red: Color(hex: "#FFD6E0"),
    NG_Color_Button_Glare_Red: Color(hex: "#FFAACB"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#D68097"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#FF5CA8"),
    NG_Color_Button_Text_Red: Color(hex: "#4D1A2E"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#98FFE6"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#78E6C6"),
    NG_Color_Button_Shadow_Green: Color(hex: "#C4FFF2"),
    NG_Color_Button_Glare_Green: Color(hex: "#7FFFD4"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#60D6B0"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#40FFD4"),
    NG_Color_Button_Text_Green: Color(hex: "#103A2F"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#C0B0FF"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#A89CFF"),
    NG_Color_Button_Shadow_Service: Color(hex: "#DCD6FF"),
    NG_Color_Button_Glare_Service: Color(hex: "#B3A3FF"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#A08CFF"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#7F66FF"),
    NG_Color_Button_Text_Service: Color(hex: "#332266"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#D8D3E0"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#C4C0D6"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#E6E3F0"),
    NG_Color_Button_Glare_Disabled: Color(hex: "#F0EEF7"),
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#B8B3C6"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#D8D0F0"),
    NG_Color_Button_Text_Disabled: Color(hex: "#8888A0"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#FFB3F1"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#FF99E0"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#FFD0F5"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#FFB3F1"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#CC80C1"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#4A1A4D"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#C6B3FF"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#B09EFF"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#DCD3FF"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#C4A3FF"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#A38CFF"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#8A4DFF"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#4A2D66"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#D8C7F0"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#C6B3E6"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#E8E0F7"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#D3C0FF"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#B8A3D9"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#D8C3F2"),
    NG_Color_Button_Text_Skipped: Color(hex: "#6A4DA0"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#B3E0FF"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#99D0F5"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#CCEFFF"),
    NG_Color_Button_Glare_Easy: Color(hex: "#7FE0FF"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#66B2D6"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Text_Easy: Color(hex: "#1A3D4D"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#A4F2CC"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#89D9B8"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#B8FFE2"),
    NG_Color_Button_Glare_Normal: Color(hex: "#7FFFD4"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#60C4A3"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#3DDC84"),
    NG_Color_Button_Text_Normal: Color(hex: "#1A3D2D"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#F4A8C0"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#E08AA7"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#FFB2D2"),
    NG_Color_Button_Glare_Hard: Color(hex: "#FFAACC"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#D68097"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#FF77AA"),
    NG_Color_Button_Text_Hard: Color(hex: "#4D1A2E"),
   
    // DatePicker
    NG_Color_DatePicker_Background: Color(hex: "#F5E9FF"),
    NG_Color_DatePicker_Foreground: Color(hex: "#4A2B5E"),

    // Red Icon
    NG_Color_Icon_TopLeft_Red: Color(hex: "#FF8FB8"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#FF5C8D"),
    NG_Color_Icon_Glare_Red: Color(hex: "#FFC1D9"),

    // Green Icon
    NG_Color_Icon_TopLeft_Green: Color(hex: "#A8FFE6"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#7FFFD4"),
    NG_Color_Icon_Glare_Green: Color(hex: "#D1FFF2"),

    // Regular Icon
    NG_Color_Icon_TopLeft_Regular: Color(hex: "#D1D5FF"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#A8ACF0"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#E0E2FF"),

    // Disabled Icon
    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#D0BFFF"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#A999E6"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#E8DBFF"),

    // ListRow
    NG_Color_ListRow_Separator: Color(hex: "#C4A3E0"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#E5D8FF"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#D0C2FF"),
    NG_Color_ListRow_Text_Top: Color(hex: "#4A2B5E"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#F7B3FF"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#E08FE6"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#4A2B5E"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#E0D5FF"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#CFC0F0"),
    NG_Color_ListRow_Text_Second: Color(hex: "#6A4DA0"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#F4B8F4"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#DC95DC"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#4A2B5E"),

    // TextField
    NG_Color_TextField_Background: Color(hex: "#F0E6FF"),
    NG_Color_TextField_Border: Color(hex: "#C7B2F0"),
    NG_Color_TextField_InnerShadow: Color(hex: "#D8CCF7"),
    NG_Color_TextField_OuterGlare: Color(hex: "#FFB3F1"),
    NG_Color_TextField_Text: Color(hex: "#4A2B5E"),

    // Selector
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#C68CFF"),
    NG_Color_Selector_backgroundColor: Color(hex: "#E8DBFF"),
    NG_Color_Selector_text_selected: Color(hex: "#FF66DD"),
    NG_Color_Selector_text_normal: Color(hex: "#A889CC"),

    // Checkbox
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#FF66DD"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#FFB3F1"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#A08CB8"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#D8CCF7"),

    // Grid
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#D3B3F0"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#FF66DD"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#E3C4FF"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#B36ACC"),

    NG_Color_Grid_Rows_Background: Color(hex: "#F0E6FF"),
    NG_Color_Grid_Rows_Text: Color(hex: "#8C66B8"),
)

let theme_retrowave_dark = NG_Theme(
    themeStyle : Theme_Style.retrowave,
    themeOption : Theme_Option.dark,
    
    NG_Color_Page_Background_Top: Color(hex: "#2C003E"),    // тёмный фиолетовый верх
    NG_Color_Page_Background_Bottom: Color(hex: "#0B0014"), // почти чёрный с фиолетовым низ
        
    NG_Color_Text_Regular_Text: Color(hex: "#E0D7FF"),       // светло-фиолетовый текст
    NG_Color_Text_Regular_Shadow: Color(hex: "#140D1F"),     // глубокая темная тень
    NG_Color_Text_Regular_Glare: Color(hex: "#7C6DB5"),      // приглушенный неоново-фиолетовый блик

    NG_Color_Text_Red_Text: Color(hex: "#FF4F9D"),           // яркая неоновая розовая
    NG_Color_Text_Red_Shadow: Color(hex: "#2B0D1C"),         // тёмная бордовая тень
    NG_Color_Text_Red_Glare: Color(hex: "#FF99C8"),          // светлая неоновая розовая

    NG_Color_Text_Green_Text: Color(hex: "#38FFC6"),         // бирюзово-неоновая
    NG_Color_Text_Green_Shadow: Color(hex: "#103A2F"),       // тёмно-бирюзовая тень
    NG_Color_Text_Green_Glare: Color(hex: "#84FFE2"),        // светлый неон бирюзы

    NG_Color_Text_Disabled_Text: Color(hex: "#5E6170"),      // мягкий серо-фиолетовый
    NG_Color_Text_Disabled_Shadow: Color(hex: "#1A1D24"),    // глубокая синевато-черная тень
    NG_Color_Text_Disabled_Glare: Color(hex: "#414755"),     // приглушенный серо-синий блик

    NG_Color_Text_AppWizard_Text: Color(hex: "#FF66E9"),     // яркая магента
    NG_Color_Text_AppWizard_Shadow: Color(hex: "#280D23"),   // глубокая фиолетовая тень
    NG_Color_Text_AppWizard_Glare: Color(hex: "#FFB3F1"),    // нежно-розовый блик
    
    NG_Color_Text_MuscleFatigue_NotTired_Text                           : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_NotTired_Shadow                         : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_NotTired_Glare                          : Color.NG_MuscleFatigue_Color_NotTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Text                      : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_SlightlyTired_Glare                     : Color.NG_MuscleFatigue_Color_SlightlyTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Text                              : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Tired_Shadow                            : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Tired_Glare                             : Color.NG_MuscleFatigue_Color_Tired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Text                          : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_VeryTired_Shadow                        : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_VeryTired_Glare                         : Color.NG_MuscleFatigue_Color_VeryTired_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Text                            : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,
    NG_Color_Text_MuscleFatigue_Damaged_Shadow                          : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleFatigue_Damaged_Glare                           : Color.NG_MuscleFatigue_Color_Damaged_Retrowave_Dark,

    NG_Color_Text_MuscleDevelopment_Undefined_Text                      : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Undefined_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Undefined_Glare                     : Color.NG_MuscleDevelopment_Color_Unknown_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Text                 : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow               : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare                : Color.NG_MuscleDevelopment_Color_Underdeveloped_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Text                      : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
    NG_Color_Text_MuscleDevelopment_Developed_Shadow                    : Color.NG_RawColor_MediumGray,
    NG_Color_Text_MuscleDevelopment_Developed_Glare                     : Color.NG_MuscleDevelopment_Color_Developed_Retrowave_Dark,
        
    // Regular
    NG_Color_Card_Background_TopLeft_Regular: Color(hex: "#2A1B3D"),
    NG_Color_Card_Background_BottomRight_Regular: Color(hex: "#1B1030"),
    NG_Color_Card_Shadow_Regular: Color(hex: "#0A0615"),
    NG_Color_Card_Border_Dark_Regular: Color(hex: "#140A26"),
    NG_Color_Card_Border_Bright_Regular: Color(hex: "#4D3D73"),

    // AppWizard
    NG_Color_Card_Background_TopLeft_AppWizard: Color(hex: "#4B2D5B"),
    NG_Color_Card_Background_BottomRight_AppWizard: Color(hex: "#2F1B3F"),
    NG_Color_Card_Shadow_AppWizard: Color(hex: "#9933CC"),
    NG_Color_Card_Border_Dark_AppWizard: Color(hex: "#1F0D2A"),
    NG_Color_Card_Border_Bright_AppWizard: Color(hex: "#FF66E9"),

    // Red
    NG_Color_Card_Background_TopLeft_Red: Color(hex: "#6E1B3C"),
    NG_Color_Card_Background_BottomRight_Red: Color(hex: "#450F26"),
    NG_Color_Card_Shadow_Red: Color(hex: "#992F55"),
    NG_Color_Card_Border_Dark_Red: Color(hex: "#290D18"),
    NG_Color_Card_Border_Bright_Red: Color(hex: "#CC4477"),

    // Green
    NG_Color_Card_Background_TopLeft_Green: Color(hex: "#1B4D4B"),
    NG_Color_Card_Background_BottomRight_Green: Color(hex: "#103733"),
    NG_Color_Card_Shadow_Green: Color(hex: "#2FD0B5"),
    NG_Color_Card_Border_Dark_Green: Color(hex: "#0D2926"),
    NG_Color_Card_Border_Bright_Green: Color(hex: "#38FFC6"),

    // Completed
    NG_Color_Card_Background_TopLeft_Completed: Color(hex: "#1B3A4D"),
    NG_Color_Card_Background_BottomRight_Completed: Color(hex: "#10293A"),
    NG_Color_Card_Shadow_Completed: Color(hex: "#2D6CA2"),
    NG_Color_Card_Border_Dark_Completed: Color(hex: "#0D1F2D"),
    NG_Color_Card_Border_Bright_Completed: Color(hex: "#2D6CA2"),

    // InProgress
    NG_Color_Card_Background_TopLeft_InProgress: Color(hex: "#291B4D"),
    NG_Color_Card_Background_BottomRight_InProgress: Color(hex: "#1A1037"),
    NG_Color_Card_Shadow_InProgress: Color(hex: "#443377"),
    NG_Color_Card_Border_Dark_InProgress: Color(hex: "#1A0D33"),
    NG_Color_Card_Border_Bright_InProgress: Color(hex: "#7A5CFF"),
    NG_Color_Card_Border_Bright_InProgress_2: Color(hex: "#38FFC6"),

    // Passed
    NG_Color_Card_Background_TopLeft_Passed: Color(hex: "#4D1B3A"),
    NG_Color_Card_Background_BottomRight_Passed: Color(hex: "#301024"),
    NG_Color_Card_Shadow_Passed: Color(hex: "#6E2F55"),
    NG_Color_Card_Border_Dark_Passed: Color(hex: "#1D0D18"),
    NG_Color_Card_Border_Bright_Passed: Color(hex: "#6E2F55"),

    // Future
    NG_Color_Card_Background_TopLeft_Future: Color(hex: "#1B3A4D"),
    NG_Color_Card_Background_BottomRight_Future: Color(hex: "#10293A"),
    NG_Color_Card_Shadow_Future: Color(hex: "#2D6CA2"),
    NG_Color_Card_Border_Dark_Future: Color(hex: "#0D1F2D"),
    NG_Color_Card_Border_Bright_Future: Color(hex: "#2D6CA2"),

    // Today
    NG_Color_Card_Background_TopLeft_Today: Color(hex: "#291B4D"),
    NG_Color_Card_Background_BottomRight_Today: Color(hex: "#1A1037"),
    NG_Color_Card_Shadow_Today: Color(hex: "#443377"),
    NG_Color_Card_Border_Dark_Today: Color(hex: "#1A0D33"),
    NG_Color_Card_Border_Bright_Today: Color(hex: "#443377"),
    
    
    // NotStarted
    NG_Color_Card_Background_TopLeft_NotStarted: Color(hex: "#3D2A5A"),
    NG_Color_Card_Background_BottomRight_NotStarted: Color(hex: "#291C3D"),
    NG_Color_Card_Shadow_NotStarted: Color(hex: "#1A0F26"),
    NG_Color_Card_Border_Dark_NotStarted: Color(hex: "#1A1226"),
    NG_Color_Card_Border_Bright_NotStarted: Color(hex: "#6B4D9B"),

    // Skipped
    NG_Color_Card_Background_TopLeft_Skipped: Color(hex: "#2A1B3D"),
    NG_Color_Card_Background_BottomRight_Skipped: Color(hex: "#1B1030"),
    NG_Color_Card_Shadow_Skipped: Color(hex: "#110A1F"),
    NG_Color_Card_Border_Dark_Skipped: Color(hex: "#140D26"),
    NG_Color_Card_Border_Bright_Skipped: Color(hex: "#4D3D73"),

    // Easy
    NG_Color_Card_Background_TopLeft_Easy: Color(hex: "#204D5A"),
    NG_Color_Card_Background_BottomRight_Easy: Color(hex: "#153A45"),
    NG_Color_Card_Shadow_Easy: Color(hex: "#102A33"),
    NG_Color_Card_Border_Dark_Easy: Color(hex: "#123944"),
    NG_Color_Card_Border_Bright_Easy: Color(hex: "#3DDCFF"),

    // Normal
    NG_Color_Card_Background_TopLeft_Normal: Color(hex: "#1B4D2D"),
    NG_Color_Card_Background_BottomRight_Normal: Color(hex: "#103922"),
    NG_Color_Card_Shadow_Normal: Color(hex: "#0A2A1C"),
    NG_Color_Card_Border_Dark_Normal: Color(hex: "#0D391F"),
    NG_Color_Card_Border_Bright_Normal: Color(hex: "#3DDC84"),

    // Hard
    NG_Color_Card_Background_TopLeft_Hard: Color(hex: "#6E1B3C"),
    NG_Color_Card_Background_BottomRight_Hard: Color(hex: "#450F26"),
    NG_Color_Card_Shadow_Hard: Color(hex: "#2B121F"),
    NG_Color_Card_Border_Dark_Hard: Color(hex: "#290D18"),
    NG_Color_Card_Border_Bright_Hard: Color(hex: "#FF6B99"),

    // Highlighted
    NG_Color_Card_Background_TopLeft_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Card_Background_BottomRight_Highlighted: Color(hex: "#FF33CC"),
    NG_Color_Card_Shadow_Highlighted: Color(hex: "#991F80"),
    NG_Color_Card_Border_Dark_Highlighted: Color(hex: "#660066"),
    NG_Color_Card_Border_Bright_Highlighted: Color(hex: "#FF99EE"),
        
    // Regular
    NG_Color_Button_Background_TopLeft_Regular: Color(hex: "#542D8A"),
    NG_Color_Button_Background_BottomRight_Regular: Color(hex: "#341C5A"),
    NG_Color_Button_Shadow_Regular: Color(hex: "#1A102F"),
    NG_Color_Button_Glare_Regular: Color(hex: "#8A4DFF"),
    NG_Color_Button_Border_Dark_Regular: Color(hex: "#291A4D"),
    NG_Color_Button_Border_Bright_Regular: Color(hex: "#8A4DFF"),
    NG_Color_Button_Text_Regular: Color(hex: "#FFFFFF"),

    // Red
    NG_Color_Button_Background_TopLeft_Red: Color(hex: "#A62253"),
    NG_Color_Button_Background_BottomRight_Red: Color(hex: "#701A3A"),
    NG_Color_Button_Shadow_Red: Color(hex: "#3F1022"),
    NG_Color_Button_Glare_Red: Color(hex: "#FF77AA"),
    NG_Color_Button_Border_Dark_Red: Color(hex: "#4D1126"),
    NG_Color_Button_Border_Bright_Red: Color(hex: "#FF5CA8"),
    NG_Color_Button_Text_Red: Color(hex: "#FFFFFF"),

    // Green
    NG_Color_Button_Background_TopLeft_Green: Color(hex: "#24C3A0"),
    NG_Color_Button_Background_BottomRight_Green: Color(hex: "#187D68"),
    NG_Color_Button_Shadow_Green: Color(hex: "#0C4F3D"),
    NG_Color_Button_Glare_Green: Color(hex: "#40FFD4"),
    NG_Color_Button_Border_Dark_Green: Color(hex: "#155348"),
    NG_Color_Button_Border_Bright_Green: Color(hex: "#40FFD4"),
    NG_Color_Button_Text_Green: Color(hex: "#FFFFFF"),

    // Service
    NG_Color_Button_Background_TopLeft_Service: Color(hex: "#4B3B99"),
    NG_Color_Button_Background_BottomRight_Service: Color(hex: "#2A1D5A"),
    NG_Color_Button_Shadow_Service: Color(hex: "#1A102F"),
    NG_Color_Button_Glare_Service: Color(hex: "#7F66FF"),
    NG_Color_Button_Border_Dark_Service: Color(hex: "#26164D"),
    NG_Color_Button_Border_Bright_Service: Color(hex: "#7F66FF"),
    NG_Color_Button_Text_Service: Color(hex: "#FFFFFF"),

    // Disabled
    NG_Color_Button_Background_TopLeft_Disabled: Color(hex: "#4A4660"),
    NG_Color_Button_Background_BottomRight_Disabled: Color(hex: "#2C2A3A"),
    NG_Color_Button_Shadow_Disabled: Color(hex: "#1F1C29"),
    NG_Color_Button_Glare_Disabled: .clear,
    NG_Color_Button_Border_Dark_Disabled: Color(hex: "#2A2733"),
    NG_Color_Button_Border_Bright_Disabled: Color(hex: "#666080"),
    NG_Color_Button_Text_Disabled: Color(hex: "#AAAAAA"),

    // Highlighted
    NG_Color_Button_Background_TopLeft_Highlighted: Color(hex: "#FF33CC"),
    NG_Color_Button_Background_BottomRight_Highlighted: Color(hex: "#B20088"),
    NG_Color_Button_Shadow_Highlighted: Color(hex: "#660066"),
    NG_Color_Button_Glare_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Border_Dark_Highlighted: Color(hex: "#7A0066"),
    NG_Color_Button_Border_Bright_Highlighted: Color(hex: "#FF66E9"),
    NG_Color_Button_Text_Highlighted: Color(hex: "#FFFFFF"),

    // DatePicker
    NG_Color_Button_Background_TopLeft_DatePicker: Color(hex: "#3A2D5A"),
    NG_Color_Button_Background_BottomRight_DatePicker: Color(hex: "#1C1534"),
    NG_Color_Button_Shadow_DatePicker: Color(hex: "#1A102F"),
    NG_Color_Button_Glare_DatePicker: Color(hex: "#6A4DFF"),
    NG_Color_Button_Border_Dark_DatePicker: Color(hex: "#1A0F2E"),
    NG_Color_Button_Border_Bright_DatePicker: Color(hex: "#6A4DFF"),
    NG_Color_Button_Text_DatePicker: Color(hex: "#F0F2F5"),

    // Skipped
    NG_Color_Button_Background_TopLeft_Skipped: Color(hex: "#2F1A4D"),
    NG_Color_Button_Background_BottomRight_Skipped: Color(hex: "#1A0F2E"),
    NG_Color_Button_Shadow_Skipped: Color(hex: "#110A1C"),
    NG_Color_Button_Glare_Skipped: Color(hex: "#4D3D73"),
    NG_Color_Button_Border_Dark_Skipped: Color(hex: "#140D26"),
    NG_Color_Button_Border_Bright_Skipped: Color(hex: "#6B4D9B"),
    NG_Color_Button_Text_Skipped: Color(hex: "#D0C9FF"),

    // Easy
    NG_Color_Button_Background_TopLeft_Easy: Color(hex: "#1B3D4F"),
    NG_Color_Button_Background_BottomRight_Easy: Color(hex: "#102A3A"),
    NG_Color_Button_Shadow_Easy: Color(hex: "#0A1C26"),
    NG_Color_Button_Glare_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Border_Dark_Easy: Color(hex: "#1A2E3D"),
    NG_Color_Button_Border_Bright_Easy: Color(hex: "#40D6FF"),
    NG_Color_Button_Text_Easy: Color(hex: "#FFFFFF"),

    // Normal
    NG_Color_Button_Background_TopLeft_Normal: Color(hex: "#1B4D3D"),
    NG_Color_Button_Background_BottomRight_Normal: Color(hex: "#103922"),
    NG_Color_Button_Shadow_Normal: Color(hex: "#0A2A1C"),
    NG_Color_Button_Glare_Normal: Color(hex: "#40FFD4"),
    NG_Color_Button_Border_Dark_Normal: Color(hex: "#0D391F"),
    NG_Color_Button_Border_Bright_Normal: Color(hex: "#3DDC84"),
    NG_Color_Button_Text_Normal: Color(hex: "#FFFFFF"),

    // Hard
    NG_Color_Button_Background_TopLeft_Hard: Color(hex: "#6E1B3C"),
    NG_Color_Button_Background_BottomRight_Hard: Color(hex: "#450F26"),
    NG_Color_Button_Shadow_Hard: Color(hex: "#2B121F"),
    NG_Color_Button_Glare_Hard: Color(hex: "#FF5CA8"),
    NG_Color_Button_Border_Dark_Hard: Color(hex: "#290D18"),
    NG_Color_Button_Border_Bright_Hard: Color(hex: "#FF77AA"),
    NG_Color_Button_Text_Hard: Color(hex: "#FFFFFF"),
   
    NG_Color_DatePicker_Background: Color(hex: "#2B1A3F"),
    NG_Color_DatePicker_Foreground: Color(hex: "#F5D6FF"),
   
    NG_Color_Icon_TopLeft_Red: Color(hex: "#FF5C8D"),
    NG_Color_Icon_BottomRight_Red: Color(hex: "#D72670"),
    NG_Color_Icon_Glare_Red: Color(hex: "#FF87B6"),

    NG_Color_Icon_TopLeft_Green: Color(hex: "#6CFFCB"),
    NG_Color_Icon_BottomRight_Green: Color(hex: "#34D6A8"),
    NG_Color_Icon_Glare_Green: Color(hex: "#92FFE0"),

    NG_Color_Icon_TopLeft_Regular: Color(hex: "#ACB2FF"),
    NG_Color_Icon_BottomRight_Regular: Color(hex: "#7479C1"),
    NG_Color_Icon_Glare_Regular: Color(hex: "#C0C5FF"),

    NG_Color_Icon_TopLeft_Disabled: Color(hex: "#8F7AFF"),
    NG_Color_Icon_BottomRight_Disabled: Color(hex: "#5E4FCC"),
    NG_Color_Icon_Glare_Disabled: Color(hex: "#B8A3FF"),
   
    NG_Color_ListRow_Separator: Color(hex: "#472C66"),

    NG_Color_ListRow_Background_TopLeft_Top: Color(hex: "#2D2A4A"),
    NG_Color_ListRow_Background_BottomRight_Top: Color(hex: "#1C1933"),
    NG_Color_ListRow_Text_Top: Color(hex: "#E3D7FF"),

    NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color(hex: "#5C2A7A"),
    NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color(hex: "#3E1D5A"),
    NG_Color_ListRow_Text_Top_Highlighted: Color(hex: "#FFFFFF"),

    NG_Color_ListRow_Background_TopLeft_Second: Color(hex: "#2B2945"),
    NG_Color_ListRow_Background_BottomRight_Second: Color(hex: "#1B1A30"),
    NG_Color_ListRow_Text_Second: Color(hex: "#C5B8FF"),

    NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color(hex: "#7A2A7A"),
    NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color(hex: "#5A1D5A"),
    NG_Color_ListRow_Text_Second_Highlighted: Color(hex: "#FFFFFF"),
   
    NG_Color_TextField_Background: Color(hex: "#2D2A4A"),
    NG_Color_TextField_Border: Color(hex: "#5C4C8A"),
    NG_Color_TextField_InnerShadow: Color(hex: "#1B1A30"),
    NG_Color_TextField_OuterGlare: Color(hex: "#FF77DD"),
    NG_Color_TextField_Text: Color(hex: "#E3D7FF"),
   
    NG_Color_Selector_selectedSegmentTintColor: Color(hex: "#8C4EFF"),
    NG_Color_Selector_backgroundColor: Color(hex: "#1B1530"),
    NG_Color_Selector_text_selected: Color(hex: "#FF77DD"),
    NG_Color_Selector_text_normal: Color(hex: "#AA88FF"),
   
    NG_Color_Checkbox_selectedTintColor: Color(hex: "#FF77DD"),
    NG_Color_Checkbox_selectedGlare: Color(hex: "#FFB3F1"),

    NG_Color_Checkbox_notSelectedTintColor: Color(hex: "#5C5A7D"),
    NG_Color_Checkbox_notSelectedGlare: Color(hex: "#2A243D"),
   
    NG_Color_Grid_MasterHeader_Background: Color(hex: "#3A1F5D"),
    NG_Color_Grid_MasterHeader_Text: Color(hex: "#FF77DD"),

    NG_Color_Grid_SubHeader_Background: Color(hex: "#2A1B3D"),
    NG_Color_Grid_SubHeader_Text: Color(hex: "#ECA7FF"),

    NG_Color_Grid_Rows_Background: Color(hex: "#1A102A"),
    NG_Color_Grid_Rows_Text: Color(hex: "#D8B0FF"),
)

enum Theme_Style{
    case regular
    case herren
    case frauen
    case cyberpunk
    case retrowave
    var fullName: String {
        switch self {
        case .regular:      return "Default"
        case .frauen:       return "Soft"
        case .herren:       return "Cold"
        case .cyberpunk:    return "Cyberpunk"
        case .retrowave:    return "Retrowave"
        }
    }
    
    var themeNamePrefix: String {
        switch self {
        case .regular:      return "Regular_"
        case .frauen:       return "Frauen_"
        case .herren:       return "Herren_"
        case .cyberpunk:    return "Cyber_"
        case .retrowave:    return "Retrowave_"
        }
    }
}

enum Theme_Option{
    case bright
    case dark
    
    var themeNameSuffix: String {
        switch self {
        case .bright:       return "Bright"
        case .dark:         return "Dark"
        }
    }
}

struct NG_Theme {
    
    let themeStyle:Theme_Style
    let themeOption:Theme_Option
    
    //  Colors for page
    //  options:
    //      only one option
    //  values:
    //      top background
    //      bottom background
    
    var NG_Color_Page_Background_Top: Color
    var NG_Color_Page_Background_Bottom: Color
    
    //  Colors for texts
    //  options:
    //      Regular
    //      Red
    //      Green
    //      Disabled
    //      AppWizard
    //      Title
    //      Sheet Title
    //  values:
    //      Text color
    //      Shadow
    //      Glare
    
    var NG_Color_Text_Regular_Text: Color
    var NG_Color_Text_Regular_Shadow: Color
    var NG_Color_Text_Regular_Glare: Color
    
    var NG_Color_Text_Red_Text: Color
    var NG_Color_Text_Red_Shadow: Color
    var NG_Color_Text_Red_Glare: Color
    
    var NG_Color_Text_Green_Text: Color
    var NG_Color_Text_Green_Shadow: Color
    var NG_Color_Text_Green_Glare: Color
    
    var NG_Color_Text_Disabled_Text: Color
    var NG_Color_Text_Disabled_Shadow: Color
    var NG_Color_Text_Disabled_Glare: Color
    
    var NG_Color_Text_AppWizard_Text: Color
    var NG_Color_Text_AppWizard_Shadow: Color
    var NG_Color_Text_AppWizard_Glare: Color
    
    var NG_Color_Text_MuscleFatigue_NotTired_Text: Color
    var NG_Color_Text_MuscleFatigue_NotTired_Shadow: Color
    var NG_Color_Text_MuscleFatigue_NotTired_Glare: Color
    var NG_Color_Text_MuscleFatigue_SlightlyTired_Text: Color
    var NG_Color_Text_MuscleFatigue_SlightlyTired_Shadow: Color
    var NG_Color_Text_MuscleFatigue_SlightlyTired_Glare: Color
    var NG_Color_Text_MuscleFatigue_Tired_Text: Color
    var NG_Color_Text_MuscleFatigue_Tired_Shadow: Color
    var NG_Color_Text_MuscleFatigue_Tired_Glare: Color
    var NG_Color_Text_MuscleFatigue_VeryTired_Text: Color
    var NG_Color_Text_MuscleFatigue_VeryTired_Shadow: Color
    var NG_Color_Text_MuscleFatigue_VeryTired_Glare: Color
    var NG_Color_Text_MuscleFatigue_Damaged_Text: Color
    var NG_Color_Text_MuscleFatigue_Damaged_Shadow: Color
    var NG_Color_Text_MuscleFatigue_Damaged_Glare: Color
    
    var NG_Color_Text_MuscleDevelopment_Undefined_Text: Color
    var NG_Color_Text_MuscleDevelopment_Undefined_Shadow: Color
    var NG_Color_Text_MuscleDevelopment_Undefined_Glare: Color
    var NG_Color_Text_MuscleDevelopment_Underdeveloped_Text: Color
    var NG_Color_Text_MuscleDevelopment_Underdeveloped_Shadow: Color
    var NG_Color_Text_MuscleDevelopment_Underdeveloped_Glare: Color
    var NG_Color_Text_MuscleDevelopment_Developed_Text: Color
    var NG_Color_Text_MuscleDevelopment_Developed_Shadow: Color
    var NG_Color_Text_MuscleDevelopment_Developed_Glare: Color
    
    //  Colors for cards
    //  options:
    //      Regular
    //      AppWizard
    //      Red
    //      Green
    //      Completed
    //      InProgress
    //      Passed
    //      Future
    //      Today
    //  values:
    //      TopLeft background
    //      BottomRight background
    //      Shadow
    //      BorderDark
    //      BorderBright
    //      BorderBright2 (optional)
    
    var NG_Color_Card_Background_TopLeft_Regular: Color
    var NG_Color_Card_Background_BottomRight_Regular: Color
    var NG_Color_Card_Shadow_Regular: Color
    var NG_Color_Card_Border_Dark_Regular: Color
    var NG_Color_Card_Border_Bright_Regular: Color
    
    var NG_Color_Card_Background_TopLeft_AppWizard: Color
    var NG_Color_Card_Background_BottomRight_AppWizard: Color
    var NG_Color_Card_Shadow_AppWizard: Color
    var NG_Color_Card_Border_Dark_AppWizard: Color
    var NG_Color_Card_Border_Bright_AppWizard: Color
    
    var NG_Color_Card_Background_TopLeft_Red: Color
    var NG_Color_Card_Background_BottomRight_Red: Color
    var NG_Color_Card_Shadow_Red: Color
    var NG_Color_Card_Border_Dark_Red: Color
    var NG_Color_Card_Border_Bright_Red: Color
    
    var NG_Color_Card_Background_TopLeft_Green: Color
    var NG_Color_Card_Background_BottomRight_Green: Color
    var NG_Color_Card_Shadow_Green: Color
    var NG_Color_Card_Border_Dark_Green: Color
    var NG_Color_Card_Border_Bright_Green: Color
    
    var NG_Color_Card_Background_TopLeft_Completed: Color
    var NG_Color_Card_Background_BottomRight_Completed: Color
    var NG_Color_Card_Shadow_Completed: Color
    var NG_Color_Card_Border_Dark_Completed: Color
    var NG_Color_Card_Border_Bright_Completed: Color
    
    var NG_Color_Card_Background_TopLeft_InProgress: Color
    var NG_Color_Card_Background_BottomRight_InProgress: Color
    var NG_Color_Card_Shadow_InProgress: Color
    var NG_Color_Card_Border_Dark_InProgress: Color
    var NG_Color_Card_Border_Bright_InProgress: Color
    var NG_Color_Card_Border_Bright_InProgress_2: Color
    
    var NG_Color_Card_Background_TopLeft_Passed: Color
    var NG_Color_Card_Background_BottomRight_Passed: Color
    var NG_Color_Card_Shadow_Passed: Color
    var NG_Color_Card_Border_Dark_Passed: Color
    var NG_Color_Card_Border_Bright_Passed: Color
    
    var NG_Color_Card_Background_TopLeft_Future: Color
    var NG_Color_Card_Background_BottomRight_Future: Color
    var NG_Color_Card_Shadow_Future: Color
    var NG_Color_Card_Border_Dark_Future: Color
    var NG_Color_Card_Border_Bright_Future: Color
    
    var NG_Color_Card_Background_TopLeft_Today: Color
    var NG_Color_Card_Background_BottomRight_Today: Color
    var NG_Color_Card_Shadow_Today: Color
    var NG_Color_Card_Border_Dark_Today: Color
    var NG_Color_Card_Border_Bright_Today: Color
    
    var NG_Color_Card_Background_TopLeft_NotStarted                       : Color
    var NG_Color_Card_Background_BottomRight_NotStarted                   : Color
    var NG_Color_Card_Shadow_NotStarted                                   : Color
    var NG_Color_Card_Border_Dark_NotStarted                              : Color
    var NG_Color_Card_Border_Bright_NotStarted                            : Color
    
    /*
     var NG_Color_Button_Background_TopLeft_Skipped: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Skipped: Color           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Shadow_Skipped: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Glare_Skipped: Color                            = Color.NG_RawColor_Black
     var NG_Color_Button_Border_Dark_Skipped: Color                      = Color.NG_RawColor_Black
     var NG_Color_Button_Border_Bright_Skipped: Color                    = Color.NG_RawColor_White
     var NG_Color_Button_Text_Skipped: Color                             = Color.NG_RawColor_Black
     */
    var NG_Color_Card_Background_TopLeft_Skipped                       : Color
    var NG_Color_Card_Background_BottomRight_Skipped                   : Color
    var NG_Color_Card_Shadow_Skipped                                   : Color
    var NG_Color_Card_Border_Dark_Skipped                              : Color
        var NG_Color_Card_Border_Bright_Skipped                            : Color
     
    /*
     var NG_Color_Button_Background_TopLeft_Easy: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Easy: Color           = Color.NG_RawColor_MediumPureCyan
     var NG_Color_Button_Shadow_Easy: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Glare_Easy: Color                            = Color.NG_RawColor_MediumPureCyan
     var NG_Color_Button_Border_Dark_Easy: Color                      = Color.NG_RawColor_VeryDarkPureCyan
     var NG_Color_Button_Border_Bright_Easy: Color                    = Color.NG_RawColor_BrightPureCyan
     var NG_Color_Button_Text_Easy: Color                             = Color.NG_RawColor_Black
     */
        var NG_Color_Card_Background_TopLeft_Easy                       : Color
        var NG_Color_Card_Background_BottomRight_Easy                   : Color
        var NG_Color_Card_Shadow_Easy                                   : Color
        var NG_Color_Card_Border_Dark_Easy                              : Color
        var NG_Color_Card_Border_Bright_Easy                            : Color
    
    /*
     var NG_Color_Button_Background_TopLeft_Normal: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Normal: Color           = Color.NG_RawColor_MediumPureGreen
     var NG_Color_Button_Shadow_Normal: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Glare_Normal: Color                            = Color.NG_RawColor_MediumPureGreen
     var NG_Color_Button_Border_Dark_Normal: Color                      = Color.NG_RawColor_DarkPureGreen
     var NG_Color_Button_Border_Bright_Normal: Color                    = Color.NG_RawColor_BrightPureGreen
     var NG_Color_Button_Text_Normal: Color                             = Color.NG_RawColor_Black
     */
        var NG_Color_Card_Background_TopLeft_Normal                       : Color
        var NG_Color_Card_Background_BottomRight_Normal                   : Color
        var NG_Color_Card_Shadow_Normal                                   : Color
        var NG_Color_Card_Border_Dark_Normal                              : Color
        var NG_Color_Card_Border_Bright_Normal                            : Color
     
    /*
     var NG_Color_Button_Background_TopLeft_Hard: Color               = Color.NG_RawColor_White
     var NG_Color_Button_Background_BottomRight_Hard: Color           = Color.NG_RawColor_MediumPureRed
     var NG_Color_Button_Shadow_Hard: Color                           = Color.NG_RawColor_MediumGray
     var NG_Color_Button_Border_Dark_Hard: Color                      = Color.NG_RawColor_DarkPureRed
     var NG_Color_Button_Border_Bright_Hard: Color                    = Color.NG_RawColor_BrightPureRed
     */
        var NG_Color_Card_Background_TopLeft_Hard                       : Color
        var NG_Color_Card_Background_BottomRight_Hard                   : Color
        var NG_Color_Card_Shadow_Hard                                   : Color
        var NG_Color_Card_Border_Dark_Hard                              : Color
        var NG_Color_Card_Border_Bright_Hard                            : Color
    
    var NG_Color_Card_Background_TopLeft_Highlighted                       : Color
    var NG_Color_Card_Background_BottomRight_Highlighted                   : Color
    var NG_Color_Card_Shadow_Highlighted                                   : Color
    var NG_Color_Card_Border_Dark_Highlighted                              : Color
    var NG_Color_Card_Border_Bright_Highlighted                            : Color
    
    //  Colors for button
    //  options:
    //      Regular
    //      Red
    //      Green
    //      Service
    //      Disabled
    //      Highlighted
    //      DatePicker
    //      Skipped
    //      Easy
    //      Normal
    //      Hard
    //  values:
    //      TopLeft background
    //      BottomRight background
    //      Shadow
    //      Glare
    //      BorderDark
    //      BorderBright
    //      Text color
    
    var NG_Color_Button_Background_TopLeft_Regular: Color
    var NG_Color_Button_Background_BottomRight_Regular: Color
    var NG_Color_Button_Shadow_Regular: Color
    var NG_Color_Button_Glare_Regular: Color
    var NG_Color_Button_Border_Dark_Regular: Color
    var NG_Color_Button_Border_Bright_Regular: Color
    var NG_Color_Button_Text_Regular: Color
    
    var NG_Color_Button_Background_TopLeft_Red: Color
    var NG_Color_Button_Background_BottomRight_Red: Color
    var NG_Color_Button_Shadow_Red: Color
    var NG_Color_Button_Glare_Red: Color
    var NG_Color_Button_Border_Dark_Red: Color
    var NG_Color_Button_Border_Bright_Red: Color
    var NG_Color_Button_Text_Red: Color
    
    var NG_Color_Button_Background_TopLeft_Green: Color
    var NG_Color_Button_Background_BottomRight_Green: Color
    var NG_Color_Button_Shadow_Green: Color
    var NG_Color_Button_Glare_Green: Color
    var NG_Color_Button_Border_Dark_Green: Color
    var NG_Color_Button_Border_Bright_Green: Color
    var NG_Color_Button_Text_Green: Color
    
    var NG_Color_Button_Background_TopLeft_Service: Color                  = Color.NG_RawColor_SteelMistBlue
    var NG_Color_Button_Background_BottomRight_Service: Color              = Color.NG_RawColor_SlateSkyBlue
    var NG_Color_Button_Shadow_Service: Color                              = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Service: Color                               = Color.NG_RawColor_PaleFrostBlue
    var NG_Color_Button_Border_Dark_Service: Color                         = Color.NG_RawColor_MarineTwilightBlue
    var NG_Color_Button_Border_Bright_Service: Color                       = Color.NG_RawColor_PaleFrostBlue
    var NG_Color_Button_Text_Service: Color                                = Color.NG_RawColor_White
    
    var NG_Color_Button_Background_TopLeft_Disabled: Color                 = Color.NG_RawColor_CloudedSteel
    var NG_Color_Button_Background_BottomRight_Disabled: Color             = Color.NG_RawColor_MutedSteelBlue
    var NG_Color_Button_Shadow_Disabled: Color                             = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Disabled: Color                              = .clear
    var NG_Color_Button_Border_Dark_Disabled: Color                        = Color.NG_RawColor_SmokySteelBlue
    var NG_Color_Button_Border_Bright_Disabled: Color                      = Color.NG_RawColor_FrostedSilver
    var NG_Color_Button_Text_Disabled: Color                               = Color.NG_RawColor_White
    
    var NG_Color_Button_Background_TopLeft_Highlighted: Color              = Color.NG_RawColor_VeryBrightRed
    var NG_Color_Button_Background_BottomRight_Highlighted: Color          = Color.NG_RawColor_MediumRed
    var NG_Color_Button_Shadow_Highlighted: Color                          = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Highlighted: Color                           = Color.NG_RawColor_BrightRed
    var NG_Color_Button_Border_Dark_Highlighted: Color                     = Color.NG_RawColor_DarkRed
    var NG_Color_Button_Border_Bright_Highlighted: Color                   = Color.NG_RawColor_MediumRed
    var NG_Color_Button_Text_Highlighted: Color                            = Color.NG_RawColor_White
    
    var NG_Color_Button_Background_TopLeft_DatePicker: Color               = Color.NG_RawColor_White
    var NG_Color_Button_Background_BottomRight_DatePicker: Color           = Color.NG_RawColor_BrightGray
    var NG_Color_Button_Shadow_DatePicker: Color                           = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_DatePicker: Color                            = Color.NG_RawColor_PaleFrostBlue
    var NG_Color_Button_Border_Dark_DatePicker: Color                      = Color.NG_RawColor_BrightGray
    var NG_Color_Button_Border_Bright_DatePicker: Color                    = Color.NG_RawColor_White
    var NG_Color_Button_Text_DatePicker: Color                             = Color.NG_RawColor_Black
    
    var NG_Color_Button_Background_TopLeft_Skipped: Color               = Color.NG_RawColor_White
    var NG_Color_Button_Background_BottomRight_Skipped: Color           = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Shadow_Skipped: Color                           = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Skipped: Color                            = Color.NG_RawColor_Black
    var NG_Color_Button_Border_Dark_Skipped: Color                      = Color.NG_RawColor_Black
    var NG_Color_Button_Border_Bright_Skipped: Color                    = Color.NG_RawColor_White
    var NG_Color_Button_Text_Skipped: Color                             = Color.NG_RawColor_Black
    
    var NG_Color_Button_Background_TopLeft_Easy: Color               = Color.NG_RawColor_White
    var NG_Color_Button_Background_BottomRight_Easy: Color           = Color.NG_RawColor_MediumPureCyan
    var NG_Color_Button_Shadow_Easy: Color                           = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Easy: Color                            = Color.NG_RawColor_MediumPureCyan
    var NG_Color_Button_Border_Dark_Easy: Color                      = Color.NG_RawColor_VeryDarkPureCyan
    var NG_Color_Button_Border_Bright_Easy: Color                    = Color.NG_RawColor_BrightPureCyan
    var NG_Color_Button_Text_Easy: Color                             = Color.NG_RawColor_Black
    
    var NG_Color_Button_Background_TopLeft_Normal: Color               = Color.NG_RawColor_White
    var NG_Color_Button_Background_BottomRight_Normal: Color           = Color.NG_RawColor_MediumPureGreen
    var NG_Color_Button_Shadow_Normal: Color                           = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Normal: Color                            = Color.NG_RawColor_MediumPureGreen
    var NG_Color_Button_Border_Dark_Normal: Color                      = Color.NG_RawColor_DarkPureGreen
    var NG_Color_Button_Border_Bright_Normal: Color                    = Color.NG_RawColor_BrightPureGreen
    var NG_Color_Button_Text_Normal: Color                             = Color.NG_RawColor_Black
    
    var NG_Color_Button_Background_TopLeft_Hard: Color               = Color.NG_RawColor_White
    var NG_Color_Button_Background_BottomRight_Hard: Color           = Color.NG_RawColor_MediumPureRed
    var NG_Color_Button_Shadow_Hard: Color                           = Color.NG_RawColor_MediumGray
    var NG_Color_Button_Glare_Hard: Color                            = Color.NG_RawColor_MediumPureRed
    var NG_Color_Button_Border_Dark_Hard: Color                      = Color.NG_RawColor_DarkPureRed
    var NG_Color_Button_Border_Bright_Hard: Color                    = Color.NG_RawColor_BrightPureRed
    var NG_Color_Button_Text_Hard: Color                             = Color.NG_RawColor_Black
    
    //  Colors for date picker
    //  options:
    //      only one option
    //  values:
    //      Background
    //      Foreground
    
    var NG_Color_DatePicker_Background: Color                              = Color.NG_RawColor_DarkGray
    var NG_Color_DatePicker_Foreground: Color                              = Color.NG_RawColor_White
    
    //  Colors for icon
    //  options:
    //      Red
    //      Green
    //      Regular
    //      Disabled
    //  values:
    //      TopLeft background
    //      BottomRight background
    //      Glare
    //      Icon color
    
    var NG_Color_Icon_TopLeft_Red: Color                                   = Color.NG_RawColor_BrightRed
    var NG_Color_Icon_BottomRight_Red: Color                               = Color.NG_RawColor_DarkRed
    var NG_Color_Icon_Glare_Red: Color                                     = Color.NG_RawColor_MediumRed
    
    var NG_Color_Icon_TopLeft_Yellow: Color                                = Color.NG_RawColor_BrightYellow
    var NG_Color_Icon_BottomRight_Yellow: Color                            = Color.NG_RawColor_DarkYellow
    var NG_Color_Icon_Glare_Yellow: Color                                  = Color.NG_RawColor_MediumRed
    
    var NG_Color_Icon_TopLeft_Green: Color                                 = Color.NG_RawColor_BrightGreen
    var NG_Color_Icon_BottomRight_Green: Color                             = Color.NG_RawColor_DarkGreen
    var NG_Color_Icon_Glare_Green: Color                                   = Color.NG_RawColor_MediumGreen
    
    var NG_Color_Icon_TopLeft_Regular: Color                               = Color.NG_RawColor_BrightGray
    var NG_Color_Icon_BottomRight_Regular: Color                           = Color.NG_RawColor_DarkGray
    var NG_Color_Icon_Glare_Regular: Color                                 = Color.NG_RawColor_MediumGray
    
    var NG_Color_Icon_TopLeft_Disabled: Color                              = Color.NG_RawColor_BrightBlue
    var NG_Color_Icon_BottomRight_Disabled: Color                          = Color.NG_RawColor_DarkBlue
    var NG_Color_Icon_Glare_Disabled: Color                                = Color.NG_RawColor_MediumBlue
    
    //  Colors for list rows
    //  options:
    //      Top
    //      Top highlighted
    //      Second
    //      Second highlighted
    //  values:
    //      TopLeft background
    //      BottomRight background
    //      Text color
    
    var NG_Color_ListRow_Separator: Color                                  = Color.NG_RawColor_VeryDarkGray
    
    var NG_Color_ListRow_Background_TopLeft_Top: Color                     = Color.NG_RawColor_White
    var NG_Color_ListRow_Background_BottomRight_Top: Color                 = Color.NG_RawColor_BrightGray
    var NG_Color_ListRow_Text_Top: Color                                   = Color.NG_RawColor_White
    
    var NG_Color_ListRow_Background_TopLeft_Top_Highlighted: Color         = Color.NG_RawColor_White
    var NG_Color_ListRow_Background_BottomRight_Top_Highlighted: Color     = Color.NG_RawColor_BrightLime
    var NG_Color_ListRow_Text_Top_Highlighted: Color                       = Color.NG_RawColor_White
    
    var NG_Color_ListRow_Background_TopLeft_Second: Color                  = Color.NG_RawColor_BrightGray
    var NG_Color_ListRow_Background_BottomRight_Second: Color              = Color.NG_RawColor_VeryDarkGray
    var NG_Color_ListRow_Text_Second: Color                                = Color.NG_RawColor_Black
    
    var NG_Color_ListRow_Background_TopLeft_Second_Highlighted: Color      = Color.NG_RawColor_BrightGray
    var NG_Color_ListRow_Background_BottomRight_Second_Highlighted: Color  = Color.NG_RawColor_VeryDarkLime
    var NG_Color_ListRow_Text_Second_Highlighted: Color                    = Color.NG_RawColor_Black
    
    //  Colors for text field
    //  options:
    //      only one option
    //  values:
    //      background
    //      border
    //      inner shadow
    //      outer shadow
    //      text color
    
    var NG_Color_TextField_Background: Color                               = Color.NG_RawColor_White
    var NG_Color_TextField_Border: Color                                   = Color.NG_RawColor_DarkGray
    var NG_Color_TextField_InnerShadow: Color                              = Color.NG_RawColor_MediumGray
    var NG_Color_TextField_OuterGlare: Color                               = Color.NG_RawColor_MediumRed
    var NG_Color_TextField_Text: Color                                     = Color.NG_RawColor_Black
    
    //  Colors for selector
    //  options:
    //      only one option
    //  values:
    //      selected background
    //      regular background
    //      text selected
    //      text normal
    
    var NG_Color_Selector_selectedSegmentTintColor: Color                  = Color.NG_RawColor_BrightGray
    var NG_Color_Selector_backgroundColor: Color                           = Color.NG_RawColor_DarkGray
    var NG_Color_Selector_text_selected: Color                             = Color.NG_RawColor_White
    var NG_Color_Selector_text_normal: Color                               = Color.NG_RawColor_White
    
    //  Colors for checkbox
    //  options:
    //      selected
    //      not selected
    //  values:
    //      tint
    //      glare
    
    var NG_Color_Checkbox_selectedTintColor: Color                         = Color.NG_RawColor_BrightGreen
    var NG_Color_Checkbox_selectedGlare: Color                             = Color.NG_RawColor_MediumGreen
    
    var NG_Color_Checkbox_notSelectedTintColor: Color                      = Color.NG_RawColor_DarkGray
    var NG_Color_Checkbox_notSelectedGlare: Color                          = Color.NG_RawColor_Black
    
    //  Colors for grids
    //  options:
    //      master header
    //      sub header
    //      rows
    //  values:
    //      background
    //      text
    
    var NG_Color_Grid_MasterHeader_Background: Color                       = Color.NG_RawColor_DarkGray
    var NG_Color_Grid_MasterHeader_Text: Color                             = Color.NG_RawColor_White
    
    var NG_Color_Grid_SubHeader_Background: Color                          = Color.NG_RawColor_MediumGray
    var NG_Color_Grid_SubHeader_Text: Color                                = Color.NG_RawColor_White
    
    var NG_Color_Grid_Rows_Background: Color                               = Color.NG_RawColor_BrightGray
    var NG_Color_Grid_Rows_Text: Color                                     = Color.NG_RawColor_Black
    
    //  LinearGradient for regular background
    //  options:
    //      only one option
    //  values:
    //      top
    //      bottom
    var NG_LinearGradient_Background_Page: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [NG_Color_Page_Background_Top, NG_Color_Page_Background_Bottom]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    //  LinearGradient for cards
    //  options:
    //      Regular
    //      AppWizard
    //      Red
    //      Green
    //      Completed
    //      InProgress
    //      Passed
    //      Future
    //      Today
    //  values:
    //      TopLeft background
    //      BottomRight background
    var NG_LinearGradient_Background_Card_Regular: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Regular, NG_Color_Card_Background_BottomRight_Regular]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_AppWizard: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_AppWizard, NG_Color_Card_Background_BottomRight_AppWizard]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Red: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Red, NG_Color_Card_Background_BottomRight_Red]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Green: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Green, NG_Color_Card_Background_BottomRight_Green]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Completed: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Completed, NG_Color_Card_Background_BottomRight_Completed]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_InProgress: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_InProgress, NG_Color_Card_Background_BottomRight_InProgress]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Passed: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Passed, NG_Color_Card_Background_BottomRight_Passed]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Future: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Future, NG_Color_Card_Background_BottomRight_Future]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Today: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Today, NG_Color_Card_Background_BottomRight_Today]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_NotStarted: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_NotStarted, NG_Color_Card_Background_BottomRight_NotStarted]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Skipped: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Skipped, NG_Color_Card_Background_BottomRight_Skipped]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Easy: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Easy, NG_Color_Card_Background_BottomRight_Easy]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Normal: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Normal, NG_Color_Card_Background_BottomRight_Normal]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Card_Hard: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Card_Background_TopLeft_Hard, NG_Color_Card_Background_BottomRight_Hard]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    //  LinearGradient for button
    //  options:
    //      Regular
    //      Red
    //      Green
    //      Service
    //      Disabled
    //      Highlighted
    //      DatePicker
    //      Skipped
    //      Easy
    //      Normal
    //      Hard
    //  values:
    //      TopLeft background
    //      BottomRight background
    var NG_LinearGradient_Background_Button_Regular: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Regular, NG_Color_Button_Background_BottomRight_Regular]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Service: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Service, NG_Color_Button_Background_BottomRight_Service]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Disabled: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Disabled, NG_Color_Button_Background_BottomRight_Disabled]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Red: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Red, NG_Color_Button_Background_BottomRight_Red]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Green: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Green, NG_Color_Button_Background_BottomRight_Green]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_DatePicker: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_DatePicker, NG_Color_Button_Background_BottomRight_DatePicker]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Skipped: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Skipped, NG_Color_Button_Background_BottomRight_Skipped]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Easy: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Easy, NG_Color_Button_Background_BottomRight_Easy]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Normal: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Normal, NG_Color_Button_Background_BottomRight_Normal]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_Button_Hard: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Button_Background_TopLeft_Hard, NG_Color_Button_Background_BottomRight_Hard]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    //  LinearGradient for icon
    //  options:
    //      Red
    //      Green
    //      Regular
    //      Disabled
    //  values:
    //      TopLeft background
    //      BottomRight background
    var NG_LinearGradient_Icon_Background_Regular: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Icon_TopLeft_Regular, NG_Color_Icon_BottomRight_Regular]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Icon_Background_Disabled: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Icon_TopLeft_Disabled, NG_Color_Icon_BottomRight_Disabled]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Icon_Background_Red: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Icon_TopLeft_Red, NG_Color_Icon_BottomRight_Red]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Icon_Background_Yellow: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Icon_TopLeft_Yellow, NG_Color_Icon_BottomRight_Yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Icon_Background_Green: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_Icon_TopLeft_Green, NG_Color_Icon_BottomRight_Green]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    //  LinearGradient for list rows
    //  options:
    //      Top
    //      Top highlighted
    //      Second
    //      Second highlighted
    //  values:
    //      TopLeft background
    //      BottomRight background
    var NG_LinearGradient_Background_ListRow_Second_Regular: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_ListRow_Background_TopLeft_Top, NG_Color_ListRow_Background_BottomRight_Top]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_ListRow_Top_Regular: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_ListRow_Background_TopLeft_Second, NG_Color_ListRow_Background_BottomRight_Second]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_ListRow_Second_Highlighted: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_ListRow_Background_TopLeft_Top_Highlighted, NG_Color_ListRow_Background_BottomRight_Top_Highlighted]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var NG_LinearGradient_Background_ListRow_Top_Highlighted: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [NG_Color_ListRow_Background_TopLeft_Second_Highlighted, NG_Color_ListRow_Background_BottomRight_Second_Highlighted]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
