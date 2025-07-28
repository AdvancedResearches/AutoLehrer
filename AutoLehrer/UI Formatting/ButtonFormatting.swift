import SwiftUI
/*
struct ButtonFormatting{
    static let edgesPadding: CGFloat = 50
    static let sectionPadding: CGFloat = 10
    static let innerPadding: CGFloat = 10
    static let outerPadding: CGFloat = 3
    static let corenerRadius: CGFloat = 3
    static let shadowRadius: CGFloat = 5
    static let shadowX: CGFloat = 0
    static let shadowY: CGFloat = 2
    static let pressedShadowRadius: CGFloat = 3
    static let pressedShadowX: CGFloat = 0
    static let pressedShadowY: CGFloat = 1
    static let backgroundOpacity: Double = 0.5
    static let height: CGFloat = 20
    static let pressedScale: CGFloat = 0.95
}
*/
/*
 struct NavigationButtonStyle: ViewModifier {
     let foregroundColor: Color
     let backgroundColor: Color
     let glareColor: Color
     let cornerRadius: CGFloat
     let outerPadding: CGFloat
     let shadowRadius: CGFloat
     let shadowX: CGFloat
     let shadowY: CGFloat
     
     func body(content: Content) -> some View {
         content
             .font(.headline)
             .padding(10)
             .frame(maxWidth: .infinity, maxHeight: .infinity)
             .foregroundColor(foregroundColor)
             .background(backgroundColor)
             .cornerRadius(cornerRadius)
             .padding(outerPadding)
             .shadow(color: glareColor, radius: shadowRadius, x: shadowX, y: shadowY)
     }
 }
 */
/*
struct TaskButtonStyle: ViewModifier {
    let isActive: Bool // Это переменная, которая контролирует состояние кнопки
    let foregroundOn: Color
    let foregroundOff: Color
    let backgroundOn: Color
    let backgroundOff: Color

    func body(content: Content) -> some View {
        content
            .buttonStyle(PlainButtonStyle())
            .font(.body)
            .padding(ButtonFormatting.innerPadding)
            .foregroundColor(isActive ? foregroundOn : foregroundOff)
            .background(isActive ? backgroundOn : backgroundOff)
            .cornerRadius(ButtonFormatting.corenerRadius)
            .scaleEffect(isActive ? ButtonFormatting.pressedScale : 1)
            .padding(ButtonFormatting.outerPadding)
            .shadow(
                color: isActive ? foregroundOn : foregroundOff,
                radius: isActive ? ButtonFormatting.pressedShadowRadius : ButtonFormatting.shadowRadius,
                x: isActive ? ButtonFormatting.pressedShadowX : ButtonFormatting.shadowX,
                y: isActive ? ButtonFormatting.pressedShadowY : ButtonFormatting.shadowY
            )
    }
}

extension View {
    /*func customButtonStyle(type: ButtonType, isActive: Bool) -> some View {
     switch(type){
     case .notStarted:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.notStartedForegroundOn, foregroundOff: TaskStatusButtons.notStartedForegroundOff, backgroundOn: TaskStatusButtons.notStartedBackgroundOn, backgroundOff: TaskStatusButtons.notStartedBackgroundOff))
     case .completed:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.completedForegroundOn, foregroundOff: TaskStatusButtons.completedForegroundOff, backgroundOn: TaskStatusButtons.completedBackgroundOn, backgroundOff: TaskStatusButtons.completedBackgroundOff))
     case .cancelled:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.cancelledForegroundOn, foregroundOff: TaskStatusButtons.cancelledForegroundOff, backgroundOn: TaskStatusButtons.cancelledBackgroundOn, backgroundOff: TaskStatusButtons.cancelledBackgroundOff))
     case .attention:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.attentionForegroundOn, foregroundOff: TaskStatusButtons.attentionForegroundOff, backgroundOn: TaskStatusButtons.attentionBackgroundOn, backgroundOff: TaskStatusButtons.attentionBackgroundOff))
     case .yes:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.completedForegroundOn, foregroundOff: TaskStatusButtons.completedForegroundOn, backgroundOn: TaskStatusButtons.completedBackgroundOn, backgroundOff: TaskStatusButtons.completedBackgroundOn))
     case .no:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.cancelledForegroundOn, foregroundOff: TaskStatusButtons.cancelledForegroundOn, backgroundOn: TaskStatusButtons.cancelledBackgroundOn, backgroundOff: TaskStatusButtons.cancelledBackgroundOn))
     case .critical:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.criticalForegroundOn, foregroundOff: TaskStatusButtons.criticalForegroundOff, backgroundOn: TaskStatusButtons.criticalBackgroundOn, backgroundOff: TaskStatusButtons.criticalBackgroundOff))
     case .high:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.highForegroundOn, foregroundOff: TaskStatusButtons.highForegroundOff, backgroundOn: TaskStatusButtons.highBackgroundOn, backgroundOff: TaskStatusButtons.highBackgroundOff))
     case .normal:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.normalForegroundOn, foregroundOff: TaskStatusButtons.normalForegroundOff, backgroundOn: TaskStatusButtons.normalBackgroundOn, backgroundOff: TaskStatusButtons.normalBackgroundOff))
     default:
     self.modifier(TaskButtonStyle(isActive: isActive, foregroundOn: TaskStatusButtons.neutralForegroundOn, foregroundOff: TaskStatusButtons.neutralForegroundOff, backgroundOn: TaskStatusButtons.neutralBackgroundOn, backgroundOff: TaskStatusButtons.neutralBackgroundOff))
     }
     }*/
    func customButtonStyle(
        type: ButtonType,
        isActive: Bool,
        blinking: Bool = false,
        cornerRadius: CGFloat = ButtonFormatting.corenerRadius,
        outerPadding: CGFloat = ButtonFormatting.outerPadding,
        shadowRadius: CGFloat = ButtonFormatting.shadowRadius,
        shadowX: CGFloat = ButtonFormatting.shadowX,
        shadowY: CGFloat = ButtonFormatting.shadowY
    ) -> some View {
        let foregroundColor = isActive ? type.foregroundOn : type.foregroundOff
        let backgroundColor = isActive ? type.backgroundOn : type.backgroundOff
        
        return self.modifier(TaskButtonStyle(
            isActive: isActive,
            foregroundOn: foregroundColor,
            foregroundOff: foregroundColor,
            backgroundOn: backgroundColor,
            backgroundOff: backgroundColor
        ))
        .cornerRadius(cornerRadius)
        .padding(outerPadding)
        .shadow(color: foregroundColor, radius: shadowRadius, x: shadowX, y: shadowY)
    }
}

enum ButtonType {
    case yes
    case no
    
    case metric_notDone
    case metric_easy
    case metric_normal
    case metric_hard
    
    case notStarted
    case completed
    case cancelled
    
    case critical
    case high
    case neutral
    
    case normal
    case attention
    
    var foregroundOn: Color {
        switch self {
        case .yes:              return TaskStatusButtons.greenForegroundOn
        case .no:               return TaskStatusButtons.redForegroundOn
            
        case .metric_notDone:   return MasterColorSchema.color_dark_1
        case .metric_easy:      return MasterColorSchema.color_dark_most
        case .metric_normal:    return MasterColorSchema.color_dark_most
        case .metric_hard:      return MasterColorSchema.color_dark_most
            
        case .notStarted:       return TaskStatusButtons.base2ForegroundOn
        case .completed:        return TaskStatusButtons.greenForegroundOn
        case .cancelled:        return TaskStatusButtons.redForegroundOn
            
        case .critical:         return TaskStatusButtons.orangeForegroundOn
        case .high:             return TaskStatusButtons.redForegroundOn
        case .neutral:          return TaskStatusButtons.base1ForegroundOn
            
        case .normal:           return TaskStatusButtons.base1ForegroundOn
        case .attention:        return TaskStatusButtons.orangeForegroundOn
            
        default:                return TaskStatusButtons.base1ForegroundOn
        }
    }
    
    var foregroundOff: Color {
        switch self {
        case .yes:              return TaskStatusButtons.greenForegroundOff
        case .no:               return TaskStatusButtons.redForegroundOff
            
        case .metric_notDone:   return MasterColorSchema.color_dark_gray
        case .metric_easy:      return MasterColorSchema.color_dark_gray
        case .metric_normal:    return MasterColorSchema.color_dark_gray
        case .metric_hard:      return MasterColorSchema.color_dark_gray
            
        case .notStarted:       return TaskStatusButtons.base2ForegroundOff
        case .completed:        return TaskStatusButtons.greenForegroundOff
        case .cancelled:        return TaskStatusButtons.redForegroundOff
            
        case .critical:         return TaskStatusButtons.orangeForegroundOff
        case .high:             return TaskStatusButtons.redForegroundOff
        case .neutral:          return TaskStatusButtons.base1ForegroundOff
            
        case .normal:           return TaskStatusButtons.base1ForegroundOff
        case .attention:        return TaskStatusButtons.orangeForegroundOff
            
        default:                return TaskStatusButtons.base1ForegroundOff
        }
    }
    
    /*
     public static let metric_notdone_back   = Color.palette_bright_gray.opacity(0.7)
     public static let metric_easy_back      = Color.palette_bright_base_1.opacity(0.7)
     public static let metric_normal_back    = Color.palette_bright_green.opacity(0.7)
     public static let metric_hard_back      = Color.palette_bright_red.opacity(0.7)
     */
    
    var backgroundOn: Color {
        switch self {
        case .yes:              return TaskStatusButtons.greenBackgroundOn
        case .no:               return TaskStatusButtons.redBackgroundOn
            
        case .metric_notDone:   return Color.palette_bright_gray
        case .metric_easy:      return Color.palette_bright_base_1
        case .metric_normal:    return Color.palette_bright_green
        case .metric_hard:      return Color.palette_bright_red
            
        case .notStarted:       return TaskStatusButtons.base2BackgroundOn
        case .completed:        return TaskStatusButtons.greenBackgroundOn
        case .cancelled:        return TaskStatusButtons.redBackgroundOn
            
        case .critical:         return TaskStatusButtons.orangeBackgroundOn
        case .high:             return TaskStatusButtons.redBackgroundOn
        case .neutral:          return TaskStatusButtons.base1BackgroundOn
            
        case .normal:           return TaskStatusButtons.base1BackgroundOn
        case .attention:        return TaskStatusButtons.orangeBackgroundOn
            
        default:                return TaskStatusButtons.base1BackgroundOn
        }
    }
    
    var backgroundOff: Color {
        switch self {
        case .yes:              return TaskStatusButtons.greenBackgroundOff
        case .no:               return TaskStatusButtons.redBackgroundOff
            
        case .metric_notDone:   return Color.palette_bright_gray
        case .metric_easy:      return Color.palette_bright_base_1
        case .metric_normal:    return Color.palette_bright_green
        case .metric_hard:      return Color.palette_bright_red
            
        case .notStarted:       return TaskStatusButtons.base2BackgroundOff
        case .completed:        return TaskStatusButtons.greenBackgroundOff
        case .cancelled:        return TaskStatusButtons.redBackgroundOff
            
        case .critical:         return TaskStatusButtons.orangeBackgroundOff
        case .high:             return TaskStatusButtons.redBackgroundOff
        case .neutral:          return TaskStatusButtons.base1BackgroundOff
            
        case .normal:           return TaskStatusButtons.base1BackgroundOff
        case .attention:        return TaskStatusButtons.orangeBackgroundOff
            
        default:                return TaskStatusButtons.base1BackgroundOff
        }
    }
}
*/
