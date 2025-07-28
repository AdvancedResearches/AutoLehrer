import SwiftUI

extension View{
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

/*
extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    func sheetContentFormatting(transparent: Bool = false) -> some View {
        self.modifier(SheetContentFormatting(transparent: transparent))
    }
    func navigationButtonStyle(
        foregroundColor: Color,
        backgroundColor: Color,
        glareColor: Color,
        cornerRadius: CGFloat = 3,
        outerPadding: CGFloat = 3,
        shadowRadius: CGFloat = 3,
        shadowX: CGFloat = -5,
        shadowY: CGFloat = 5,
        blinking: Bool = false
    ) -> some View {
        self
            .if(!blinking){ view in
                view.modifier(NavigationButtonStyle(
                    foregroundColor: foregroundColor,
                    backgroundColor: backgroundColor,
                    glareColor: glareColor,
                    cornerRadius: cornerRadius,
                    outerPadding: outerPadding,
                    shadowRadius: shadowRadius,
                    shadowX: shadowX,
                    shadowY: shadowY
                ))
            }
            .if(blinking){ view in
                view.modifier(BlinkingNavigationButtonStyle(
                    foregroundColor: foregroundColor,
                    backgroundColor: backgroundColor,
                    glareColor: glareColor,
                    cornerRadius: cornerRadius,
                    outerPadding: outerPadding,
                    shadowRadius: shadowRadius,
                    shadowX: shadowX,
                    shadowY: shadowY
                ))
            }
    }
    func navigationButtonStyle_mainFeatures(isDisabled: Bool, Blinking: Bool, Pulsation: Bool = false) -> some View {
        self
            .if(Blinking){view in
                view.navigationButtonStyle(
                    foregroundColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    backgroundColor: isDisabled ? MasterColorSchema.color_dark_gray : MasterColorSchema.color_dark_1,
                    glareColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    cornerRadius: 8,
                    outerPadding: 1,
                    shadowRadius: 4,
                    shadowX: 0,
                    shadowY: 2,
                    blinking: Blinking
                )
                .if(Pulsation){view in
                    view.pulsation(pulsation: .constant(Pulsation))
                }
                .if(!Pulsation){view in
                    view.pulsation(pulsation: .constant(Pulsation))
                }
            }
            .if(!Blinking){view in
                view.navigationButtonStyle(
                    foregroundColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    backgroundColor: isDisabled ? MasterColorSchema.color_dark_gray : MasterColorSchema.color_dark_1,
                    glareColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    cornerRadius: 8,
                    outerPadding: 1,
                    shadowRadius: 4,
                    shadowX: 0,
                    shadowY: 2,
                    blinking: Blinking
                )
            }
            .disabled(isDisabled)
    }
    func navigationButtonStyle_serviceFeatures(isDisabled: Bool, Blinking: Bool, Pulsation: Bool = false) -> some View {
        self
            .if(Blinking){view in
                view.navigationButtonStyle(
                    foregroundColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    backgroundColor: isDisabled ? MasterColorSchema.color_dark_gray : MasterColorSchema.color_dark_1,
                    glareColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    cornerRadius: 8,
                    outerPadding: 1,
                    shadowRadius: 4,
                    shadowX: 0,
                    shadowY: 2,
                    blinking: Blinking
                )
                .if(Pulsation){view in
                    view.pulsation(pulsation: .constant(Pulsation))
                }
                .if(!Pulsation){view in
                    view.pulsation(pulsation: .constant(Pulsation))
                }
            }
            .if(!Blinking){view in
                view.navigationButtonStyle(
                    foregroundColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    backgroundColor: isDisabled ? MasterColorSchema.color_dark_gray : MasterColorSchema.color_dark_1,
                    glareColor: isDisabled ? MasterColorSchema.color_bright_gray : MasterColorSchema.color_bright_1,
                    cornerRadius: 8,
                    outerPadding: 1,
                    shadowRadius: 4,
                    shadowX: 0,
                    shadowY: 2,
                    blinking: Blinking
                )
            }
            .disabled(isDisabled)
    }
    func sectionHeaderStyleWithGlare(
        font: Font = .title,
        textColor: Color = MasterColorSchema.mainSubTitle,
        shadowColor: Color = MasterColorSchema.mainTitle,
        shadowRadius: CGFloat = 3,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 2,
        paddingTop: CGFloat = 30,
        padding: CGFloat = 10
    ) -> some View {
        self.modifier(SectionHeaderStyle(
            font: font,
            textColor: textColor,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius,
            shadowX: shadowX,
            shadowY: shadowY,
            paddingTop: paddingTop,
            padding: padding
        ))
    }
    func navigationTitleWithGlare(_ name: String) -> some View {
        self.toolbar {
            ToolbarItem(placement: .principal) {
                Text(name)
                    .font(.largeTitle)
                    .foregroundColor(Color.titleText)
                    .shadow(color: Color.cardShadow, radius: 3, x: 0, y: 2)
            }
        }
    }
    func popupTitleWithGlare(_ name: String, theme: ThemeManager) -> some View {
        self.toolbar {
            ToolbarItem(placement: .principal) {
                Text(name)
                    .NG_textStyling(.NG_TextStyle_Title_Sheet, theme: theme)
                /*
                    .font(.title)
                    .foregroundColor(Color.titleText)
                    .shadow(color: Color.cardShadow, radius: 3, x: 0, y: 2)
                 */
            }
        }
    }
    
    func customBackground(
        blinking: Bool,
        baseColor: Color,
        fadedColor: Color
    ) -> some View {
        self.modifier(BackgroundViewModifier(
            blinking: blinking,
            baseColor: baseColor,
            fadedColor: fadedColor
        ))
    }
    
    /*
     func color_dark_default(blinking: Bool, faded: Bool) -> some View {
     self.customTint(
     blinking: blinking,
     faded: faded,
     baseColor: MasterColorSchema.color_dark_1,
     fadedColor: MasterColorSchema.color_dark_gray,
     baseShadowRadius: 5,
     fadedShadowRadius: 0,
     shadowOffset: CGSize(width: 0, height: 2)
     )
     }
     */
    
    /*
     func customTint(
     blinking: Bool,
     faded: Bool,
     baseColor: Color,
     fadedColor: Color,
     baseShadowRadius: CGFloat,
     fadedShadowRadius: CGFloat,
     shadowOffset: CGSize = CGSize(width: 0, height: 2)
     ) -> some View {
     self
     .if(!blinking){ view in
     view
     .modifier(ColorViewModifier(
     faded: faded,
     baseColor: baseColor,
     fadedColor: fadedColor
     ))
     }
     .if(blinking){ view in
     view
     .modifier(ColorViewModifierWithGlare(
     blinking: blinking,
     faded: faded,
     baseColor: baseColor,
     fadedColor: fadedColor,
     baseShadowRadius: baseShadowRadius,
     fadedShadowRadius: fadedShadowRadius,
     shadowOffset: shadowOffset
     ))
     }
     }
     */
    
    func customRoundedBackground(
        blinking: Bool,
        baseColor: Color,
        fadedColor: Color,
        cornerRadius: CGFloat
    ) -> some View {
        self
            .if(blinking){ view in
                view.modifier(RoundedBackgroundViewModifier(
                    blinking: blinking,
                    baseColor: baseColor,
                    fadedColor: fadedColor,
                    cornerRadius: cornerRadius
                ))
            }
            .if(!blinking){ view in
                view.modifier(RoundedBackgroundViewModifier(
                    blinking: blinking,
                    baseColor: baseColor,
                    fadedColor: fadedColor,
                    cornerRadius: cornerRadius
                ))
            }
    }
    
    func customTintWithGlare(
        blinking: Bool,
        faded: Bool,
        baseColor: Color,
        fadedColor: Color,
        baseShadowRadius: CGFloat,
        fadedShadowRadius: CGFloat,
        shadowOffset: CGSize = CGSize(width: 0, height: 2)
    ) -> some View {
        self.modifier(ColorViewModifierWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: baseColor,
            fadedColor: fadedColor,
            baseShadowRadius: baseShadowRadius,
            fadedShadowRadius: fadedShadowRadius,
            shadowOffset: shadowOffset
        ))
    }
    
    func customTint(
        blinking: Bool,
        faded: Bool,
        baseColor: Color,
        fadedColor: Color,
        baseShadowRadius: CGFloat,
        fadedShadowRadius: CGFloat,
        shadowOffset: CGSize = CGSize(width: 0, height: 2)
    ) -> some View {
        self
            .if(!blinking){ view in
                view
                    .modifier(ColorViewModifier(
                        faded: faded,
                        baseColor: baseColor,
                        fadedColor: fadedColor
                    ))
            }
            .if(blinking){ view in
                view
                    .modifier(ColorViewModifierWithGlare(
                        blinking: blinking,
                        faded: faded,
                        baseColor: baseColor,
                        fadedColor: fadedColor,
                        baseShadowRadius: baseShadowRadius,
                        fadedShadowRadius: fadedShadowRadius,
                        shadowOffset: shadowOffset
                    ))
            }
    }
    
    func pulsation(pulsation: Binding<Bool>, scale: Binding<CGFloat> = .constant(1.2)) -> some View {
        self
            .if(pulsation.wrappedValue){ view in
                view.modifier(PulsationViewModifier(
                    pulsating: pulsation, baseScale: .constant(1.0), bigScale: scale
                ))
            }
            .if(!pulsation.wrappedValue){ view in
                view.modifier(PulsationViewModifier(
                    pulsating: pulsation, baseScale: .constant(1.0), bigScale: scale
                ))
            }
    }
    
    func color_bright_default_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_1,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_bad_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_red,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_good_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_green,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_attention_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_orange,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_most_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_most,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_default_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_1,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_bad_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_red,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_good_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_green,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_attention_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_orange,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_most_glare(blinking: Bool, faded: Bool) -> some View {
        self.customTintWithGlare(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_most,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_default(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_1,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_bad(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_red,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_good(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_green,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_attention(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_orange,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_bright_most(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_bright_most,
            fadedColor: MasterColorSchema.color_bright_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_default(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_1,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_bad(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_red,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_good(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_green,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_attention(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_orange,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func color_dark_most(blinking: Bool, faded: Bool) -> some View {
        self.customTint(
            blinking: blinking,
            faded: faded,
            baseColor: MasterColorSchema.color_dark_most,
            fadedColor: MasterColorSchema.color_dark_gray,
            baseShadowRadius: 5,
            fadedShadowRadius: 0,
            shadowOffset: CGSize(width: 0, height: 2)
        )
    }
    
    func styledDatePicker() -> some View {
        self.modifier(DatePickerModifier(backgroundColor: MasterColorSchema.color_dark_2, textColor: MasterColorSchema.color_bright_1))
    }
    
    @ViewBuilder func applyTextColor(_ color: Color) -> some View {
        if UITraitCollection.current.userInterfaceStyle == .light {
            self.colorInvert().colorMultiply(color)
        } else {
            self.colorMultiply(color)
        }
    }
    
    func customTextFieldStyle(
        backgroundColor: Color = MasterColorSchema.color_bright_most,
        textColor: Color = MasterColorSchema.color_dark_most,
    ) -> some View {
        self.modifier(CustomTextFieldModifier(
            backgroundColor: backgroundColor,
            textColor: textColor
        ))
    }
    
    func cardStyle(backgroundColor: Color, shadowColor: Color, borderDark: Color, borderBright: Color) -> some View {
        self.modifier(CardStyle(backgroundColor: backgroundColor, shadowColor: shadowColor, borderDark: borderDark, borderBright: borderBright))
    }
}
*/

/*
struct CardStyle: ViewModifier {
    let backgroundColor: Color
    let shadowColor: Color
    let borderDark: Color
    let borderBright: Color
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(backgroundColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderBright, lineWidth: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderDark, lineWidth: 1)
            )
            .shadow(color: shadowColor, radius: 10, x: 0, y: 4)
    }
}
*/
/*
struct ColorViewModifierWithGlare: ViewModifier {
    let blinking: Bool
    let faded: Bool
    let baseColor: Color
    let fadedColor: Color
    let baseShadowRadius: CGFloat
    let fadedShadowRadius: CGFloat
    let shadowOffset: CGSize
    
    @State private var isBlinking = false
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                faded ? fadedColor : baseColor
            )
            .if((faded && fadedShadowRadius != 0) || (!faded && baseShadowRadius != 0)) { view in
                view.shadow(
                    color: blinking ?
                        (isBlinking ? fadedColor : baseColor)
                        : (faded ? fadedColor : baseColor),
                    radius: blinking ?
                        (isBlinking ? fadedShadowRadius : baseShadowRadius)
                        : (faded ? fadedShadowRadius : baseShadowRadius),
                    x: blinking ? (isBlinking ? 0 : shadowOffset.width) : shadowOffset.width,
                    y: blinking ? (isBlinking ? 0 : shadowOffset.height) : shadowOffset.height
                )
            }
            .onAppear {
                guard blinking else { return }
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isBlinking.toggle()
                }
            }
    }
}
*/
/*
struct ColorViewModifier: ViewModifier {
    let faded: Bool
    let baseColor: Color
    let fadedColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(faded ? fadedColor : baseColor)
    }
}
*/
/*
struct PulsationViewModifier: ViewModifier {
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
*/
/*
struct BackgroundViewModifier: ViewModifier {
    let blinking: Bool
    let baseColor: Color
    let fadedColor: Color
    
    @State private var isBlinking = false
    
    func body(content: Content) -> some View {
        content
            .background(
                blinking ?
                    (isBlinking ? fadedColor : baseColor)
                    : (baseColor)
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isBlinking = true
                }
            }
    }
}
*/
/*
struct RoundedBackgroundViewModifier: ViewModifier {
    let blinking: Bool
    let baseColor: Color
    let fadedColor: Color
    let cornerRadius: CGFloat
    
    @State private var isBlinking = false
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        blinking ?
                            (isBlinking ? fadedColor : baseColor)
                            : (baseColor)
                    )
            )
            .onAppear {
                guard blinking else { return }
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isBlinking.toggle()
                }
            }
    }
}
*/
/*
struct SheetContentFormatting: ViewModifier {
    var transparent: Bool
    func body(content: Content) -> some View {
        content
            .cardStyle(backgroundColor: .cardBackground.opacity(0.95), shadowColor: .cardShadow, borderDark: .cardBorderDark, borderBright: .cardBorderBright)
            .padding(.top)
            .padding(.horizontal)
            .presentationBackground(Color.clear)
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(true)
            .ignoresSafeArea(.keyboard)
    }
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
struct BlinkingNavigationButtonStyle: ViewModifier {
    let foregroundColor: Color
    let backgroundColor: Color
    let glareColor: Color
    let cornerRadius: CGFloat
    let outerPadding: CGFloat
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    
    @State private var isBlinking = false

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .padding(outerPadding)
            .shadow(
                color: isBlinking ? glareColor : glareColor.opacity(0.3),
                radius: shadowRadius,
                x: shadowX,
                y: shadowY
            )
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isBlinking.toggle()
                }
            }
    }
}
*/
/*
struct SectionHeaderStyle: ViewModifier {
    let font: Font
    let textColor: Color
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    let paddingTop: CGFloat
    let padding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
            .padding(.top, paddingTop)
            .padding(padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(textColor)
    }
}
 */
/*
struct DatePickerModifier: ViewModifier {
    var backgroundColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(backgroundColor))
            .foregroundColor(textColor)
    }
}
*/
/*
struct CustomTextFieldModifier: ViewModifier {
    var backgroundColor: Color
    var textColor: Color
    var cornerRadius: CGFloat = 6
    var padding: CGFloat = 5
    @EnvironmentObject var theme: ThemeManager

    func body(content: Content) -> some View {
        content
            //.padding(padding)
            .background(/*backgroundColor*/theme.currentTheme.NG_Color_DatePicker_Background)
            .foregroundColor(/*textColor*/theme.currentTheme.NG_Color_DatePicker_Foreground)
            .cornerRadius(cornerRadius)
    }
}
*/
