import SwiftUI
/*
struct GradientButtonStyle: ButtonStyle {
    let gradientStart: Color
    let gradientEnd: Color
    let borderBright: Color
    let borderDark: Color
    @Binding var isActive: Bool
    @Binding var isHighlighting: Bool
    @Binding var isPulsating: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.buttonText)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [gradientStart, gradientEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderBright, lineWidth: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderDark, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

enum ButtonStyleEnum{
    case regular
    case service
    case disabled
    case red
    case green
}

struct ServiceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.serviceButtonStart, .serviceButtonEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.serviceButtonBridghtBorder, lineWidth: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.serviceButtonDarkBorder, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 3)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct GradientButtonModifier: ViewModifier {
    let style: ButtonStyleEnum
    @Binding var isDisabled: Bool
    @Binding var isHighlighting: Bool
    @Binding var isPulsating: Bool
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        let gradientStart: Color
        let gradientEnd: Color
        let borderBright: Color
        let borderDark: Color
        
        let effectiveStyle = isDisabled ? .disabled : style

        switch effectiveStyle {
        case .regular:
            gradientStart = .regularButtonStart
            gradientEnd = .regularButtonEnd
            borderBright = isHighlighting ? .highlightBorderBright : .regularButtonBridghtBorder
            borderDark = isHighlighting ? .highlightBorderDark : .regularButtonDarkBorder
        case .service:
            gradientStart = .serviceButtonStart
            gradientEnd = .serviceButtonEnd
            borderBright = isHighlighting ? .highlightBorderBright :.serviceButtonBridghtBorder
            borderDark = isHighlighting ? .highlightBorderDark : .serviceButtonDarkBorder
        case .disabled:
            gradientStart = .disabledButtonStart
            gradientEnd = .disabledButtonEnd
            borderBright = .disabledButtonBridghtBorder
            borderDark = .disabledButtonDarkBorder
        case .red:
            gradientStart = .redButtonStart
            gradientEnd = .redButtonEnd
            borderBright = .redButtonBridghtBorder
            borderDark = .redButtonDarkBorder
        case .green:
            gradientStart = .greenButtonStart
            gradientEnd = .greenButtonEnd
            borderBright = .greenButtonBridghtBorder
            borderDark = .greenButtonDarkBorder
        }

        return Button(action: action ?? {}) {
            content
        }
        .buttonStyle(
            GradientButtonStyle(
                gradientStart: gradientStart,
                gradientEnd: gradientEnd,
                borderBright: borderBright,
                borderDark: borderDark,
                isActive: $isDisabled,
                isHighlighting: $isHighlighting,
                isPulsating: $isPulsating
            )
        )
        .pulsation(pulsation: .constant(isPulsating))
        .disabled(action == nil)
    }
}

extension View {
    func gradientButtonStyle(
        style: ButtonStyleEnum,
        isDisabled: Binding<Bool>,
        isHighlighting: Binding<Bool>,
        isPulsating: Binding<Bool>,
        action: (() -> Void)? = nil
    ) -> some View {
        self.modifier(GradientButtonModifier(
            style: style,
            isDisabled: isDisabled,
            isHighlighting: isHighlighting,
            isPulsating: isPulsating,
            action: action
        ))
    }
}
*/
