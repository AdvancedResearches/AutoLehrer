import SwiftUI

struct BackButton: View {
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "ru"
    var action: () -> Void
    var forPopUp: Bool = false
    var darkMode: Bool = false
    var blinking: Bool = false
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .NG_iconStyling(.NG_IconStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
            Text("Назад")
                .NG_textStyling(.NG_TextStyle_Text_Regular, noShadow: true, glare: true, theme: theme)
        }
        .onTapGesture {
            action()
        }
    }
}
