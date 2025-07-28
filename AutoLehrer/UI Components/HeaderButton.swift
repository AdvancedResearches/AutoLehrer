import SwiftUI

struct HeaderButton: View {
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "en"
    var text: String
    var action: () -> Void
    var tint: NG_TextColor = .NG_TextColor_Regular
    var forPopUp: Bool = false
    var darkMode: Bool = false
    var blinking: Bool = false
    var body: some View {
        HStack {
            Text(text.localized(for: language))
                .NG_textStyling(.NG_TextStyle_Text_Regular, noShadow: true, glare: true, theme: theme)
                .onTapGesture {
                    action()
                }
        }
    }
}
